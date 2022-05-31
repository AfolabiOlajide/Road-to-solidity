// write a storage contract that stores a value and returns 5x the value

pragma solidity ^0.8.4;

contract ReturnFiveX {
    uint256 value;

    function setValue(uint256 _x) public {
        value = _x;
    }

    function getValue() public view returns (uint256) {
        return value * 5;
    }
}
