// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.12;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {ERC721} from "solmate/tokens/ERC721.sol";
import {SafeTransferLib} from "solmate/utils/SafeTransferLib.sol";
import {FixedPointMathLib} from "solmate/utils/FixedPointMathLib.sol";

/// @title Minimal ERC42069, a ERC721 to ERC20 and vice versa Vault implementation
/// @notice Still in testing phase, trying to reduce gas
/// @author Abran DeCarlo <abrandecarlo@protonmail.com>
contract ERC42069 is ERC20 {
  using SafeTransferLib for ERC20;
  using FixedPointMathLib for uint256;

  /// ============ EVENTS ============

  event Deposit(address indexed caller, address indexed receiver, uint256[] indexed assetId);
  event Withdraw(address indexed caller, address indexed receiver, uint256[] indexed assetId);

  /// ============ IMMUTABLES ============

  ERC721 public immutable erc721Asset;

  /// ============ CONSTRUCTOR ============

  constructor(
    ERC721 _erc721Asset,
    string memory _name,
    string memory _symbol,
    uint8 _decimals
  ) ERC20 (_name, _symbol, _decimals) {
    erc721Asset = _erc721Asset; 
  }


  /// ============ DEPOSIT/WITHDRAW FUNCTIONS ============

  /// @param tokenId tokenId(s) to send to vault.
  /// @param receiver_ receiver of minted ERC20 tokens
  function mint(uint256[] calldata tokenId, address receiver_) public returns (uint256) {
   
      for (uint256 i; i < tokenId.length;) {
        erc721Asset.transferFrom(address(msg.sender), address(this), tokenId[i]);
        
        // The _mint() function better be the last thing in the loop
        _mint(address(receiver_), 1e18);

        // Impossible to overflow
        unchecked {++i;}
      }

      uint256 amount;

      emit Deposit(address(msg.sender), receiver_, tokenId);

      return amount = 1e18 * tokenId.length;
  }

  /// @param tokenId The tokenId(s) that a msg.sender wants to withdraw.
  /// @param receiver_ The address to send the ERC721 tokens to.
  /// @return tokenId The tokenId(s) sent to receiver_
  // Removing requirement statement for approval cuts gas cost by a lot for users,
  // still reverts on _burn() if msg.sender doesn't have enough erc20 tokens to transfer
  function withdraw(uint256[] calldata tokenId, address receiver_) public returns (uint256[] calldata) {
    
    for (uint256 i; i < tokenId.length;) {
        _burn(address(msg.sender), 1e18);
        erc721Asset.transferFrom(address(this), address(receiver_), tokenId[i]);
      
        // impossible to overflow
        unchecked {++i;}
  }

      uint256 amount;

      emit Withdraw(msg.sender, receiver_, tokenId);
      
      return tokenId;
  }
}
