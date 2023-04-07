// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
@title CrowFounding (Donations)
@author Leandro
@notice This smart contract is a basic crowfounding  that recover ether (donations)
@dev This smart contrac is build only for me learning.I am not an expert
*/


contract CrowFounding{


    address public owner;
    uint256 public goalContribution;
    uint256 public deadline;
    uint256 public fundContribution;
    

    constructor(address _owner) {
        goalContribution = 100 * 10 **18;
        deadline = block.timestamp + 30 days; 
        owner = _owner;
    }

    modifier onlyOwner(){
     require(msg.sender == owner);
      _;
    }

    // @notice Set the fundraising goal
    // @param _goalCont The new fundraising goal
    function goal(uint256 _goalCont) external onlyOwner {
      require(_goalCont >=goalContribution);
      goalContribution = _goalCont;
    }

    // @notice Withdraw funds after reaching the fundraising goal
    function withdraw() external onlyOwner{
        require(fundContribution >= goalContribution);
        payable(owner).transfer(address(this).balance);
        fundContribution = 0;
    }

    // @notice Get the current balance of the contract
    // @return The current balance of the contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // @notice Accept donations for the fundraising campaign
    // @param _amount The amount of the donation
    function donation(uint256 _amount)public payable {
      require(block.timestamp < deadline, "Period has ended");
      require(msg.value == _amount, "Sent amount");
      fundContribution += _amount;
    }
    
    // @notice Receive ETH donations
    receive() external payable{
      donation(msg.value);
    }

}
