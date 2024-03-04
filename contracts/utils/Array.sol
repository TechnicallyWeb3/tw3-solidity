// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/Array.sol] Updated version 0.0.6

pragma solidity ^0.8.20;

/**
 * @title Array Tools
 * @dev Utilities for working with arrays in Solidity
 */
library Array {

    function last(bool[] memory inputArray) internal pure returns (uint256) {
         return inputArray.length - 1;
    }
    
    function last(uint[] memory inputArray) internal pure returns (uint256) {
         return inputArray.length - 1;
    }

    function last(int[] memory inputArray) internal pure returns (uint256) {
         return inputArray.length - 1;
    }

    function last(address[] memory inputArray) internal pure returns (uint256) {
         return inputArray.length - 1;
    }

    function last(string[] memory inputArray) internal pure returns (uint256) {
         return inputArray.length - 1;
    }

    function last(bytes[] memory inputArray) internal pure returns (uint256) {
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
    
    function push(uint[] memory inputArray, uint data) internal pure returns (uint[] memory) {
        uint[] memory outputArray = new uint[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function push(int[] memory inputArray, int data) internal pure returns (int[] memory) {
        int[] memory outputArray = new int[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function push(address[] memory inputArray, address data) internal pure returns (address[] memory) {
        address[] memory outputArray = new address[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function push(string[] memory inputArray, string memory data) internal pure returns (string[] memory) {
        string[] memory outputArray = new string[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function push(bytes[] memory inputArray, bytes memory data) internal pure returns (bytes[] memory) {
        bytes[] memory outputArray = new bytes[](inputArray.length + 1);
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

    function pop(uint[] memory inputArray) internal pure returns (uint[] memory) {
        uint[] memory outputArray = new uint[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function pop(int[] memory inputArray) internal pure returns (int[] memory) {
        int[] memory outputArray = new int[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function pop(address[] memory inputArray) internal pure returns (address[] memory) {
        address[] memory outputArray = new address[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function pop(string[] memory inputArray) internal pure returns (string[] memory) {
        string[] memory outputArray = new string[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function pop(bytes[] memory inputArray) internal pure returns (bytes[] memory) {
        bytes[] memory outputArray = new bytes[](inputArray.length - 1);
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

    function shift(uint[] memory inputArray) internal pure returns (uint[] memory) {
        uint[] memory outputArray = new uint[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
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

    function shift(address[] memory inputArray) internal pure returns (address[] memory) {
        address[] memory outputArray = new address[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
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

    function shift(bytes[] memory inputArray) internal pure returns (bytes[] memory) {
        bytes[] memory outputArray = new bytes[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

}