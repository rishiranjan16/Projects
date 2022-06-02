pragma solidity ^0.8.0;

//SPDX-License-Identifier: MIT

import "./Allowance.sol";

contract MultiSig is Allowance{
    event received(address _from , uint _amount);
    event moneySent(address _to , uint amount);
    
   receive () external payable{}
    
    
    function withdrawAny(address payable _to, uint _amount) public onlyOwner ownerOrAllowed(_amount) {
        if(msg.sender != owner()){
            emit received(_to, _amount);
            reduceAllowance(_to, _amount);
            _to.transfer(_amount);
        } 
        else {
            _to.transfer(_amount);
        }
       
    }
    function renounceOwnership() public view override onlyOwner{
        revert("cannot renounce");
    }
  
    
}
