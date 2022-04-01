// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.12;

import "./ERC42069.sol";
import {ClonesWithImmutableArgs} from "clones-with-immutable-args/ClonesWithImmutableArgs.sol";

contract ERC42069Factory {
    using ClonesWithImmutableArgs for address;

    ERC42069 public erc42069;

    constructor(ERC42069 erc42069_) {
        erc42069 = erc42069_;
    }

    function createERC42069(
        ERC721 _erc721Asset,
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) public returns (ERC42069 clone) {
        bytes memory data = abi.encodePacked(_erc721Asset, _name, _symbol, _decimals);
        clone = ERC42069(address(erc42069).clone(data));
    }
}