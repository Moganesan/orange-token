// SPDX-License-Identifier : MIT
pragma solidity 0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import {Orange} from "./Orange.sol";

contract Vesting {
    Orange token;
    address owner;
    uint256 releaseInterval;
    uint256 vestingStartTime;

    mapping(string => uint256) tokenAllocation;

    struct VestingDetails {
        uint256 lastReleaseTime;
        uint256 totalReleased;
    }

    event tokenClaim(address receiver, uint256 amount, uint256 timestamp);

    mapping(address => VestingDetails) teamMemberVestingDetails;

    constructor(address _token, uint256 _releaseInterval) {
        token = Orange(_token);
        owner = token.getOwner();
        releaseInterval = _releaseInterval;

        vestingStartTime = token.getVestingStartTime();

        tokenAllocation["TEAM"] = token.getTeamAllocation();
        tokenAllocation["ADVISORS"] = token.getAdvisorAllocation();
        tokenAllocation["LIQUIDITY"] = token.getLiquidityAllocation();
        tokenAllocation["ECOSYSTEM_REWARDS"] = token.getEcosystemAllocation();
        tokenAllocation["COMMUNITY_AIRDROP"] = token
            .getCommunityAirdropAllocation();
    }

    modifier onlyTokenOwner() {
        require(msg.sender == owner);
        _;
    }

    function claimToken(
        string memory area,
        address _receiver
    ) public onlyTokenOwner {
        // total allocation
        uint256 allocatedTokens = (token.getTotalSupply() *
            tokenAllocation[area]) / 100;

        // check that token allocation is available
        require(
            allocatedTokens < teamMemberVestingDetails[_receiver].totalReleased,
            "Team Tokens Closed!"
        );

        // calculate the number of release period that have passed
        uint256 elapsedPeriods = (block.timestamp - vestingStartTime) /
            releaseInterval;

        // calculate total vested percentage
        uint256 totalVestedPercentage = elapsedPeriods * 5;

        // calculate the tokens to release
        uint256 tokensToRelease = (allocatedTokens * totalVestedPercentage) /
            100;

        token.transferFrom(address(this), _receiver, tokensToRelease);

        teamMemberVestingDetails[_receiver].lastReleaseTime = block.timestamp;

        teamMemberVestingDetails[_receiver].totalReleased = tokensToRelease;

        emit tokenClaim(_receiver, tokensToRelease, block.timestamp);
    }
}
