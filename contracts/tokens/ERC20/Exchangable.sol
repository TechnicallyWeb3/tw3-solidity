// SPDX-License-Identifier: MIT
// TechnicallyWeb3[tokens/ERC20/Exchangable.sol] Updated version 0.0.10
pragma solidity ^0.8.20;

import "./Base.sol";

/**
 * @title ExchangableERC20
 * @dev A contract facilitating the exchange of ERC20 tokens and Ethereum coins (Ether) based on a specified exchange rate.
 * This contract extends the ERC20 functionality provided by the `Base.sol` contract.
 */
abstract contract ExchangableERC20 is ERC20 {
    // Exchange rate parameters
    uint256 private rateValue; // The value of 1 token in terms of coins (Ether)
    uint256 private rateDecimal; // The decimal precision of the exchange rate

    /**
     * @dev Constructor to initialize the contract with a given name, symbol, exchange rate value, and decimal precision.
     * @param name_ The name of the ERC20 token.
     * @param symbol_ The symbol (ticker) of the ERC20 token.
     * @param rateValue_ The value of 1 token in terms of coins (Ether).
     * @param rateDecimal_ The decimal precision of the exchange rate.
     */
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 rateValue_,
        uint256 rateDecimal_
    ) ERC20(name_, symbol_) {
        rateValue = rateValue_;
        rateDecimal = rateDecimal_;
    }

    /**
     * @dev Fallback function to allow the contract to receive Ether. It triggers the exchangeCoin function.
     */
    receive() external payable {
        exchangeCoin();
    }

    /**
     * @dev Function to exchange Ethereum coins (Ether) for ERC20 tokens based on the current exchange rate.
     */
    function exchangeCoin() public payable virtual {
        _exchangeCoin(msg.sender, msg.value);
    }

    /**
     * @dev Internal function to perform the exchange of Ethereum coins (Ether) for ERC20 tokens.
     * @param account The account to receive the exchanged tokens.
     * @param value The amount of Ethereum coins (Ether) sent for exchange.
     */
    function _exchangeCoin(address account, uint256 value) internal virtual {
        uint256 tokenAmount = _getTokenAmount(value);
        _mint(account, tokenAmount);
    }

    /**
     * @dev Internal function to perform the exchange of ERC20 tokens for Ethereum coins (Ether).
     * @param account The account from which tokens are exchanged.
     * @param amount The amount of tokens to exchange.
     */
    function _exchangeToken(address account, uint256 amount) internal virtual {
        _burn(account, amount);
        uint256 coinValue = _getCoinValue(amount);
        (bool success, ) = account.call{value: coinValue}("");
        require(success, "Transfer to recipient failed");
    }

    /**
     * @dev Internal function to calculate the amount of tokens to be minted based on the provided value of Ethereum coins (Ether).
     * @param value The value of Ethereum coins (Ether) to exchange for tokens.
     * @return The calculated amount of tokens to be minted.
     */
    function _getTokenAmount(uint256 value) internal virtual returns (uint256) {
        return value * rateValue / (10 ** rateDecimal);
    }

    /**
     * @dev Internal function to calculate the value of Ethereum coins (Ether) to be transferred based on the provided amount of tokens.
     * @param amount The amount of tokens to exchange for Ethereum coins (Ether).
     * @return The calculated value of Ethereum coins (Ether) to be transferred.
     */
    function _getCoinValue(uint256 amount) internal virtual returns (uint256) {
        // returns 0 if rateValue is 0 to prevent divide by 0 error.
        return rateValue == 0 ? 0 : amount / rateValue * (10 ** rateDecimal);
    }

    /**
     * @dev Sets the exchange rate value and decimal precision.
     * @param value The new exchange rate value.
     * @param decimal The decimal precision for the exchange rate.
     * @notice This function is internal and virtual, allowing derived contracts to customize rate setting logic.
     * @dev It updates the `rateValue` and `rateDecimal` variables with the provided values.
     * @dev This function should be overridden in derived contracts if specific rate-setting behavior is required.
     */
    function _setRate(uint256 value, uint8 decimal) internal virtual {
        rateValue = value;
        rateDecimal = decimal;
    }

    /**
     * @dev Internal function to handle token transfers between accounts.
     * Overrides the same function in the ERC20 contract to allow exchanging tokens for Ethereum coins (Ether).
     * If sent to this contract address automatically exchanges for coins.
     * @param from The address transferring tokens.
     * @param to The address receiving tokens.
     * @param value The amount of tokens to transfer.
     */
    function _update(address from, address to, uint256 value) internal virtual override {
        if (to == address(this)) {
            _exchangeToken(from, value);
        } else {
            super._update(from, to, value);
        }
        
    }
}
