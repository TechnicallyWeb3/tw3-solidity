// SPDX-License-Identifier: MIT
// TechnicallyWeb3[utils/String.sol].v=0.0.1

pragma solidity ^0.8.20;

/**
 * @title String Tools
 * @dev Utilities for working with strings in Solidity
 */
library String {

    /**
     * @dev Returns the length of the input string in bytes.
     * @param inputString The input string.
     * @return The length of the input string in bytes.
     */
    function length(string memory inputString) internal pure returns (uint256) {
        bytes memory inputBytes = bytes(inputString);
        return inputBytes.length;
    }

    /**
     * @dev Returns the character at the specified index in the input string.
     * @param inputString The input string.
     * @param charIndex The index of the character to retrieve.
     * @return The character at the specified index.
     */
    function charAt(string memory inputString, uint256 charIndex) internal pure returns (string memory) {
        bytes memory inputBytes = bytes(inputString);
        require(charIndex < inputBytes.length, "charIndex out of inputString bounds");
        return string(abi.encodePacked(inputBytes[charIndex]));
    }

    /**
     * @dev Checks if the input string starts with the specified prefix.
     * @param inputString The input string.
     * @param compareString The prefix to check.
     * @return True if the input string starts with the prefix, false otherwise.
     */
    function startsWith(string memory inputString, string memory compareString) internal pure returns (bool) {
        return startsWithBytes(bytes(inputString), bytes(compareString));
    }

    /**
     * @dev Checks if the input bytes start with the specified prefix.
     * @param inputBytes The input bytes.
     * @param compareBytes The prefix to check.
     * @return True if the input bytes start with the prefix, false otherwise.
     */
    function startsWithBytes(bytes memory inputBytes, bytes memory compareBytes) internal pure returns (bool) {
        for (uint256 i; i < compareBytes.length; i++) {
            if (inputBytes[i] != compareBytes[i]) return false;
        }
        return true;
    }

    /**
     * @dev Checks if the input string ends with the specified suffix.
     * @param inputString The input string.
     * @param compareString The suffix to check.
     * @return True if the input string ends with the suffix, false otherwise.
     */
    function endsWith(string memory inputString, string memory compareString) internal pure returns (bool) {
        return endsWithBytes(bytes(inputString), bytes(compareString));
    }

    /**
     * @dev Checks if the input bytes end with the specified suffix.
     * @param inputBytes The input bytes.
     * @param compareBytes The suffix to check.
     * @return True if the input bytes end with the suffix, false otherwise.
     */
    function endsWithBytes(bytes memory inputBytes, bytes memory compareBytes) internal pure returns (bool) {
        for (uint256 i; i < compareBytes.length; i++) {
            if (inputBytes[inputBytes.length - i - 1] != compareBytes[compareBytes.length - i - 1]) return false;
        }
        return true;
    }

    /**
     * @dev Checks if the input string contains the specified substring.
     * @param inputString The input string.
     * @param compareString The substring to search for.
     * @return True if the input string contains the substring, false otherwise.
     */
    function includes(string memory inputString, string memory compareString) internal pure returns (bool) {
        return includesBytes(bytes(inputString), bytes(compareString));
    }

    /**
     * @dev Checks if the input bytes contain the specified substring.
     * @param inputBytes The input bytes.
     * @param compareBytes The substring to search for.
     * @return True if the input bytes contain the substring, false otherwise.
     */
    function includesBytes(bytes memory inputBytes, bytes memory compareBytes) internal pure returns (bool) {
        for (uint256 i; i <= inputBytes.length - compareBytes.length; i++) {
            uint256 compareLength = 0;
            for (uint256 j = 0; j < compareBytes.length; j++) {
                if (inputBytes[i + j] == compareBytes[j]) {
                    compareLength++;
                } else {
                    break;
                }
            }
            if (compareLength == compareBytes.length) return true;
        }
        return false;
    }

    /**
     * @dev Checks if two strings are equal.
     * @param inputString The first string.
     * @param compareString The second string.
     * @return True if the strings are equal, false otherwise.
     */
    function equals(string memory inputString, string memory compareString) internal pure returns (bool) {
        return equalsBytes(bytes(inputString), bytes(compareString));
    }

    /**
     * @dev Checks if two byte arrays are equal.
     * @param inputBytes The first byte array.
     * @param compareBytes The second byte array.
     * @return True if the byte arrays are equal, false otherwise.
     */
    function equalsBytes(bytes memory inputBytes, bytes memory compareBytes) internal pure returns (bool) {
        if (inputBytes.length != compareBytes.length) return false;
        for (uint256 i; i < inputBytes.length; i++) {
            if (inputBytes[i] != compareBytes[i]) return false;
        }
        return true;
    }

    /**
     * @dev Returns the index of the first occurrence of a substring in the input string.
     * @param inputString The input string.
     * @param compareString The substring to search for.
     * @param startIndex The starting index for the search (optional).
     * @return The index of the first occurrence of the substring, or type(uint256).max if not found.
     */
    function indexOf(string memory inputString, string memory compareString, uint256 startIndex) internal pure returns (uint256) {
        return indexOfBytes(bytes(inputString), bytes(compareString), startIndex);
    }

    /**
     * @dev Returns the index of the first occurrence of a substring in the input string.
     * @param inputString The input string.
     * @param compareString The substring to search for.
     * @return The index of the first occurrence of the substring, or type(uint256).max if not found.
     */
    function indexOf(string memory inputString, string memory compareString) internal pure returns (uint256) {
        return indexOf(inputString, compareString, 0);
    }

    /**
     * @dev Returns the index of the first occurrence of a substring in the input bytes.
     * @param inputBytes The input bytes.
     * @param compareBytes The substring to search for.
     * @param startIndex The starting index for the search (optional).
     * @return The index of the first occurrence of the substring, or type(uint256).max if not found.
     */
    function indexOfBytes(bytes memory inputBytes, bytes memory compareBytes, uint256 startIndex) internal pure returns (uint256) {
        uint256 index = startIndex;
        for (index; index <= inputBytes.length - compareBytes.length; index++) {
            uint256 compareLength = 0;
            for (uint256 j = 0; j < compareBytes.length; j++) {
                if (inputBytes[index + j] == compareBytes[j]) {
                    compareLength++;
                } else {
                    break;
                }
            }
            if (compareLength == compareBytes.length) return index;
        }
        return type(uint256).max;
    }

    /**
     * @dev Returns the last index of the first occurrence of a substring in the input string.
     * @param inputString The input string.
     * @param compareString The substring to search for.
     * @return The last index of the first occurrence of the substring, or type(uint256).max if not found.
     */
    function lastIndexOf(string memory inputString, string memory compareString) internal pure returns (uint256) {
        return lastIndexOfBytes(bytes(inputString), bytes(compareString));
    }

    /**
     * @dev Returns the last index of the first occurrence of a substring in the input bytes.
     * @param inputBytes The input bytes.
     * @param compareBytes The substring to search for.
     * @return The last index of the first occurrence of the substring, or type(uint256).max if not found.
     */
    function lastIndexOfBytes(bytes memory inputBytes, bytes memory compareBytes) internal pure returns (uint256) {
        uint256 index;
        for (index; index <= inputBytes.length - compareBytes.length; index++) {
            uint256 compareLength = 0;
            for (uint256 j = 0; j < compareBytes.length; j++) {
                if (inputBytes[inputBytes.length - (index + j) - 1] == compareBytes[compareBytes.length - j - 1]) {
                    compareLength++;
                } else {
                    break;
                }
            }
            if (compareLength == compareBytes.length) return inputBytes.length - compareBytes.length - index;
        }
        return type(uint256).max;
    }

    /**
     * @dev Returns a substring of the input string.
     * @param inputString The input string.
     * @param startIndex The starting index of the substring (inclusive).
     * @param endIndex The ending index of the substring (exclusive).
     * @return The substring.
     */
    function slice(string memory inputString, int256 startIndex, int256 endIndex) internal pure returns (string memory) {
        return string(sliceBytes(bytes(inputString), startIndex, endIndex));
    }

    /**
     * @dev Returns a substring of the input bytes.
     * @param inputBytes The input bytes.
     * @param startIndex The starting index of the substring (inclusive).
     * @param endIndex The ending index of the substring (exclusive).
     * @return The substring.
     */
    function sliceBytes(bytes memory inputBytes, int256 startIndex, int256 endIndex) internal pure returns (bytes memory) {
        require(inputBytes.length > 0, "Cannot slice empty data");

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

        require(startIndex <= endIndex, "endIndex must come after startIndex");

        bytes memory outputBytes = new bytes(uint256(endIndex - startIndex));

        for (uint256 i; i < outputBytes.length; i++) {
            outputBytes[i] = inputBytes[uint256(startIndex) + i];
        }

        return outputBytes;
    }

    /**
     * @dev Splits the input string into an array of substrings using the specified delimiter.
     * @param inputString The input string.
     * @param delimiterString The delimiter used to split the string.
     * @return An array of substrings.
     */
    function split(string memory inputString, string memory delimiterString) internal pure returns (string[] memory) {
        bytes[] memory bytesArray = splitBytes(bytes(inputString), bytes(delimiterString));
        string[] memory stringArray = new string[](bytesArray.length);
        for (uint256 i; i < bytesArray.length; i++) {
            stringArray[i] = string(bytesArray[i]);
        }
        return stringArray;
    }

    /**
     * @dev Splits the input bytes into an array of substrings using the specified delimiter.
     * @param inputBytes The input bytes.
     * @param delimiterBytes The delimiter used to split the bytes.
     * @return An array of substrings.
     */
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

        // Split the input bytes
        for (uint256 i = 0; i < arrayLength - 1; i++) {
            delimiterIndex = indexOfBytes(inputBytes, delimiterBytes, currentIndex);
            outputBytes[i] = sliceBytes(inputBytes, int256(currentIndex), int256(delimiterIndex));
            currentIndex = delimiterIndex + delimiterBytes.length;
        }
        // Add last slice
        outputBytes[outputBytes.length - 1] = sliceBytes(inputBytes, int256(currentIndex), int256(inputBytes.length));

        return outputBytes;
    }

    /**
     * @dev Converts the input string to lowercase.
     * @param inputString The input string.
     * @return The input string converted to lowercase.
     */
    function toLowerCase(string memory inputString) internal pure returns (string memory) {
        return string(toLowerCaseBytes(bytes(inputString)));
    }

    /**
     * @dev Converts the input bytes to lowercase.
     * @param inputBytes The input bytes.
     * @return The input bytes converted to lowercase.
     */
    function toLowerCaseBytes(bytes memory inputBytes) internal pure returns (bytes memory) {
        for (uint256 i; i < inputBytes.length; i++) {
            // Check uppercase
            if (
                uint8(inputBytes[i]) > 64 && uint8(inputBytes[i]) < 91 || 
                uint8(inputBytes[i]) > 191 && uint8(inputBytes[i]) < 224
            ) {
                // Add 32 to make it lowercase
                unchecked {
                    inputBytes[i] = bytes1(uint8(inputBytes[i]) + 32);
                }
            }
        }
        return inputBytes;
    }

    /**
     * @dev Converts the input string to uppercase.
     * @param inputString The input string.
     * @return The input string converted to uppercase.
     */
    function toUpperCase(string memory inputString) internal pure returns (string memory) {
        return string(toUpperCaseBytes(bytes(inputString)));
    }

    /**
     * @dev Converts the input bytes to uppercase.
     * @param inputBytes The input bytes.
     * @return The input bytes converted to uppercase.
     */
    function toUpperCaseBytes(bytes memory inputBytes) internal pure returns (bytes memory) {
        for (uint256 i; i < inputBytes.length; i++) {
            // Check lowercase
            if (
                uint8(inputBytes[i]) > 96 && uint8(inputBytes[i]) < 123 ||
                uint8(inputBytes[i]) > 223 && uint8(inputBytes[i]) < 256
            ) {
                // Subtract 32 to make it uppercase
                unchecked {
                    inputBytes[i] = bytes1(uint8(inputBytes[i]) - 32);
                }
            }
        }
        return inputBytes;
    }
}
