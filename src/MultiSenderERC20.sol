// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

/// @title MultiSenderERC20
/// @notice Send any ERC20 token to multiple addresses in one transaction.
/// @dev Uses SafeERC20 to support non-standard tokens (e.g. USDT-style).
contract MultiSenderERC20 {
    using SafeERC20 for IERC20;

    /// @notice Send different amounts of a token to multiple recipients.
    /// @param token The ERC20 token to distribute.
    /// @param recipients The list of recipient addresses.
    /// @param amounts The list of amounts (must match recipients length).
    ///
    /// @dev Caller must have approved this contract to spend at least
    ///      the sum of all `amounts`.
    function multiSendToken(IERC20 token, address[] calldata recipients, uint256[] calldata amounts) external {
        uint256 len = recipients.length;
        require(len == amounts.length, "MultiSender: length mismatch");

        for (uint256 i = 0; i < len; i++) {
            token.safeTransferFrom(msg.sender, recipients[i], amounts[i]);
        }
    }

    /// @notice Send the same amount of a token to multiple recipients.
    /// @param token The ERC20 token to distribute.
    /// @param recipients The list of recipient addresses.
    /// @param amountPerRecipient The amount each recipient gets.
    ///
    /// @dev Caller must have approved this contract to spend at least
    ///      `recipients.length * amountPerRecipient`.
    function multiSendEqualToken(IERC20 token, address[] calldata recipients, uint256 amountPerRecipient) external {
        uint256 len = recipients.length;
        for (uint256 i = 0; i < len; i++) {
            token.safeTransferFrom(msg.sender, recipients[i], amountPerRecipient);
        }
    }
}
