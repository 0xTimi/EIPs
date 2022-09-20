// SPDX-License-Identifier: CC0-1.0
// Copyright (c) 2022 ysqi
pragma solidity ^0.8.0;

import "./IERC5635.sol";
import "./IERC5635.sol";

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC165.sol";

contract ERC5635 is IERC5635, IERC165, ERC1155 {
    mapping(uint256 => Licensing) private _licensings;

    constructor(string memory uri_) ERC1155(uri_) {}

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override (ERC1155, IERC165) returns (bool) {
        return interfaceId == type(IERC5635).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC5635-supportsInterface}.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external {
        super.safeTransferFrom(from, to, tokenId, 1, data);
    }

    /**
     * @dev See {IERC5635-supportsInterface}.
     */
    function licenseInfo(uint256 tokenId) external view override returns (Licensing memory) {
        Licensing memory data = _licensings[tokenId];
        require(data.oNFT != address(0), "not exist");
        return data;
    }

    /**
     * @dev See {IERC5635-supportsInterface}.
     */
    function royaltyInfo(uint256 tokenId, uint256 salePrice)
        external
        view
        override
        returns (address receiver, uint256 royaltyAmount)
    {
        Licensing storage data = _licensings[tokenId];
        require(data.oNFT != address(0), "not exist");

        receiver = IERC721(data.oNFT).ownerOf(data.oNFTId);
        if (receiver == address(0)) {
            royaltyAmount = 0;
        } else {
            royaltyAmount = (salePrice * data.royaltyRateMantissa) / 1e8;
        }
    }

    function mint(Licensing calldata data, uint256 amount) external {
        require(IERC721(data.oNFT).ownerOf(data.oNFTId) == msg.sender, "only call by owner");
        require(data.expiryTime > block.timestamp + 1 days, "invalid expirytime");
        uint256 tokenId = uint256(keccak256(abi.encode(data)));
        _mint(msg.sender, tokenId, amount, "");
        _licensings[tokenId] = data;
    }
}
