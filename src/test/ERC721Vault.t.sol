// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.12;

import {ERC721Vault} from "../ERC721Vault.sol";
import {MockERC721} from "solmate/test/utils/mocks/MockERC721.sol";
import {DSTestPlus} from "./utils/DSTestPlus.sol";

// Prettier is crapping out on test files
contract ERC721VaultTest is DSTestPlus {
    ERC721Vault erc721Vault;
    MockERC721 mockERC721;

    function setUp() public {
        console.log(unicode"🧪 Testing ERC721Vault.sol...");
        mockERC721 = new MockERC721("TEST", "T_T");
        erc721Vault = new ERC721Vault(mockERC721, "TEST_COIN", "TC", 18);
    }

    // the batch mintoor
    function mintERC721(uint256[] memory tokenId) public {
        for (uint256 i = 0; i < tokenId.length; ++i) {
        mockERC721.mint(address(0xBEEF), tokenId[i]);
        }
    }


    /// ============ SANITY TESTS ============
    function testDeposit() public {
        uint256[] memory index = new uint256[](1);
        index[0] = 0;
        mintERC721(index);
        vm.startPrank(address(0xBEEF));
        mockERC721.approve(address(erc721Vault), 0);
        uint256[] memory id = new uint256[](1);
        id[0] = 0;
        erc721Vault.deposit(id, address(0xBEEF));
    }

    function testWithdraw() public {
        testDeposit();
        uint256[] memory id = new uint256[](1);
        id[0] = 0;
        erc721Vault.withdraw(id, address(0xBEEF));
    }

    function testDepositDiffUser() public {
        testDeposit();
        vm.stopPrank();
        uint256[] memory id = new uint256[](1);
        id[0] = 0;
        vm.expectRevert(bytes("NOT_AUTHORIZED"));
        mockERC721.approve(address(erc721Vault), 0);
        vm.expectRevert(bytes("WRONG_FROM"));
        erc721Vault.deposit(id, address(0xBEEF));
    }

    function testTransfer() public {
        testDeposit();
        erc721Vault.transfer(address(0), 1 wei);
    }

    /// ============ TESTS INTENDED TO FAIL ============

    // incorrect user tries to withdraw
    // Results in NOT_AUTHORIZED
    function testWithdrawDiffUser() public {
        testDeposit();
        vm.stopPrank();
        vm.expectRevert(bytes("ALREADY_MINTED"));
        // sad joose, can't vm.expectRevert more than once in 1 function call
        // vm.expectRevert(bytes("NOT_AUTHORIZED"));
        testWithdraw();
    }

    // Results in Arithmetic over/underflow
    function testWithdrawNotEnough() public {
        testDeposit();
        erc721Vault.transfer(address(0), 1 wei);
        uint256[] memory id = new uint256[](1);
        id[0] = 0;
        erc721Vault.withdraw(id, address(0xBEEF));
    }

    function testDepositReentrancy() public {
        testDeposit();
        testDeposit();
    }

    function testWithdrawReentrancy() public {
        testDeposit();
        uint256[] memory id = new uint256[](1);
        id[0] = 0;
        erc721Vault.withdraw(id, address(0xBEEF));
        erc721Vault.withdraw(id, address(0xBEEF));
    }
}


