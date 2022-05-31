/*

Your mission here is to build a smart contract given everything we've learnt up to this point that can add investor wallets to a decentralized bank and then allocate (pay) them funds. 

Once you've completed the the smart contract, debugged, and compiled, go ahead and deploy the contract and test it out.

If it is successful you should be able to select different accounts from the test accounts (IDE) and use the payInvestors functions to send funds. Pay a few accounts some funds of your choose and when you're done run the checkInvestors testing function.

If your code is working not only should you have successful transaction, but the checkInvestors function should return to you how  many investors wallets have been added to your bank! Once completed share your code with the community in the #smart-contracts section in the discord. Join the online community free here: https://discord.gg/GADMry6

 */

pragma solidity ^0.8.4;

contract Dbank {
    address dbankAddress;
    uint256 dbankAccount;

    constructor() payable {
        dbankAddress = msg.sender;
        dbankAccount = msg.value;
    }

    modifier isBankAddres() {
        require(dbankAddress == msg.sender);
        _;
    }

    address payable[] investorsAddress;

    mapping(address => uint256) payRoll;

    function addNewInvestor(address payable _address, uint256 _payableAmount)
        public
        isBankAddres
    {
        investorsAddress.push(_address);
        payRoll[_address] = _payableAmount * 1000000000000000000;
    }

    function payInvestors() public {
        for (uint256 i = 0; i < investorsAddress.length; i++) {
            investorsAddress[i].transfer(payRoll[investorsAddress[i]]);
        }
    }

    function checkInvestorsAddressRoll()
        public
        view
        returns (address payable[] memory)
    {
        return investorsAddress;
    }
}
