// SPDX-License-Identifier: GPL-3.0
// TechnicallyWeb3

pragma solidity ^0.8.20;

import "../String.sol";

contract ExampleString {
    using String for string;

    string public someString;
    uint256 public someUint;
    bool public someBool;
    string[] public someStringArray;

    function setString(string memory _string) external {
        someString = _string;
    }

    function setLowerCaseString(string memory _string) external {
        someString = _string.toLowerCase();
    }

    function setUpperCaseString(string memory _string) external {
        someString = _string.toUpperCase();
    }

    function setLength(string memory _string) external {
        someUint = _string.length();
    }

    function setCharAt(string memory _string, uint256 charIndex) external {
        someString = _string.charAt(charIndex);
    }

    function setStartsWith(string memory _string, string memory _compare) external {
        someBool = _string.startsWith(_compare);
    }

    function setEndsWith(string memory _string, string memory _compare) external {
        someBool = _string.endsWith(_compare);
    }

    function setIncludes(string memory _string, string memory _compare) external {
        someBool = _string.includes(_compare);
    }

    function setEquals(string memory _string, string memory _compare) external {
        someBool = _string.equals(_compare);
    }

    function setIndexOf(string memory _string, string memory _compare) external {
        someUint = _string.indexOf(_compare);
    }

    function setLastIndexOf(string memory _string, string memory _compare) external {
        someUint = _string.lastIndexOf(_compare);
    }

    function setSlice(string memory _string, int256 _start, int256 _end) external {
        someString = _string.slice(_start, _end);
    }

    function setSplit(string memory _string, string memory _delimiter) external {
        someStringArray = _string.split(_delimiter);
    }
    
}