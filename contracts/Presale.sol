pragma solidity ^0.8.9;
//SPDX-License-Identifier: MIT

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Presale {

    IERC20 immutable public token;
    address immutable public owner;
    bool public isFinished;

    mapping (address => uint256) bids;
    uint256 maxBid;
    uint256 totalBid;
    uint256 totalSupply;

    constructor(address _token) {
        token = IERC20(_token);
        owner = msg.sender;
        isFinished = false;
    }

    function getBid(address who) public view returns(uint256) {
        return(bids[who]);
    }

    function getTotalBid() public view returns(uint256) {
        return(totalBid);
    }
    
    function getMaxBid() public view returns(uint256) {
        return(maxBid);
    }

    function getTotalSupply() public view returns(uint256) {
        return(token.balanceOf(address(this)));
    }

    function increaseBid() external payable {
        uint256 bid = msg.value;
        require(msg.value > 0, "Amount must be higher than zero");
        require(!isFinished, "Presale has finished");
        totalBid = totalBid + bid;
        bids[msg.sender] = bids[msg.sender] + bid;
        
        if (bids[msg.sender] > maxBid) {
            maxBid = bids[msg.sender];
        }
    }

    function decreaseBid(uint256 bid) external {
        uint256 currentBid = bids[msg.sender];
        require(bid <= currentBid, "Amount can't be higher than current bid");
        require(!isFinished, "Presale has finished");
        bids[msg.sender] = currentBid - bid;
        totalBid = totalBid - bid;
        // Send the money after state was updated
        bool sent = payable(msg.sender).send(bid);
        require(sent, "Failed to send BCH");
    }

    function finishPresale() external {
        require(msg.sender == owner, "Can only be called by the owner");
        totalSupply = token.balanceOf(address(this));
        require(totalSupply > 0, "Token supply has to be higher than 0");
        isFinished = true;
        bool sent = payable(owner).send(totalBid);
        require(sent, "Failed to send BCH");
    }

    // Used to withdraw tokens after the presale has ended.
    function withdraw() external {
        require(isFinished, "Presale has not finished yet");
        address who = msg.sender;
        uint256 bid = bids[who];
        uint256 share = (totalSupply / totalBid) * bid;
        bids[who] = 0;
        if (share > 0) {
            token.transfer(who, share);
        }
    }

}
