// SPDX-License-Identifier: CC0-1.0
// Copyright (c) 2022 ysqi
pragma solidity ^0.8.0;

/**
 * @title ERC-5635 Licensing Argeement Standard.
 * @dev See https://eips.ethereum.org/EIPS/eip-5635
 * Note: The ERC-165 identifier for this interface is 0x2427c197.
 * TODO: argeement vs license
 */
interface IArgeement {
    /**
     * @dev Returns the license URI.
     * e.g https://creativecommons.org/publicdomain/zero/1.0/legalcode
     */
    function getLicenseURI() external view returns (string memory);

    /**
     * @dev Returns the license name. e.g CC0-1.0
     */
    function getLicenseName() external view returns (string memory);

    /**
     * @dev Allow verification of content to be written in legal code.
     * To reduce storage costs, each input MUST not exceed 32 bytes.
     */
    function checkInputs(bytes32[] calldata inputs) external view;
}
