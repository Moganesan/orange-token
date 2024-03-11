// SPDX-License-Identifier : MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Orange is ERC20 {
    uint24 public constant TOTAL_SUPPLY = 100_000_000 * 10 ** 18;
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
        token_allocatios = TokenAllocation({
            team: (TOTAL_SUPPLY * 10) / 100,
            advisor: (TOTAL_SUPPLY * 3) / 100,
            liquidity: (TOTAL_SUPPLY * 27) / 100,
            ecosystemRewards: (TOTAL_SUPPLY * 5) / 100,
            communityAirDrop: (TOTAL_SUPPLY * 2) / 100,
            grants: (TOTAL_SUPPLY * 3) / 100,
            stakingRewards: (TOTAL_SUPPLY * 5) / 100,
            earlyInvestors: (TOTAL_SUPPLY * 5) / 100,
            privateSale1: (TOTAL_SUPPLY * 9) / 100,
            privateSale2: (TOTAL_SUPPLY * 6) / 100,
            publicSale: (TOTAL_SUPPLY * 25) / 100
        });
    }
}
