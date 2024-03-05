// SPDX-License-Identifier: GPL-3.0
// TechnicallyWeb3

pragma solidity ^0.8.20;

import "../Array.sol";

contract ExampleArray {
    using Array for uint256[];

    uint256[] public someUintArray;
    bytes[] public someBytesArray;

    function pushUint256Array(uint256[] memory _memoryArray, uint256 _data) external {
        someUintArray = _memoryArray.push();
    }
}