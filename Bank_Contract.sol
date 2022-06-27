// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Bank {
    address public caller;
    mapping (address => uint) Address_Balance;
     constructor() {
         caller = msg.sender;
     }
    modifier onlyowner (){
        require (caller == msg.sender);
        _;
    }
    // Function To deposit ether by the msg.sender
    function Deposit_Ether () payable public {
        Address_Balance[address(this)] += msg.value;
    }
    // Function To withdraw any amount of ether from the contract balance to msg.sender balance
    function Withdraw_Ether (uint Withdraw_amount) external onlyowner{
        require(Address_Balance[address(this)] >= Withdraw_amount, "Not Enough Ether to withdraw");
        Address_Balance[address(this)] -= Withdraw_amount;
        Address_Balance[caller] += Withdraw_amount;
    }
    // Function to send ether from one account to another
    function Send_Ether (address sender , address receiver , uint amount) public {
        require (Address_Balance[sender] >= amount , "Not Enough Ether to send");
        Address_Balance[sender] -= amount;
        Address_Balance[receiver] += amount;
    }
    // Function to get the balance of proviced address
    function Get_Address_Balance (address account) public view returns (uint balance) {
        return Address_Balance[account];
    }
    // Function to get the contract balance (ether)
    function Get_Contract_Balance () public view returns (uint contract_balance){
        return Address_Balance[address(this)];
    }
}