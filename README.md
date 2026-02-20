# Permissioned Token Whitelist

A secure, expert-level implementation of a restricted ERC-20 token. This project is designed for use cases where tokens must only be held by verified participants (KYC/AML compliant).

## Features
* **Global Whitelist**: A central registry managed by administrators to authorize addresses.
* **Transfer Hooks**: Every `transfer` and `transferFrom` call is intercepted to verify the eligibility of both the sender and the receiver.
* **Batch Onboarding**: Efficient functions to whitelist multiple investors in a single transaction.
* **Emergency Freeze**: Ability for the compliance officer to freeze specific accounts if suspicious activity is detected.

## Technical Flow


1. **Admin** adds user addresses to the `WhitelistRegistry`.
2. **User A** attempts to send tokens to **User B**.
3. **Token Contract** queries the registry: `isWhitelisted(A)` and `isWhitelisted(B)`.
4. If both are true, the transfer proceeds; otherwise, it reverts with a descriptive error.

## License
MIT
