// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 
import "./Ownable.sol";


contract demo1 is Owner {
   mapping (address => uint256) public tokenBalance;
//    address owner ;
   uint tokenPrice = 1 ether ;


   constructor ()  {
    //    owner = msg.sender;
       tokenBalance[owner] = 100;
   }
   function createNewToken() public onlyOwner {
    //    require (msg.sender == owner,"you are not allowed");
       tokenBalance[owner] ++;
   }

   function burnToken() public onlyOwner {
    //    require (msg.sender== owner,"you are not allowed");
       tokenBalance[owner]--;
   }
   function purchaseToken() public payable {
       require ((tokenBalance[owner]*tokenPrice) / msg.value >= 0,"you are not enough tokentoken" );
        tokenBalance[owner] -= msg.value/tokenPrice;
        tokenBalance[msg.sender] += msg.value/tokenPrice;

   }
   function sendToken(address _to, uint256 _amount) public{
       require(tokenBalance[msg.sender] >= _amount,"not enough token");
       assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender] );
       assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
       tokenBalance[msg.sender] -= _amount;
       tokenBalance[_to] += _amount;
   }

}