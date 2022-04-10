// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.12;

import {ERC721Vault} from "../ERC721Vault.sol";
import {MockERC721} from "../ERC721/MockERC721.sol";
import {DSTestPlus} from "./utils/DSTestPlus.sol";

// Prettier is crapping out on test files
contract ERC721VaultTest is DSTestPlus {
    ERC721Vault erc721Vault;
    MockERC721 mockERC721;

    /// ============ SETUP ============
    
    function setUp() public {
        console.log(unicode"🧪 Testing ERC721Vault.sol...");
        mockERC721 = new MockERC721("TEST", "T_T");
        erc721Vault = new ERC721Vault(mockERC721, "TEST_COIN", "TC", 18);
    }

    /// ============ SINGLE DEPOSIT/WITHDRAW TESTS ============
    
    function testDeposit() public {
        // mint tokenId 0 to 0xBEEF
        mockERC721.mint(address(0xBEEF), 0);
        vm.startPrank(address(0xBEEF));
        mockERC721.approve(address(erc721Vault), 0);
        erc721Vault.deposit(0, address(0xBEEF));
    }

    /// ============ BULK DEPOSIT/WITHDRAW TESTS ============
    
    function testDepositBulk() public {
        uint256[] memory id = new uint256[](6);
        // the only working way is the dirtiest one
        id[0] = 0;
        id[1] = 1;
        id[2] = 2;
        id[3] = 3;
        id[4] = 4;
        id[5] = 5;

        vm.startPrank(address(0xBEEF)); 
        for (uint256 i = 0; i < id.length; ++i) {
            mockERC721.mint(address(0xBEEF), id[i]);
            mockERC721.approve(address(erc721Vault), id[i]);
        }

        erc721Vault.depositBulk(id, address(0xBEEF));
    }

    function testWithdrawBulk() public {
        uint256[] memory id = new uint256[](6);
        // the only working way is the dirtiest one
        id[0] = 0;
        id[1] = 1;
        id[2] = 2;
        id[3] = 3;
        id[4] = 4;
        id[5] = 5;

        testDepositBulk();

        erc721Vault.withdrawBulk(id, address(0xBEEF));
    }

 
    /// ============ TESTS INTENDED TO FAIL ============

    // Deposit someone elses NFTs
    function testFailDepositDiffUser() public {
        testDepositBulk();
        vm.stopPrank();
        uint256[] memory id = new uint256[](1);
        id[0] = 0;
        mockERC721.approve(address(erc721Vault), 0);
        erc721Vault.deposit(id[0], address(0xBEEF));
    }

  
    function testFailWithdrawBulkDiffUser() public {
        uint256[] memory id = new uint256[](6);
        // the only working way is the dirtiest one
        id[0] = 0;
        id[1] = 1;
        id[2] = 2;
        id[3] = 3;
        id[4] = 4;
        id[5] = 5;

        testDepositBulk();
        vm.stopPrank();
        for (uint256 i = 0; i < id.length; ++i){
        erc721Vault.withdrawBulk(id, address(0xBEEF));
        }
    }

    // Results in Arithmetic over/underflow
    function testFailWithdrawNotEnough() public {
        erc721Vault.transfer(address(1), 1e18);
    }

    function testFailNotOwnerOfERC20() public {
        testDepositBulk();
        vm.stopPrank();
        erc721Vault.transfer(address(1), 1e18);
    }

    /// ============ REENTRANCY TESTS ============

    function testFailDepositTwice() public {
        vm.startPrank(address(0xBEEF)); 
        mockERC721.mint(address(0xBEEF), 0);
        mockERC721.approve(address(erc721Vault), 0);
        erc721Vault.deposit(0, address(0xBEEF));
        erc721Vault.deposit(0, address(0xBEEF));
    }

    function testFailWithdrawTwice() public {
        uint256[] memory id = new uint256[](2);
        // the only working way is the dirtiest one
        id[0] = 0;
        id[1] = 1;
       
        testDepositBulk();
       
        erc721Vault.withdraw(id[0], address(0xBEEF));
        erc721Vault.withdraw(id[0], address(0xBEEF));
      
    }

    function testFailDepositBulkTwice() public {
        uint256[] memory id = new uint256[](6);
        // the only working way is the dirtiest one
        id[0] = 0;
        id[1] = 1;
        id[2] = 2;
        id[3] = 3;
        id[4] = 4;
        id[5] = 5;

        vm.startPrank(address(0xBEEF)); 
        for (uint256 i = 0; i < id.length; ++i) {
            mockERC721.mint(address(0xBEEF), id[i]);
            mockERC721.approve(address(erc721Vault), id[i]);
        }

        erc721Vault.depositBulk(id, address(0xBEEF));
        erc721Vault.depositBulk(id, address(0xBEEF));
    }

    function testFailWithdrawBulkTwice() public {
        uint256[] memory id = new uint256[](6);
        // the only working way is the dirtiest one
        id[0] = 0;
        id[1] = 1;
        id[2] = 2;
        id[3] = 3;
        id[4] = 4;
        id[5] = 5;

        testDepositBulk();

        erc721Vault.withdrawBulk(id, address(0xBEEF));
        erc721Vault.withdrawBulk(id, address(0xBEEF));
    }
}


