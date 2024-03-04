// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/IntArray.sol] Updated version 0.0.6

pragma solidity ^0.8.20;

/**
 * @title Int Array Tools
 * @dev Utilities for working with arrays in Solidity
 */
library IntArray {
        
    function last(int[] memory inputArray) internal pure returns (uint256) {
         return inputArray.length - 1;
    }

    function push(int[] memory inputArray, int data) internal pure returns (int[] memory) {
        int[] memory outputArray = new int[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pop(int[] memory inputArray) internal pure returns (int[] memory) {
        int[] memory outputArray = new int[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function shift(int[] memory inputArray) internal pure returns (int[] memory) {
        int[] memory outputArray = new int[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function unshift(int[] memory inputArray) internal pure returns (int[] memory) {
        int[] memory outputArray = new int[](inputArray.length + 1);

        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i+1] = inputArray[i];
        }

        return outputArray;
    }
    
}