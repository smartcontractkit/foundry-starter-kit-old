// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Test {
    uint256 public number;
    string public name;

    constructor(uint256 _number, string memory _name) {
        number = _number;
        name = _name;
    }

    function getNumber() public view returns (uint256) {
        return(number);
    }

    function getName() public view returns (string memory) {
        return(name);
    }
}

