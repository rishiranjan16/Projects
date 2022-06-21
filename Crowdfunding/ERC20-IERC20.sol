// SPDX-License-Identifier: MIT


pragma solidity ^0.8.0;


 
interface IERC20 {
    
    event Transfer(address indexed from, address indexed to, uint256 value);

   
    event Approval(address indexed owner, address indexed spender, uint256 value);

    
    function totalSupply() external view returns (uint256);

    
    function balanceOf(address account) external view returns (uint256);

    
    function transfer(address to, uint256 amount) external returns (bool);

 
     
    function approve(address spender, uint256 amount) external returns (bool);

    
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address=>mapping(address=>uint )) public allowances;
    string public name = "Test";
    string public symbol= "TEST";
    uint8 public decimals = 18;


    function transfer(address to, uint256 amount) external returns (bool){
        require(balanceOf[msg.sender]>= amount, "not enough balance to transfer");
        
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;

    }
     
    function approve(address spender, uint256 amount) external returns (bool){
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender,amount);
        return true;
    }

    
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool){
        allowances[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit Transfer(from , to , amount);
        return true;
    }
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender,amount);   
         }
         function burn(uint amount) external {
             balanceOf[msg.sender] -= amount;
             totalSupply -= amount;
             emit Transfer(msg.sender, address(0) ,amount);
         }

}
