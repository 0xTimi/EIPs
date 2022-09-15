// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

/**
 * @title ERC-5635 Derivatives NFT (dNFT) Standard.
 * @dev See https://eips.ethereum.org/EIPS/eip-5635
 * Note: The ERC-165 identifier for this interface is 0xf8c79e7e.
 */
interface IERC5635Derivative {
    struct LicenseNFT {
        address token;
        uint256 tokenId;
    }

    /**
     * @dev MUST emit when token is bound to a licensing token.
     * @param tokenId           ID of the derivative token.
     * @param bindIndex         Index on the licensing list of this token.
     * @param licensingToken    Address of licensing token contract.
     * @param licensingTokenId  ID of the licensing token.
     */
    event Bound(uint256 indexed tokenId, uint256 bindIndex, address licensingToken, uint256 licensingTokenId);

    /**
     * @notice Bind a licensing token to `tokenId` token.
     * @dev Caller must be token holder.
     *
     * When binding, the licensing will be transferred to this contract. and locked,
     * and is is not allowed to be used again.
     * The licensing holder must approve this contract to transfer it before call
     * transfer method.
     *
     * MUST revert if tokenId not found.
     * MUST revert if caller is not token minner.
     * MUST revert if licenseToken doese not supprot IERC5635 interface.
     * MUST revert if licenseToken doese not supprot IERC721 nor IERC1155 interface.
     * MUST revert if transfer licensing failed.
     * MUST revert on any other error.
     * MUST emit Bound event.
     *
     * @param tokenId           ID of the derivative token.
     * @param licensingToken    Address of licensing token contract.
     * @param licensingTokenId  ID of the licensing token.
     */
    function bindLicense(uint256 tokenId, address licensingToken, uint256 licensingTokenId) external;

    /**
     * @dev Returns the all licensing NFTs of `tokenId`.
     *
     * MUST revert if tokenId not found.
     *
     * @param tokenId          ID of the derivative token.
     * @return LicenseNFT[]    A list of licensing NFT, including token address and token id.
     * Returns empty list if the given token is not bound to a licensing NFT.
     */
    function licensingNFTs(uint256 tokenId) external view returns (LicenseNFT[] memory);
}
