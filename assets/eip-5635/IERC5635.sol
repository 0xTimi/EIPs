// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

/**
 * @title ERC-5635 Licensing Token Standard.
 * @dev See https://eips.ethereum.org/EIPS/eip-5635
 * Note: The ERC-165 identifier for this interface is 0x8cd02adc.
 */

interface IERC5635 {
    /// @dev The licensing argeement meta data.
    struct Licensing {
        uint256 oNFTId;
        address oNFT;
        // License expiry timestamp.
        uint64 expiryTime;
        // The royalty rate as an unsigned integer, scaled by 1e8.
        uint32 royaltyRateMantissa;
        // The indentifier, e.g. `MIT` or `Apache`
        // see: https://spdx.org/licenses/
        string licenseId;
        // The NFT Licensing Argeement Type.
        string argeementId;
        // Additional licensing information for extended licensing.
        bytes extraData;
    }

    /**
     * @dev Safely transfers one `tokenId` token from `from` to `to`.
     * see https://eips.ethereum.org/EIPS/eip-721
     * https://eips.ethereum.org/EIPS/eip-1155
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    /**
     * @dev Retruns the licensing argeement meta data.
     *
     * MUST revert if `tokenId` not found.
     * @param tokenId ID of the licensing token.
     */
    function licenseInfo(uint256 tokenId) external view returns (Licensing memory);

    /// @notice Called with the sale price to determine how much royalty
    //          is owed and to whom.
    /// @param  tokenId        ID of the licensing token.
    /// @param  salePrice      The sale price of the dNFT asset specified.
    /// @return receiver       Address of who should be sent the royalty payment
    /// @return royaltyAmount  The royalty payment amount for salePrice
    function royaltyInfo(uint256 tokenId, uint256 salePrice)
        external
        view
        returns (address receiver, uint256 royaltyAmount);
}
