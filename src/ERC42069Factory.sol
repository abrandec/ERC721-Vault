// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.12;

import {ClonesWithImmutableArgs} from "clones-with-immutable-args/ClonesWithImmutableArgs.sol";
import "./ERC42069.sol";

/// @title ERC42069 Clone Factory
contract ERC42069Factory {
    using ClonesWithImmutableArgs for address;
    
    ERC42069 public erc42069;

    constructor(ERC42069 erc42069_) {
        erc42069 = erc42069_;
    }

    function createERC42069(
        ERC721 erc721Asset_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) public returns (ERC42069 clone) {
        bytes memory data = abi.encodePacked(erc721Asset_, name_, symbol_, decimals_);
        clone = ERC42069(address(erc42069).clone(data));
    }
}