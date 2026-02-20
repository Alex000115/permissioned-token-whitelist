// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title WhitelistRegistry
 * @dev Manages a list of addresses authorized to hold and transfer tokens.
 */
contract WhitelistRegistry is AccessControl {
    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");
    mapping(address => bool) private _whitelist;

    event AddressWhitelisted(address indexed account);
    event AddressRemoved(address indexed account);

    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function isWhitelisted(address account) public view returns (bool) {
        return _whitelist[account];
    }

    function addToWhitelist(address account) external onlyRole(MANAGER_ROLE) {
        _whitelist[account] = true;
        emit AddressWhitelisted(account);
    }

    function batchAddToWhitelist(address[] calldata accounts) external onlyRole(MANAGER_ROLE) {
        for (uint256 i = 0; i < accounts.length; i++) {
            _whitelist[accounts[i]] = true;
            emit AddressWhitelisted(accounts[i]);
        }
    }

    function removeFromWhitelist(address account) external onlyRole(MANAGER_ROLE) {
        _whitelist[account] = false;
        emit AddressRemoved(account);
    }
}
