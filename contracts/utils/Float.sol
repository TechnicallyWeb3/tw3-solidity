// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/Float.sol] Updated version 0.0.6

pragma solidity ^0.8.20;

import "./Bytes.sol";
import "./Conversion.sol";

struct float {
    int256 value;
    uint8 decimal;
}

/**
 * @title Float Tools
 * @dev Utilities for working with floats in Solidity
 */
library Float {
    using Bytes for bytes;
    using Conversion for *;

    function asFloat(string memory inputString) internal pure returns (float memory) {
        return asFloat(bytes(inputString));
    }

    function asFloat(bytes memory inputBytes) internal pure returns (float memory) {
        bytes[] memory floatParts = inputBytes.split(bytes("."));
        require(floatParts.length < 3, "Malformed float string");

        bytes memory value;
        uint8 decimal;
        if (floatParts.length > 1) {
            value = new bytes(floatParts[0].length + floatParts[1].length);
            for (uint256 i; i < floatParts[0].length; i++) {
                value[i] = floatParts[0][i];
            }
            for (uint256 i; i < floatParts[1].length; i++) {
                value[i] = floatParts[1][i];
            }
            decimal = uint8(floatParts[1].length);
        }

        return float(int256(value.toUint()), decimal);
    }

    function asFloat(uint256 inputUint) internal pure returns (float memory) {
        return float(int(inputUint), 0);
    }

    function add(float memory inputFloat, float memory addFloat) internal pure returns (float memory) {
        // Calculate the sum of the values
        int256 sum = inputFloat.value + addFloat.value;

        // Determine the maximum decimal places between the two floats
        uint8 maxDecimal = inputFloat.decimal > addFloat.decimal ? inputFloat.decimal : addFloat.decimal;

        // Adjust the sum based on the decimal places
        if (inputFloat.decimal < addFloat.decimal) {
            sum *= int256(10 ** (addFloat.decimal - inputFloat.decimal));
        } else if (inputFloat.decimal > addFloat.decimal) {
            sum *= int256(10 ** (inputFloat.decimal - addFloat.decimal));
        }

        // Return the result
        return float(sum, maxDecimal);
    }

    function add(float memory inputFloat, uint256 inputUint) internal pure returns (float memory) {
        return add(inputFloat, float(int256(inputUint), 0));
    }

    function sub(float memory inputFloat, float memory subFloat) internal pure returns (float memory) {
        // Calculate the difference of the values
        int256 diff = inputFloat.value - subFloat.value;

        // Determine the maximum decimal places between the two floats
        uint8 maxDecimal = inputFloat.decimal > subFloat.decimal ? inputFloat.decimal : subFloat.decimal;

        // Adjust the difference based on the decimal places
        if (inputFloat.decimal < subFloat.decimal) {
            diff *= int256(10 ** (subFloat.decimal - inputFloat.decimal));
        } else if (inputFloat.decimal > subFloat.decimal) {
            diff *= int256(10 ** (inputFloat.decimal - subFloat.decimal));
        }

        // Return the result
        return float(diff, maxDecimal);
    }

    function sub(float memory inputFloat, uint256 inputUint) internal pure returns (float memory) {
        return sub(inputFloat, float(int256(inputUint), 0));
    }

    function mul(float memory inputFloat, float memory mulFloat) internal pure returns (float memory) {
        // Calculate the product of the values
        int256 product = inputFloat.value * mulFloat.value;

        // Adjust the product based on the decimal places
        uint8 decimal = inputFloat.decimal + mulFloat.decimal;

        // Return the result
        return float(product, decimal);
    }

    function div(float memory inputFloat, float memory divFloat) internal pure returns (float memory) {
        // Ensure divisor is not zero
        require(divFloat.value != 0, "Division by zero");

        // Calculate the quotient of the values
        int256 quotient = inputFloat.value * int256(10 ** inputFloat.decimal) / divFloat.value;

        // Determine the decimal places for the result
        uint8 decimal = inputFloat.decimal + divFloat.decimal; // 18 is used as an arbitrary precision for division

        // Return the result
        return float(quotient, decimal);
    }

}