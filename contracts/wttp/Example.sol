// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@tw3/solidity/contracts/wttp/TW3Site.sol";

contract MyFirstSite is TW3Site {
    constructor(
        string memory _name, 
        string memory _description, 
        string memory _tags) 
    TW3Site(_name, _description, _tags) {}
}