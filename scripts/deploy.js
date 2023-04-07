const { ethers } = require("hardhat");

async function main() {



  const crowFoundingContract = await ethers.getContractFactory("CrowFounding");

  const deployedCrowFoundingContract = await crowFoundingContract.deploy();

  await deployedCrowFoundingContract.deployed();

  console.log("Contract Address:",deployedCrowFoundingContract.address);
  console.log("Deployed Contract");

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
