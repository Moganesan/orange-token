import { formatEther, parseEther } from "viem";
import hre from "hardhat";

async function main() {
  const org = await hre.viem.deployContract("Orange");
  console.log("$ORANGE address: ", org.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
