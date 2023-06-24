pragma solidity ^0.8.0;
    contract MappingSimpleEX{

        mapping(address => uint) public balanceReceived;

        function getBalance() public view returns  (uint){
            return address(this).balance;
        }
        function withdrawMoney(address payable _to, uint _amount ) public {
            require( balanceReceived[msg.sender] >= _amount, "not enough funds");
            balanceReceived[msg.sender] -=_amount;
            _to.transfer (_amount);
        }
        function sendMoney() public payable {
           
        } 

        function withdrawAllMoney(address payable _to) public {
            _to.transfer(getBalance());
        }
    }