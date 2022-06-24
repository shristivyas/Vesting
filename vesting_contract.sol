// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./token.sol";

contract Mytoken is Token{
  uint256 Initial_Dex_Offering_Percentage   = 20;
  uint256 Audit_Percentage    = 3;
  uint256 Team_Percentage  = 5;
  uint256 Marketing_Percentage    = 7;
  uint256 Liquidity_Percentage  = 5;
  uint256 Community_Rewards_Percentage    = 60;

  // Token reserve funds
  address Initial_Dex_Offering;
  address Audit;
  address Team;
  address Marketing;
  address Liquidity;
  address Community_Rewards;

  uint256 public Ido_tokens;
  uint256 public Audit_tokens;
  uint256 public Marketing_tokens;
  uint256 public Team_tokens;
  uint256 public Liquidity_tokens;
  uint256 public Community_tokens;
  uint256 public value_1;
  uint256 _start_time;
  uint256 EMISSION_RATE = (unreleased * 10 ** 18) / 273 days; //for 9 months for ido
  uint256 EMISSION_RATE_1 = (Community_tokens * 10 ** 18) / 365 days; //for 12 months for community

  uint256 unreleased;

  IERC20  token;
  uint256 onemonth=2629743;

  constructor(
    address _Initial_Dex_Offering,
    address _Audit,
    address  _Team,
    address _Marketing,
    address _Liquidity,
    address _Community_Rewards , uint256 start_time) public{
    token = IERC20(0xf8e81D47203A594245E36C48e151709F0C19fBe8);
    Initial_Dex_Offering   = _Initial_Dex_Offering;
    Audit = _Audit;
    Marketing  = _Marketing;
    Liquidity  = _Liquidity;
    Team  = _Team;
    Community_Rewards = _Community_Rewards;  
    _start_time =start_time;
    
  }

  function Get_Initial_Dex_Offering(address _beneficiary  )public {
    require(block.timestamp<=_start_time+(2629743*9));
    require(_beneficiary == Initial_Dex_Offering , "Address not valid");
    Ido_tokens = (totalSupply * Initial_Dex_Offering_Percentage)/100;
    value_1 = (Ido_tokens*10)/100;
    unreleased = Ido_tokens-value_1;
    balances[_beneficiary] += value_1;
    balances[msg.sender] -= value_1;
    totalSupply -=value_1;
    require(block.timestamp<=_start_time+(onemonth)); 
    balances[_beneficiary] += EMISSION_RATE;
    onemonth +=2629743;
    
  
    }


    function Get_Audit(address _beneficiary )public {
      require(_beneficiary == Audit , "Address not valid");
      Audit_tokens = (totalSupply * Audit_Percentage)/100;
      require(block.timestamp>=_start_time+(2629743 *2));
      balances[_beneficiary] += Audit_tokens;
      balances[msg.sender] -=Audit_tokens;
      totalSupply -=Audit_tokens; 
    }

    function Get_Marketing(address _beneficiary )public {
      require(_beneficiary == Marketing , "Address not valid");
      Marketing_tokens = (totalSupply * Marketing_Percentage)/100;
      require(block.timestamp>=_start_time+(2629743 *2));
      balances[_beneficiary] += Marketing_tokens;
      balances[msg.sender] -= Marketing_tokens;
      totalSupply -=Marketing_tokens; 
    }

    function Get_Team(address _beneficiary )public {
      require(_beneficiary == Team , "Address not valid");
      require(block.timestamp>=_start_time+(2629743 *12));
      Team_tokens = (totalSupply * Team_Percentage)/100;
      totalSupply -=Team_tokens;
    }

    function Get_Liquidity(address _beneficiary )public {
      require(_beneficiary == Liquidity, "Address not valid");
      Liquidity_tokens = (totalSupply * Liquidity_Percentage)/100;
      totalSupply -=Liquidity_tokens;
    }

    function Get_Community_Rewards(address _beneficiary )public {
    require(_beneficiary == Community_Rewards , "Address not valid");
    Community_tokens = (totalSupply * Community_Rewards_Percentage)/100;
    balances[_beneficiary] += EMISSION_RATE_1;
    balances[msg.sender] -= EMISSION_RATE_1;
    totalSupply -=EMISSION_RATE_1;
    }
  
  
}
