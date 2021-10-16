// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

abstract contract Ownable {
    address public _owner;

    constructor() {
        _owner = msg.sender;
    }

    /**
    * @dev Throws if called by an account other than the owner
    */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
    * @dev Returns true if the caller is the current owner
    */
    function isOwner() public view returns(bool) {
        return (msg.sender == _owner);
    }

}
