// smart contract to automate will

pragma solidity ^0.8.0;

contract Will {
    address owner;
    uint256 fortune;
    bool isDeceased;

    constructor() payable {
        owner = msg.sender;
        fortune = msg.value;
        isDeceased = false;
    }

    // create a modifier to make sure the address to call the contract
    // is for the owner

    modifier onlyOwner() {
        require(msg.sender == owner);
        // _; is like a continue statement in javascript it continues the code
        // if the condition is met
        _;
    }

    modifier mustBeDeceased() {
        require(isDeceased == true);
        _;
    }

    // create an array to store family wallet address
    address payable[] familyAddress;

    // we want to map through those address
    mapping(address => uint256) inheritance;

    function setInheritance(address payable _wallet, uint256 _amount)
        public
        onlyOwner
    {
        familyAddress.push(_wallet);
        inheritance[_wallet] = _amount;
    }

    // payout function to automate sending the inheritance to the family wallet
    function payout() private mustBeDeceased {
        for (uint256 i = 0; i < familyAddress.length; i++) {
            familyAddress[i].transfer(inheritance[familyAddress[i]]);
            // transfering the funds from owner to each family address and
            // also passing the amount to be transfered (mapping throught the inferitance object)
        }
    }

    function deceased() public onlyOwner {
        isDeceased = true;
        payout();
    }
}
