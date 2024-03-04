// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/AddressArray.sol] Updated version 0.0.6

pragma solidity ^0.8.20;

/**
 * @title Address Array Tools
 * @dev Utilities for working with arrays in Solidity
 */
library AddressArray {
        
    function last(address[] memory inputArray) internal pure returns (uint256) {
         return inputArray.length - 1;
    }

    function push(address[] memory inputArray, address data) internal pure returns (address[] memory) {
        address[] memory outputArray = new address[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pop(address[] memory inputArray) internal pure returns (address[] memory) {
        address[] memory outputArray = new address[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function shift(address[] memory inputArray) internal pure returns (address[] memory) {
        address[] memory outputArray = new address[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function unshift(address[] memory inputArray) internal pure returns (address[] memory) {
        address[] memory outputArray = new address[](inputArray.length + 1);

        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i+1] = inputArray[i];
        }

        return outputArray;
    }
    
}