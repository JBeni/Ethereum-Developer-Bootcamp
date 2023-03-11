//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

/**
These are the requirements:

The wallet has one owner
The wallet should be able to receive funds, no matter what
It is possible for the owner to spend funds on any kind of address, no matter if its a so-called Externally Owned Account (EOA - with a private key), or a Contract Address.
It should be possible to allow certain people to spend up to a certain amount of funds.
It should be possible to set the owner to a different address by a minimum of 3 out of 5 guardians, in case funds are lost.

You might see already what this shows you... With on-chain wallets, you get a lot more flexibility than with your traditional private-key based wallet. You can implement things like:

Multi-Signature Transaction Whitelisting, where it needs m-out-of-n people to agree to a transaction
Emergency operations, like account freezing, or withdrawal limits per day/month, ...
Whitelisting and Account Sharing
Account Recovery by using m-out-of-n people to reset an owner, or re-authorize a new person.
And for the sophisticated DeFi Traders out there, there are functions that help save gas costs, bundle transactions and templates to execute transactions to deleverage positions etc...
*/

contract SampleWallet {

    address payable owner;

    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;

    mapping(address => bool) public guardian;
    address payable nextOwner;
    uint guardiansResetCount;
    uint public constant confirmationsFromGuardiansForReset = 3;

    constructor() {
        owner = payable(msg.sender);
    }

    function proposeNewOwner(address payable newOwner) public {
        require(guardian[msg.sender], "You are no guardian, aborting");
        if(nextOwner != newOwner) {
            nextOwner = newOwner;
            guardiansResetCount = 0;
        }

        guardiansResetCount++;

        if(guardiansResetCount >= confirmationsFromGuardiansForReset) {
            owner = nextOwner;
            nextOwner = payable(address(0));
        }
    }

    function setAllowance(address _from, uint _amount) public {
        require(msg.sender == owner, "You are not the owner, aborting!");
        allowance[_from] = _amount;
        isAllowedToSend[_from] = true;
    }

    function denySending(address _from) public {
        require(msg.sender == owner, "You are not the owner, aborting!");
        isAllowedToSend[_from] = false;
    }

    function transfer(address payable _to, uint _amount, bytes memory payload) public returns (bytes memory) {
        require(_amount <= address(this).balance, "Can't send more than the contract owns, aborting.");
        if(msg.sender != owner) {
            require(isAllowedToSend[msg.sender], "You are not allowed to send any transactions, aborting");
            require(allowance[msg.sender] >= _amount, "You are trying to send more than you are allowed to, aborting");
            allowance[msg.sender] -= _amount;

        }

        (bool success, bytes memory returnData) = _to.call{value: _amount}(payload);
        require(success, "Transaction failed, aborting");
        return returnData;
    }

    receive() external payable {}
}
