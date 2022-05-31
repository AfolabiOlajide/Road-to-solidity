pragma solidity ^0.8.4;

contract coin {
    address public minter;
    mapping(address => uint256) public balances;

    event sent(address _from, address _to, uint256 _amount);

    constructor() {
        minter = msg.sender;
    }

    modifier onlyOwner() {
        require(minter == msg.sender);
        _;
    }

    function mint(address _reciever, uint256 _amount) public onlyOwner {
        balances[_reciever] += _amount;
    }

    error insufficientBalance(uint256 requested, uint256 available);

    function send(address _reciever, uint256 _amount) public {
        if (_amount > balances[msg.sender])
            revert insufficientBalance({
                requested: _amount,
                available: balances[msg.sender]
            });

        balances[msg.sender] -= _amount;
        balances[_reciever] += _amount;

        emit sent(msg.sender, _reciever, _amount);
    }
}
