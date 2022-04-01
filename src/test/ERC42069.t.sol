// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.12;

import {ERC42069} from "../ERC42069.sol";
import {MockERC721} from "solmate/test/utils/mocks/MockERC721.sol";
import {DSTestPlus} from "./utils/DSTestPlus.sol";

// Prettier is crapping out on test files
contract ERC42069Test is DSTestPlus {
    ERC42069 erc42069;
    MockERC721 mockERC721;

    function setUp() public {
        console.log(unicode"🧪 Testing ERC420721.sol...");
        mockERC721 = new MockERC721("TEST", "T_T");
        erc42069 = new ERC42069(mockERC721, "TEST_COIN", "TC", 18);
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
        mockERC721.approve(address(erc42069), 0);
        uint256[] memory id = new uint256[](1);
        id[0] = 0;
        erc42069.mint(id, address(0xBEEF));
    }

    function testWithdraw() public {
        testDeposit();
        uint256[] memory id = new uint256[](1);
        id[0] = 0;
        erc42069.withdraw(id, address(0xBEEF));
    }

    function testDepositDiffUser() public {
        testDeposit();
        vm.stopPrank();
        uint256[] memory id = new uint256[](1);
        id[0] = 0;
        vm.expectRevert(bytes("NOT_AUTHORIZED"));
        mockERC721.approve(address(erc42069), 0);
        vm.expectRevert(bytes("WRONG_FROM"));
        erc42069.mint(id, address(0xBEEF));
    }

    function testTransfer() public {
        testDeposit();
        erc42069.transfer(address(0), 1 wei);
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
        erc42069.transfer(address(0), 1 wei);
        uint256[] memory id = new uint256[](1);
        id[0] = 0;
        erc42069.withdraw(id, address(0xBEEF));
    }

    function testDepositReentrancy() public {
        testDeposit();
        testDeposit();
    }

    function testWithdrawReentrancy() public {
        testDeposit();
        uint256[] memory id = new uint256[](1);
        id[0] = 0;
        erc42069.withdraw(id, address(0xBEEF));
        erc42069.withdraw(id, address(0xBEEF));
    }
}


