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

    function claimTeamToken() public onlyTokenOwner {
        VestingDetails memory vestingDetails = teamMemberVestingDetails[
            msg.sender
        ];

        if (vestingDetails.totalReleased == 0) {
            teamMemberVestingDetails[msg.sender].releasePercentage = 5;

            // calculate the number of release period that have passed
            uint256 elapsedPeriods = block.timestamp -
                vestingStartTime /
                releaseInterval;

            // calculate total vested percentage
            uint256 totalVestedPercentage = elapsedPeriods * 5;

            // total allocation for team
            uint256 allocatedTokens = (token.getTotalSupply() *
                token.getTeamAllocation()) / 100;

            // calculate the tokens to release
            uint256 tokensToRelease = (allocatedTokens *
                totalVestedPercentage) / 100;

            token.transfer(msg.sender, tokensToRelease);
        }
    }
}
