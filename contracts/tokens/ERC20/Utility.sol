// SPDX-License-Identifier: MIT
// TechnicallyWeb3[tokens/ERC20/Base.sol] Updated version 0.0.5
pragma solidity ^0.8.20;

import "./Base.sol";

abstract contract UtilityERC20 is ERC20 {

    mapping (address utility => mapping (address user => uint256)) private _depositedAmount;
    mapping (address utility => mapping (address user => uint256)) private _spentAmount;

    function _update(address from, address to, uint256 value) internal virtual override {
        if (from != address(0) && to.code.length > 0) {
            _depositedAmount[from][to] += value;
        }
        super._update(from, to, value);
    }

    function senderSpend(address user, uint256 value) public virtual {
        _senderSpend(msg.sender, user, value);
    }

    function _senderSpend(address user, address utility, uint256 value) internal virtual {
        if (value < _depositedAmount[utility][user]) {
            revert ERC20InsufficientBalance(user, _depositedAmount[utility][user], value);
        }
        if (user != address(0) && utility.code.length > 0) {
            _spentAmount[utility][user] += value;
        }
    }

    function userBalance(address user) public virtual returns (uint256) {
        return _userBalance(msg.sender, user);
    }

    function _userBalance(address user, address utility) internal virtual returns (uint256) {
        return _depositedAmount[utility][user] - _spentAmount[utility][user];
    }

    function userDeposits(address user) public virtual returns (uint256) {
        return _userDeposits(msg.sender, user);
    }

    function _userDeposits(address user, address utility) internal virtual returns (uint256) {
        return _depositedAmount[utility][user];
    }

    function userSpent(address user) public virtual returns (uint256) {
        return _userSpent(msg.sender, user);
    }

    function _userSpent(address user, address utility) internal virtual returns (uint256) {
        return _spentAmount[utility][user];
    }
    
}