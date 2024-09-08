// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/Array.sol] Updated version 0.0.11

pragma solidity ^0.8.20;
// test new functions!
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

    function pushMem(
        bool[] memory inputArray,
        bool data
    ) internal pure returns (bool[] memory) {
        bool[] memory outputArray = new bool[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pushMem(
        uint[] memory inputArray,
        uint data
    ) internal pure returns (uint[] memory) {
        uint[] memory outputArray = new uint[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pushMem(
        int[] memory inputArray,
        int data
    ) internal pure returns (int[] memory) {
        int[] memory outputArray = new int[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pushMem(
        address[] memory inputArray,
        address data
    ) internal pure returns (address[] memory) {
        address[] memory outputArray = new address[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pushMem(
        string[] memory inputArray,
        string memory data
    ) internal pure returns (string[] memory) {
        string[] memory outputArray = new string[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pushMem(
        bytes[] memory inputArray,
        bytes memory data
    ) internal pure returns (bytes[] memory) {
        bytes[] memory outputArray = new bytes[](inputArray.length + 1);
        for (uint256 i; i < inputArray.length; i++) {
            outputArray[i] = inputArray[i];
        }
        outputArray[last(outputArray)] = data;
        return outputArray;
    }

    function pop(
        bool[] memory inputArray
    ) internal pure returns (bool[] memory) {
        bool[] memory outputArray = new bool[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function pop(
        uint[] memory inputArray
    ) internal pure returns (uint[] memory) {
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

    function pop(
        address[] memory inputArray
    ) internal pure returns (address[] memory) {
        address[] memory outputArray = new address[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function pop(
        string[] memory inputArray
    ) internal pure returns (string[] memory) {
        string[] memory outputArray = new string[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function pop(
        bytes[] memory inputArray
    ) internal pure returns (bytes[] memory) {
        bytes[] memory outputArray = new bytes[](inputArray.length - 1);
        for (uint256 i; i < inputArray.length - 1; i++) {
            outputArray[i] = inputArray[i];
        }
        return outputArray;
    }

    function shift(
        bool[] memory inputArray
    ) internal pure returns (bool[] memory) {
        bool[] memory outputArray = new bool[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function shift(
        uint[] memory inputArray
    ) internal pure returns (uint[] memory) {
        uint[] memory outputArray = new uint[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function shift(
        int[] memory inputArray
    ) internal pure returns (int[] memory) {
        int[] memory outputArray = new int[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function shift(
        address[] memory inputArray
    ) internal pure returns (address[] memory) {
        address[] memory outputArray = new address[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function shift(
        string[] memory inputArray
    ) internal pure returns (string[] memory) {
        string[] memory outputArray = new string[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function shift(
        bytes[] memory inputArray
    ) internal pure returns (bytes[] memory) {
        bytes[] memory outputArray = new bytes[](inputArray.length - 1);

        for (uint256 i; i < outputArray.length; i++) {
            outputArray[i] = inputArray[i + 1];
        }

        return outputArray;
    }

    function includes(
        bool[] memory inputArray,
        bool value
    ) internal pure returns (bool) {
        for (uint256 i; i < inputArray.length; i++) {
            if (inputArray[i] == value) {
                return true;
            }
        }
        return false;
    }

    function includes(
        uint[] memory inputArray,
        uint value
    ) internal pure returns (bool) {
        for (uint256 i; i < inputArray.length; i++) {
            if (inputArray[i] == value) {
                return true;
            }
        }
        return false;
    }

    function includes(
        int[] memory inputArray,
        int value
    ) internal pure returns (bool) {
        for (uint256 i; i < inputArray.length; i++) {
            if (inputArray[i] == value) {
                return true;
            }
        }
        return false;
    }

    function includes(
        address[] memory inputArray,
        address value
    ) internal pure returns (bool) {
        for (uint256 i; i < inputArray.length; i++) {
            if (inputArray[i] == value) {
                return true;
            }
        }
        return false;
    }

    function includes(
        string[] memory inputArray,
        string memory value
    ) internal pure returns (bool) {
        for (uint256 i; i < inputArray.length; i++) {
            if (keccak256(bytes(inputArray[i])) == keccak256(bytes(value))) {
                return true;
            }
        }
        return false;
    }

    function includes(
        bytes[] memory inputArray,
        bytes memory value
    ) internal pure returns (bool) {
        for (uint256 i; i < inputArray.length; i++) {
            if (keccak256(inputArray[i]) == keccak256(value)) {
                return true;
            }
        }
        return false;
    }
        // Helper function to find the index of a value in a string array
    function indexOf(string[] memory array, string memory value) internal pure returns (uint256) {
        for (uint256 i = 0; i < array.length; i++) {
            if (keccak256(bytes(array[i])) == keccak256(bytes(value))) {
                return i;
            }
        }
        return type(uint256).max;
    }

    // Helper function to remove an element from a string array by its index
    function remove(string[] memory array, uint256 index) internal pure returns (string[] memory) {
        require(index < array.length, "Index out of bounds");
        string[] memory newArray = new string[](array.length - 1);
        for (uint256 i = 0; i < index; i++) {
            newArray[i] = array[i];
        }
        for (uint256 i = index + 1; i < array.length; i++) {
            newArray[i - 1] = array[i];
        }
        return newArray;
    }
}
