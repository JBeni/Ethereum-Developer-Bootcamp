//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

/**
Write a smart contract that allows for:

Deposits from everyone
Withdrawals only in the amount that was deposited by the person who likes to withdraw
*/
contract SendWithdrawMoney {

    uint public balanceReceived;
    function deposit() public payable {
        balanceReceived += msg.value;
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawAll() public {
        address payable to = payable(msg.sender);
        to.transfer(getContractBalance());
    }

    function withdrawToAddress(address payable to) public {
        to.transfer(getContractBalance());
    }
}
