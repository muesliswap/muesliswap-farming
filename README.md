# Muesliswap Farming

This repository contains the Farming contracts used by MuesliSwap. Liquidity pools are initialized and added as a staking token to the MasterFarmer contract. This MasterFarmer contract is also in control of the number of minted $Milk per block. As users stake LP and other tokens, the MasterFarmer distributes them according to the weight of rewards of a specific pool along with an accounts stake in that pool.

https://muesliswap.com. 

## Solidity Standard Input
With the help of solt we can easily verify our contracts on Etherscan: https://github.com/hjubb/solt

## Updates to MasterFarmer
As MasterFarmer is a fork of ApeSwap's MasterApe, a fork of Pancake's MasterChef, we want to be transparent about the updates that have been made: https://www.diffchecker.com/XSrDXXBe

- Migrator Function removed: This function has been used in rug pulls before and as we want to build trust in the community we have decided to remove this. We don't claim to be the first, but we agree with the decision. 
- Farm safety checks. When setting allocations for farms, if a pool is added twice it can cause inconsistencies.
- Helper view functions. View functions can only read data from the contract, but not alter anything which means these can not be used for attacks. 
- Only one admin. A recent project was exploited that used multiple forms of admins to control the project. An admin function that was not timelocked was used to make the exploit. We want the timelock to have full control over the contract so there are no surprises

## Updates BNBRewardFarmer
BNBRewardFarmer contract is a spin off of Pankcake's SmartChef contract, but will provide a means to distribute BNB for staking tokens in place of a BEP20 token. The updates may be found here: https://www.diffchecker.com/BWzELIHw

## BEP20RewardFarmer
BEP20RewardFarmer contract is similar to the BNBRewardFarmer contract, but it gives out a BEP20 token as the reward in place of BNB. Find the updates from the BNBRewardFarmer here: https://www.diffchecker.com/IYZFKbNf

## BEP20RewardFarmerV2
BEP20RewardFarmerV2 adds two admin functions which allow the pool rewards to be updated allowing the pool to be extended for a longer period of time. https://www.diffchecker.com/h96HRT2L
