// Foundry output abi to something like this plz??  Not really sure where to start if I wanna do that
export const ERC42069_ABI = [
  "function name() view returns (string)",
  "function decimals() view returns (uint8)",
  "function symbol() view returns (string)",
  "function approve(address spender, uint256 amount) public returns (bool)",
  "function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public",
  "function transfer(address to, uint256 amount) public returns (bool)",
  "function transferFrom(address from, address to, uint256 amount) public returns (bool)",
  "function deposit(uint256[] calldata tokenId, address receiver_) public returns (uint256)",
  "function withdraw(uint256[] calldata tokenId, address receiver_) public returns (uint256[] calldata)"
]