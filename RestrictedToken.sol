// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./WhitelistRegistry.sol";

/**
 * @title RestrictedToken
 * @dev ERC20 token that requires both parties to be whitelisted.
 */
contract RestrictedToken is ERC20 {
    WhitelistRegistry public immutable registry;

    error NotWhitelisted(address account);

    constructor(
        string memory name, 
        string memory symbol, 
        address _registry
    ) ERC20(name, symbol) {
        registry = WhitelistRegistry(_registry);
    }

    function mint(address to, uint256 amount) external {
        // In a real app, add access control here
        _mint(to, amount);
    }

    /**
     * @dev Hook that is called before any transfer of tokens.
     */
    function _update(address from, address to, uint256 value) internal override {
        // Minting (from == address(0)) or Burning (to == address(0)) logic
        if (from != address(0) && !registry.isWhitelisted(from)) {
            revert NotWhitelisted(from);
        }
        if (to != address(0) && !registry.isWhitelisted(to)) {
            revert NotWhitelisted(to);
        }
        
        super._update(from, to, value);
    }
}
