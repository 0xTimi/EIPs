// SPDX-License-Identifier: CC0-1.0
// Copyright (c) 2022 ysqi
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "./IERC5635.sol";

/**
 * @title ERC-5635 Licensing Token Registry Service.
 * @dev See https://eips.ethereum.org/EIPS/eip-5635
 * Note: The ERC-165 identifier for this interface is 0xbe3dc24d.
 */
interface IERC5635Registry {
    /**
     * @dev a license has been registered event.
     */
    event Register(address derivativeToken, address derivativeTokenId, address licenseToken, uint256 licenseTokenId);

    /**
     * @notice register a license `licenseToken` for the given derivative.
     *
     * MUST rever if licenseToken is not support ERC5635 interface.
     * MUST rever if licenseTokenId is not exist.
     * MUST revert if derivativeToken is zero address.
     * MUST emit a `Register` event.
     */
    function register(address derivativeToken, address derivativeTokenId, address licenseToken, uint256 licenseTokenId)
        external;

    /**
     * @notice Check if a license has been registered for a given derivative.
     */
    function isRegistered(
        address derivativeToken,
        address derivativeTokenId,
        address licenseToken,
        uint256 licenseTokenId
    ) external returns (bool);

    /**
     * @notice Check if a license of origin(`originToken`+`originTokenId`) token
     *         has been registered for a given derivative.
     */
    function isAuthorized(
        address derivativeToken,
        address derivativeTokenId,
        address originToken,
        uint256 originTokenId
    ) external returns (bool);
}
