// SPDX-License-Identifier : MIT
pragma solidity 0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import {Orange} from "./Orange.sol";

contract Vesting {
    Orange token;
    address owner;
    uint256 releaseInterval;
    uint256 vestingStartTime;

    struct VestingDetails {
        uint256 releasePercentage;
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
    }

    modifier onlyTokenOwner() {
        require(msg.sender == owner);
        _;
    }

    function claimTeamToken(address _receiver) public onlyTokenOwner {
        teamMemberVestingDetails[_receiver].releasePercentage = 5;

        // calculate the number of release period that have passed
        uint256 elapsedPeriods = (block.timestamp - vestingStartTime) /
            releaseInterval;

        // calculate total vested percentage
        uint256 totalVestedPercentage = elapsedPeriods * 5;

        // total allocation for team
        uint256 allocatedTokens = (token.getTotalSupply() *
            token.getTeamAllocation()) / 100;

        // calculate the tokens to release
        uint256 tokensToRelease = (allocatedTokens * totalVestedPercentage) /
            100;

        token.transferFrom(address(this), _receiver, tokensToRelease);

        teamMemberVestingDetails[_receiver].lastReleaseTime = block.timestamp;

        teamMemberVestingDetails[_receiver].totalReleased = tokensToRelease;

        emit tokenClaim(_receiver, tokensToRelease, block.timestamp);
    }
}
