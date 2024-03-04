// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/StringArray.sol] Updated version 0.0.6

pragma solidity ^0.8.20;

/**
 * @title String Array Tools
 * @dev Utilities for working with arrays in Solidity
 */
library StringArray {
        
    function last(string[] memory inputArray) internal pure returns (uint256) {
         return inputArray.length - 1;
    }

    function push(string[] memory inputArray, string memory data) internal pure returns (string[] memory) {
        string[] memory outputArray = new string[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pop(string[] memory inputArray) internal pure returns (string[] memory) {
        string[] memory outputArray = new string[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function shift(string[] memory inputArray) internal pure returns (string[] memory) {
        string[] memory outputArray = new string[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function unshift(string[] memory inputArray) internal pure returns (string[] memory) {
        string[] memory outputArray = new string[](inputArray.length + 1);

        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i+1] = inputArray[i];
        }

        return outputArray;
    }
    
}