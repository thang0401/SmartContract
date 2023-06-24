// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/audit/2023-03/contracts/access/Ownable.sol";
import "https://github.com/fractional-company/contracts/blob/master/src/OpenZeppelin/math/SafeMath.sol";

contract fundWallet is Ownable {
    mapping (address => uint) allowance ;
    event AllowanceChanged(address indexed _forWho, address indexed  _byWhom, uint _oldAmountm, uint _newAmount );
    event sentMoney( address indexed  _to, uint _amount );
    event receiveMoney( address indexed  _from, uint _amount );
    using SafeMath for uint ;

    function addAllowance (address _who, uint _amount ) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender,allowance[_who], _amount );
        // allowance [_who] = _amount ;
        allowance[_who] = allowance[_who].add(_amount);
    }

    function isOwner () internal view returns (bool){
        return owner() == msg.sender;  
    }

    modifier onwerOrWhoIsAllowed ( uint _amount ) {
        require(isOwner() || allowance [msg.sender] >= _amount, "you are not allowed ");
        _;
    }

    function reduceAllowance (address _who, uint _amount) internal   onwerOrWhoIsAllowed(_amount) {
        emit AllowanceChanged(_who, msg.sender,allowance[_who],allowance[_who] - _amount );
        // allowance[_who] -= _amount ;
                allowance[_who] = allowance[_who].sub(_amount);

    }
    function renounceOwnership() public view override onlyOwner {
        revert("can't renounceOwnership");
    } 
   
    function withdrawMoney (address payable  _to, uint _amount ) public onwerOrWhoIsAllowed(_amount) {
        if(!isOwner()){
            reduceAllowance (msg.sender, _amount);
        }
        emit sentMoney(_to,_amount );
       
        _to.transfer(_amount); 
    }
    receive() external payable {
        emit receiveMoney ( msg.sender, msg.value );
    }
}
