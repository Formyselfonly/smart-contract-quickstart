// SPDX-License-Identifier: MIT
// Test2
pragma solidity ^0.8.20;

contract SimpleStorage {
    uint256 public storedValue;

    function set(uint256 _value) public {
        storedValue = _value;
    }

    function get() public view returns (uint256) {
        return storedValue;
    }
}
