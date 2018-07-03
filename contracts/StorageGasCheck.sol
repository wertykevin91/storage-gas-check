pragma solidity ^0.4.23;

contract StorageGasCheck{

    mapping(address => uint256) balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    bytes32 bytes32Storage;
    string stringStorage;

    constructor() public{
        balances[msg.sender] = 10000;
    }

    function transfer(address _to, uint256 _value) public {
        assert((balances[msg.sender] >= _value));
        balances[_to] += _value;
        balances[msg.sender] -= _value;
        emit Transfer(msg.sender, _to, _value);
    }

    function getBalance(address _address) public view returns(uint256 balance){
        return balances[_address];
    }

    function storeBytes32(bytes32 _value) public {
        bytes32Storage = _value;
    }

    function readBytes32() public view returns(bytes32 item){
        return bytes32Storage;
    }

    function storeString(string _value) public {
        stringStorage = _value;
    }

    function readString() public view returns(string item){
        return stringStorage;
    }
}
