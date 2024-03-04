// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/BoolArray.sol] Updated version 0.0.6

pragma solidity ^0.8.20;

/**
 * @title Bool Array Tools
 * @dev Utilities for working with arrays in Solidity
 */
library BoolArray {
        
    function last(bool[] memory inputArray) internal pure returns (uint256) {
         return inputArray.length - 1;
    }

    function push(bool[] memory inputArray, bool data) internal pure returns (bool[] memory) {
        bool[] memory outputArray = new bool[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pop(bool[] memory inputArray) internal pure returns (bool[] memory) {
        bool[] memory outputArray = new bool[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function shift(bool[] memory inputArray) internal pure returns (bool[] memory) {
        bool[] memory outputArray = new bool[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function unshift(bool[] memory inputArray) internal pure returns (bool[] memory) {
        bool[] memory outputArray = new bool[](inputArray.length + 1);

        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i+1] = inputArray[i];
        }

        return outputArray;
    }
    
}