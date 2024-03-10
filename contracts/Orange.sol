// SPDX-License-Identifier : MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Orange is ERC20 {
    uint24 public constant TOTAL_SUPPLY = 1_000_000;
    constructor() ERC20("ORANGE", "ORG") {
        _mint(msg.sender, TOTAL_SUPPLY);
    }
}
