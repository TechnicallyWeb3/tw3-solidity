// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/Conversion.sol] Updated version 0.0.7

pragma solidity ^0.8.20;

/**
 * @title Conversion Tools
 * @dev Utilities for converting between types in Solidity
 */

 library Conversion {

    function toUint(string memory inputString) internal pure returns (uint256) {
        return toUint(bytes(inputString));
    }

    function toUint(bytes memory inputBytes) internal pure returns (uint256) {
        uint256 number;

        for (uint256 i; i < inputBytes.length; i++) {
            require(uint8(inputBytes[i]) >= 48 && uint8(inputBytes[i]) <= 57, "inputBytes must only consist of positive integers");
            number = number * 10 + (uint8(inputBytes[i]) - 48);
        }

        return number;
    }

 }