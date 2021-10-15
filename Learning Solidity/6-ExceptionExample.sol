// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract ExceptionExample {
    mapping(address => uint64) public balanceReceived;

    function receiveMoney() public payable {
        assert(msg.value == uint64(msg.value));
        balanceReceived[msg.sender] += uint64(msg.value);
        assert(balanceReceived[msg.sender] >= uint64(msg.value));
    }

    function withdrawMoney(address payable _to, uint64 _amount) public {
        // IF/ELSE deprecated us require for validity of conditions from solidity version 0.5
        require(_amount <= balanceReceived[msg.sender], "Not enough funds, aborting");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}

// From solidity version 0.6 a new concept had been introduce try/catch
contract WillThrow {
    function aFunction() public pure {
        require(false, "Error message");
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason);

    function catchError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            // here we could do something it it works
        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }
    }
}
