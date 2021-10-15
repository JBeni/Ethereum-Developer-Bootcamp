//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract MyContract {

    uint256 public myUint;
    
    function setMyUint(uint256 _myUint) public {
        myUint = _myUint;
    }
    
    bool public myBool;
    
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
    
    uint8 public myUint8;
    
    function increment() public {
        myUint8++;
    }

    function decrement() public {
        myUint8--;
    }
    
    // uint8 if we decrement an uint8 with the value 0 solidity with not raise an error will set the value to 255 and if we increment again the value will 0
    
    address myAddress;
    
    function setMyAddress(address _myAddress) public {
        myAddress = _myAddress;
    }
    
    function getBalanceOfAddress() public view returns(uint) {
        return myAddress.balance;
    }

    string public myString = "Hello World";

    function setMyString(string memory _myString) public {
        myString = _myString;
    }
    
}
