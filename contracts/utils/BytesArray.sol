// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/BytesArray.sol] Updated version 0.0.6

pragma solidity ^0.8.20;

/**
 * @title Bytes Array Tools
 * @dev Utilities for working with arrays in Solidity
 */
library BytesArray {
        
    function last(bytes[] memory inputArray) internal pure returns (uint256) {
         return inputArray.length - 1;
    }

    function push(bytes[] memory inputArray, bytes memory data) internal pure returns (bytes[] memory) {
        bytes[] memory outputArray = new bytes[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pop(bytes[] memory inputArray) internal pure returns (bytes[] memory) {
        bytes[] memory outputArray = new bytes[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function shift(bytes[] memory inputArray) internal pure returns (bytes[] memory) {
        bytes[] memory outputArray = new bytes[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function unshift(bytes[] memory inputArray) internal pure returns (bytes[] memory) {
        bytes[] memory outputArray = new bytes[](inputArray.length + 1);

        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i+1] = inputArray[i];
        }

        return outputArray;
    }
    
}