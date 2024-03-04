// SPDX-License-Identifier: GPL-3.0
// TechnicallyWeb3

pragma solidity ^0.8.20;

import "../Bytes.sol";

contract ExampleBytes {
    using Bytes for bytes;

    bytes public someBytes;
    uint256 public someUint;
    bool public someBool;
    bytes[] public someBytesArray;

    function setBytes(bytes memory _bytes) external {
        someBytes = _bytes;
    }

    function setLowerCaseBytes(bytes memory _bytes) external {
        someBytes = _bytes.toLowerCase();
    }

    function setUpperCaseBytes(bytes memory _bytes) external {
        someBytes = _bytes.toUpperCase();
    }

    function setStartsWith(bytes memory _bytes, bytes memory _compare) external {
        someBool = _bytes.startsWith(_compare);
    }

    function setEndsWith(bytes memory _bytes, bytes memory _compare) external {
        someBool = _bytes.endsWith(_compare);
    }

    function setIncludes(bytes memory _bytes, bytes memory _compare) external {
        someBool = _bytes.includes(_compare);
    }

    function setEquals(bytes memory _bytes, bytes memory _compare) external {
        someBool = _bytes.equals(_compare);
    }

    function setIndexOf(bytes memory _bytes, bytes memory _compare) external {
        someUint = _bytes.indexOf(_compare); 
    }

    function setLastIndexOf(bytes memory _bytes, bytes memory _compare) external {
        someUint = _bytes.lastIndexOf(_compare);
    }

    function setSlice(bytes memory _bytes, int256 _start, int256 _end) external {
        someBytes = _bytes.slice(_start, _end);
    }

    function setSplit(bytes memory _bytes, bytes memory _delimiter) external {
        someBytesArray = _bytes.split(_delimiter);
    }
    
}