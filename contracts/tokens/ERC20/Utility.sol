// SPDX-License-Identifier: MIT
// TechnicallyWeb3[tokens/ERC20/Base.sol] Updated version 0.0.10
pragma solidity ^0.8.20;

import "./Base.sol";

/**
 * @title UtilityERC20
 * @dev Abstract contract extending ERC20 with utility functions for tracking deposited and spent amounts.
 * These amounts can be used by smart contracts to allow users to be able to spend ERC20 tokens on contracts, 
 * not just Ether. 
 */
abstract contract UtilityERC20 is ERC20 {

    /**
     * @dev Mapping to track the amount deposited by each user for each utility contract.
     */
    mapping (address utility => mapping (address user => uint256)) public _depositedAmount;

    /**
     * @dev Mapping to track the amount spent by each user for each utility contract.
     * Public to allow children contracts to modify this value in an overriden _update function.
     * Should otherwise be used with caution.
     */
    mapping (address utility => mapping (address user => uint256)) public _spentAmount;

    /**
     * @dev Updates deposited and spent amounts when transfers occur.
     * @param from The address from which tokens are transferred.
     * @param to The address to which tokens are transferred.
     * @param value The amount of tokens transferred.
     */
    function _update(address from, address to, uint256 value) internal virtual override {
        if (from != address(0) && to.code.length > 0) {
            _senderDeposit(to, from, value);
        }
        super._update(from, to, value);
    }

    /**
     * @dev Internal function to deposit tokens for a user.
     * @param utility The address of the utility contract.
     * @param user The address of the user.
     * @param value The amount of tokens to deposit.
     */
    function _senderDeposit(address utility, address user, uint256 value) internal virtual {
        _depositedAmount[utility][user] += value;
    }

    /**
     * @dev Allows the sender to spend tokens on behalf of a user.
     * @param user The address of the user whose tokens are being spent.
     * @param value The amount of tokens being spent.
     */
    function senderSpend(address user, uint256 value) public {
        _senderSpend(msg.sender, user, value);
    }

    /**
     * @dev Internal function to spend tokens on behalf of a user.
     * @param user The address of the user whose tokens are being spent.
     * @param utility The address of the utility contract.
     * @param value The amount of tokens being spent.
     */
    function _senderSpend(address utility, address user, uint256 value) internal virtual {
        if (value < _depositedAmount[utility][user]) {
            revert ERC20InsufficientBalance(user, _depositedAmount[utility][user], value);
        }
        if (user != address(0) && utility.code.length > 0) {
            _spentAmount[utility][user] += value;
        }
    }

    /**
     * @dev Returns the balance of a user for a specific utility contract.
     * @param user The address of the user.
     * @return The remaining balance of the user for the specified utility contract.
     */
    function userBalance(address user) public returns (uint256) {
        return _userBalance(msg.sender, user);
    }

    /**
     * @dev Internal function to calculate the balance of a user for a specific utility contract.
     * @param user The address of the user.
     * @param utility The address of the utility contract.
     * @return The remaining balance of the user for the specified utility contract.
     */
    function _userBalance(address utility, address user) internal virtual returns (uint256) {
        return _depositedAmount[utility][user] - _spentAmount[utility][user];
    }
    
}
