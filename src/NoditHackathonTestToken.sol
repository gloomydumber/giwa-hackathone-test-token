// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract NoditHackathonTestToken is ERC20 {
    constructor() ERC20("NODIT HACKATHON TEST TOKEN", "NHTT") {
        // Mint the maximum uint256 amount to the deployer
        _mint(msg.sender, 1_000_000_000 * 10 ** decimals());
    }
}
