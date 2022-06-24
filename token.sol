// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Token{
    mapping (address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    uint public totalSupply = 400000000;
    string public name="Usdb";
    string public symbol="Usdb";
    uint public decimals = 18;

    
    event Transfer(address indexed from , address indexed to , uint value);
    event Approval(address indexed owner , address indexed spender , uint value);


    constructor(){
        balances[msg.sender]=totalSupply;
    }

    function balanceOf(address owner)public view returns(uint){
        return balances[owner];
    }
}
