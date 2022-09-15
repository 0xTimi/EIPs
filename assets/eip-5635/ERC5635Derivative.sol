// SPDX-License-Identifier: CC0-1.0
// Copyright (c) 2022 ysqi
pragma solidity ^0.8.0;

import "./IERC5635.sol";
import "./IERC5635Derivative.sol";

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC165.sol";

contract ERC5635Derivative is IERC165, IERC5635Derivative, ERC721 {
    mapping(uint256 => LicenseNFT[]) _licenses;

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override (ERC721, IERC165) returns (bool) {
        return interfaceId == type(IERC5635Derivative).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC5635Derivative-supportsInterface}.
     */
    function bindLicense(uint256 tokenId, address licensingToken, uint256 licensingTokenId) external override {
        require(ownerOf(tokenId) == msg.sender, "only call by owner");

        require(IERC165(licensingToken).supportsInterface(type(IERC5635).interfaceId), "invalid licensing token");
        // lock
        IERC5635(licensingToken).safeTransferFrom(
            msg.sender, 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE, licensingTokenId, ""
        );

        _licenses[tokenId].push(LicenseNFT({token: licensingToken, tokenId: licensingTokenId}));
    }

    /**
     * @dev See {IERC5635Derivative-supportsInterface}.
     */
    function licensingNFTs(uint256 tokenId) external view override returns (LicenseNFT[] memory) {
        require(ownerOf(tokenId) != address(0), "not exist");
        return _licenses[tokenId];
    }
}
