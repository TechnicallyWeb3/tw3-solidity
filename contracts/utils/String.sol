// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/String.sol].v=0.0.1

pragma solidity ^0.8.20;

/**
    @title String Tools
    @dev Utilities for working with strings in solidity
 */
library String {

    function length(string memory inputString) internal pure returns (uint256) {
        bytes memory inputBytes = bytes(inputString);
        return inputBytes.length;
    }

    function charAt(string memory inputString, uint256 charIndex) internal pure returns (string memory) {
        bytes memory inputBytes = bytes(inputString);
        require (charIndex < inputBytes.length, "charIndex out of inputString bounds");
        return string(abi.encodePacked(inputBytes[charIndex]));
    }

    function startsWith(string memory inputString, string memory compareString) internal pure returns (bool) {
        return startsWithBytes(bytes(inputString), bytes(compareString));
    }

    function startsWithBytes(bytes memory inputBytes, bytes memory compareBytes) internal pure returns (bool) {

        for (uint256 i; i < compareBytes.length; i++) {
            if (inputBytes[i] != compareBytes[i]) return false;
        }

        return true;
    }

    function endsWith(string memory inputString, string memory compareString) internal pure returns (bool) {
        return endsWithBytes(bytes(inputString), bytes(compareString));
    }

    function endsWithBytes(bytes memory inputBytes, bytes memory compareBytes) internal pure returns (bool) {

        for (uint256 i; i < compareBytes.length; i++) {
            if (inputBytes[inputBytes.length - i - 1] != compareBytes[compareBytes.length - i - 1]) return false;
        }

        return true;
    }

    function includes(string memory inputString, string memory compareString) internal pure returns (bool) {
        return includesBytes(bytes(inputString), bytes(compareString));
    }

    function includesBytes(bytes memory inputBytes, bytes memory compareBytes) internal pure returns (bool) {

        for (uint256 i; i <= inputBytes.length - compareBytes.length; i++) {
            uint256 compareLength = 0;
            for (uint256 j = 0; j < compareBytes.length; j++) {
                if (inputBytes[i + j] == compareBytes[j]) {
                    compareLength ++;
                } else {
                    break;
                }
            }
            if (compareLength == compareBytes.length) return true;
        }

        return false;
    }

    function equals(string memory inputString, string memory compareString) internal pure returns (bool) {
        return equalsBytes(bytes(inputString), bytes(compareString));
    }

    function equalsBytes(bytes memory inputBytes, bytes memory compareBytes) internal pure returns (bool) {

        if (inputBytes.length != compareBytes.length) return false;

        for (uint256 i; i < inputBytes.length; i++) {
            if (inputBytes[i] != compareBytes[i]) return false;
        }

        return true;
    }

    function indexOf(string memory inputString, string memory compareString) internal pure returns (uint256) {
        return indexOf(inputString, compareString, 0);
    }

    function indexOf(string memory inputString, string memory compareString, uint256 startIndex) internal pure returns (uint256) {
        return indexOfBytes(bytes(inputString), bytes(compareString), startIndex);
    }

    function indexOfBytes(bytes memory inputBytes, bytes memory compareBytes, uint256 startIndex) internal pure returns (uint256) {
    uint256 index = startIndex;
        for (index; index <= inputBytes.length - compareBytes.length; index++) {
            uint256 compareLength = 0;
            for (uint256 j = 0; j < compareBytes.length; j++) {
                if (inputBytes[index + j] == compareBytes[j]) {
                    compareLength ++;
                } else {
                    break;
                }
            }
            if (compareLength == compareBytes.length) return index;
        }

        return type(uint256).max;
    }

    function lastIndexOf(string memory inputString, string memory compareString) internal pure returns (uint256) {
        return lastIndexOfBytes(bytes(inputString), bytes(compareString));
    }

    function lastIndexOfBytes(bytes memory inputBytes, bytes memory compareBytes) internal pure returns (uint256) {

        uint256 index;
            for (index; index <= inputBytes.length - compareBytes.length; index++) {
                uint256 compareLength = 0;
                for (uint256 j = 0; j < compareBytes.length; j++) {
                    if (inputBytes[inputBytes.length - (index + j) - 1] == compareBytes[compareBytes.length - j - 1]) {
                        compareLength ++;
                    } else {
                        break;
                    }
                }
                if (compareLength == compareBytes.length) return inputBytes.length - compareBytes.length - index;
            }

            return type(uint256).max;
    }

    function slice(string memory inputString, int256 startIndex, int256 endIndex) internal pure returns (string memory) {
        return string(sliceBytes(bytes(inputString), startIndex, endIndex));
    }

    function sliceBytes(bytes memory inputBytes, int256 startIndex, int256 endIndex) internal pure returns (bytes memory) {
        require (startIndex <= endIndex, "endIndex must come after startIndex");
        require (inputBytes.length > 0, "Cannot slice empty data");

        if (startIndex < 0) {
            startIndex = int256(inputBytes.length) + startIndex;
        }
        if (endIndex < 0) {
            endIndex = int256(inputBytes.length) + endIndex;
        }

        if (startIndex >= int256(inputBytes.length)) {
            startIndex = int256(inputBytes.length - 1);
        }
        if (endIndex >= int256(inputBytes.length)) {
            endIndex = int256(inputBytes.length - 1);
        }

        bytes memory outputBytes = new bytes(uint256(endIndex - startIndex));

        for (uint256 i; i < outputBytes.length; i++) {
            outputBytes[i] = inputBytes[uint256(startIndex) + i];
        }
        
        return outputBytes;
    }

    function split(string memory inputString, string memory delimiterString) internal pure returns (string[] memory) {
        bytes[] memory bytesArray = splitBytes(bytes(inputString), bytes(delimiterString));
        string[] memory stringArray = new string[](bytesArray.length);
        for (uint256 i; i < bytesArray.length; i++) {
            stringArray[i] = string(bytesArray[i]);
        }

        return stringArray;
    }

    function splitBytes(bytes memory inputBytes, bytes memory delimiterBytes) internal pure returns (bytes[] memory) {
        uint256 currentIndex = 0;
        uint256 delimiterIndex = indexOfBytes(inputBytes, delimiterBytes, currentIndex);
        uint256 arrayLength = 1;

        // Count the number of substrings
        for (arrayLength; delimiterIndex != type(uint256).max; arrayLength++) {
            currentIndex = delimiterIndex + delimiterBytes.length;
            delimiterIndex = indexOfBytes(inputBytes, delimiterBytes, currentIndex);
        }

        // Initialize the output array
        bytes[] memory outputBytes = new bytes[](arrayLength);
        currentIndex = 0;

        // Split the input string
        for (uint256 i = 0; i < arrayLength - 1; i++) {
            delimiterIndex = indexOfBytes(inputBytes, delimiterBytes, currentIndex);
            outputBytes[i] = sliceBytes(inputBytes, int256(currentIndex), int256(delimiterIndex));
            currentIndex = delimiterIndex + delimiterBytes.length;
        }
        // add last slice
        outputBytes[outputBytes.length - 1] = sliceBytes(inputBytes, int256(currentIndex), int256(inputBytes.length));

        return outputBytes;
    }

    function toLowerCase(string memory inputString) internal pure returns (string memory) {
        return string(toLowerCaseBytes(bytes(inputString)));
    }

    function toLowerCaseBytes(bytes memory inputBytes) internal pure returns (bytes memory) {
        for (uint256 i; i < inputBytes.length; i++) {
            // check uppercase
            if (
                uint8(inputBytes[i]) > 64 && uint8(inputBytes[i]) < 91 || 
                uint8(inputBytes[i]) > 191 && uint8(inputBytes[i]) < 224
            ) {
                // add 32 to make it lowercase
                unchecked {
                    inputBytes[i] = bytes1(uint8(inputBytes[i]) + 32);
                }
            }

        }

        return inputBytes;
    }

    function toUpperCase(string memory inputString) internal pure returns (string memory) {
        return string(toUpperCaseBytes(bytes(inputString)));
    }

    function toUpperCaseBytes(bytes memory inputBytes) internal pure returns (bytes memory) {
                for (uint256 i; i < inputBytes.length; i++) {
            // check lowercase
            if (
                uint8(inputBytes[i]) > 96 && uint8(inputBytes[i]) < 123 ||
                uint8(inputBytes[i]) > 223 && uint8(inputBytes[i]) < 256
            ) {
                // subtract 32 to make it uppercase
                unchecked {
                    inputBytes[i] = bytes1(uint8(inputBytes[i]) - 32);
                }
            }
        }

        return inputBytes;
    }

}