
# ERC721 Vault • [![tests](https://github.com/abrandec/ERC721-Vault/actions/workflows/tests.yml/badge.svg)](https://github.com/abrandec/ERC721-Vault/actions/workflows/tests.yml) [![lints](https://github.com/abrandec/ERC721-Vault/actions/workflows/lints.yml/badge.svg)](https://github.com/abrandec/ERC721-Vault/actions/workflows/lints.yml) ![GitHub](https://img.shields.io/github/license/abrandec/ERC721-Vault)  ![GitHub package.json version](https://img.shields.io/github/package-json/v/abrandec/ERC721-Vault)

A minimal ERC721 Vault Implementation for converting ERC721 NFTs to ERC20 assets and vice versa

1 NFT == 1e18

## Blueprint

```ml
lib
├─ ds-test — https://github.com/dapphub/ds-test
├─ forge-std — https://github.com/brockelmore/forge-std
├─ solmate — https://github.com/Rari-Capital/solmate
├─ clones-with-immutable-args — https://github.com/wighawag/clones-with-immutable-args
src
├─ tests
│  └─ ERC7210Vault.t — "ERC721Vault Tests"
└─ ERC721Vault — "A Minimal Implementation of a ERC721 Vault Contract"
```

## Development

**Setup**
```bash
make
# OR #
make setup
```

**Building**
```bash
make build
```

**Testing**
```bash
make test
```
## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._
