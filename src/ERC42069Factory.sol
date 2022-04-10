// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.12;

import {ClonesWithImmutableArgs} from "clones-with-immutable-args/ClonesWithImmutableArgs.sol";
import "./ERC721Vault.sol";

/// @title ERC721Vault Clone Factory
contract ERC721VaultFactory {
    using ClonesWithImmutableArgs for address;
    
    ERC42069 public erc721Vault;

    constructor(ERC721Vault erc721Vault_) {
        erc721Vault = erc721Vault_;
    }

    function createERC721Vault(
        ERC721 erc721Asset_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) public returns (ERC721Vault clone) {
        bytes memory data = abi.encodePacked(erc721Asset_, name_, symbol_, decimals_);
        clone = ERC721Vault(address(erc721Vault).clone(data));
    }
}
