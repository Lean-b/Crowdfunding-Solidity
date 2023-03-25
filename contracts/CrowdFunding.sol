// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;



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

    function goal(uint256 _goalCont) external onlyOwner {
      require(_goalCont >=goalContribution);
      goalContribution = _goalCont;
    }

    function withdraw() external onlyOwner{
        require(fundContribution >= goalContribution);
        payable(owner).transfer(address(this).balance);
        fundContribution = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }


    function donation(uint256 _amount)public payable {
      require(block.timestamp < deadline, "Period has ended");
      require(msg.value == _amount, "Sent amount");
      fundContribution += _amount;
    }

    receive() external payable{
      donation(msg.value);
    }

}
