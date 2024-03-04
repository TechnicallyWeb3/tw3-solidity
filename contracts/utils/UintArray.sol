// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/UintArray.sol] Updated version 0.0.6

pragma solidity ^0.8.20;

/**
 * @title Uint Array Tools
 * @dev Utilities for working with arrays in Solidity
 */
library UintArray {
        
    function last(uint[] memory inputArray) internal pure returns (uint256) {
         return inputArray.length - 1;
    }

    function push(uint[] memory inputArray, uint data) internal pure returns (uint[] memory) {
        uint[] memory outputArray = new uint[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pop(uint[] memory inputArray) internal pure returns (uint[] memory) {
        uint[] memory outputArray = new uint[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function shift(uint[] memory inputArray) internal pure returns (uint[] memory) {
        uint[] memory outputArray = new uint[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function unshift(uint[] memory inputArray) internal pure returns (uint[] memory) {
        uint[] memory outputArray = new uint[](inputArray.length + 1);

        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i+1] = inputArray[i];
        }

        return outputArray;
    }

}