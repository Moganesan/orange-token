// SPDX-License-Identifier : MIT
pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Orange is ERC20 {
    uint256 public constant TOTAL_SUPPLY = 100_000_000 * 10 ** 18;
    uint256 public vestingStartedTime;

    struct TokenAllocation {
        uint256 team;
        uint256 advisor;
        uint256 liquidity;
        uint256 ecosystemReward;
        uint256 communityAirDrop;
        uint256 grants;
        uint256 stakingReward;
        uint256 earlyInvestors;
        uint256 privateSale1;
        uint256 privateSale2;
        uint256 publicSale;
    }

    TokenAllocation public token_allocatios;

    constructor() ERC20("ORANGE", "ORG") {
        _mint(msg.sender, TOTAL_SUPPLY);
        vestingStartedTime = block.timestamp;
        token_allocatios = TokenAllocation({
            team: (TOTAL_SUPPLY * 10) / 100,
            advisor: (TOTAL_SUPPLY * 3) / 100,
            liquidity: (TOTAL_SUPPLY * 27) / 100,
            ecosystemReward: (TOTAL_SUPPLY * 5) / 100,
            communityAirDrop: (TOTAL_SUPPLY * 2) / 100,
            grants: (TOTAL_SUPPLY * 3) / 100,
            stakingReward: (TOTAL_SUPPLY * 5) / 100,
            earlyInvestors: (TOTAL_SUPPLY * 5) / 100,
            privateSale1: (TOTAL_SUPPLY * 9) / 100,
            privateSale2: (TOTAL_SUPPLY * 6) / 100,
            publicSale: (TOTAL_SUPPLY * 25) / 100
        });
    }
    /**
     * @dev read methods for getting tokenAllocation details
     */

    function getTeamAllocation() public returns (uint256) {
        return token_allocatios.team;
    }

    function getAdvisorAllocation() public returns (uint256) {
        return token_allocatios.advisor;
    }

    function getLiquidityAllocation() public returns (uint256) {
        return token_allocatios.liquidity;
    }

    function getEcosystemAllocation() public returns (uint256) {
        return token_allocatios.ecosystemReward;
    }

    function getCommunityAirdropAllocation() public returns (uint256) {
        return token_allocatios.communityAirDrop;
    }

    function getGrantsAllocation() public returns (uint256) {
        return token_allocatios.grants;
    }

    function getStakingRewardAllocation() public returns (uint256) {
        return token_allocatios.stakingReward;
    }

    function getEarlyInvestorsAllocation() public returns (uint256) {
        return token_allocatios.earlyInvestors;
    }

    function getPrivateSale1Allocation() public returns (uint256) {
        return token_allocatios.privateSale1;
    }

    function getPrivateSale2Allocation() public returns (uint256) {
        return token_allocatios.privateSale2;
    }

    function getPublicSaleAllocation() public returns (uint256) {
        return token_allocatios.publicSale;
    }
}
