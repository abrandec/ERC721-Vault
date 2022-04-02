
# ERC42069 Vault • [![tests](https://github.com/abrandec/erc-42069/actions/workflows/tests.yml/badge.svg)](https://github.com/abrandec/erc-42069/actions/workflows/tests.yml) [![lints](https://github.com/abrandec/erc-42069/actions/workflows/lints.yml/badge.svg)](https://github.com/abrandec/erc-42069/actions/workflows/lints.yml) ![GitHub](https://img.shields.io/github/license/abrandec/erc-42069)  ![GitHub package.json version](https://img.shields.io/github/package-json/v/abrandec/erc-42069)

A minimal ERC42069 Vault Implementation for converting ERC721 to ERC20 and vice versa

## Blueprint

```ml
lib
├─ ds-test — https://github.com/dapphub/ds-test
├─ forge-std — https://github.com/brockelmore/forge-std
├─ solmate — https://github.com/Rari-Capital/solmate
├─ clones-with-immutable-args — https://github.com/wighawag/clones-with-immutable-args
src
├─ tests
│  └─ ERC42069.t — "ERC42069 Tests"
└─ ERC42069 — "A Minimal Implementation of a ERC42069 Vault Contract"
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

**Deployment & Verification**

Inside the [`scripts/`](./scripts/) directory are a few preconfigured scripts that can be used to deploy and verify contracts.

Scripts take inputs from the cli, using silent mode to hide any sensitive information.

NOTE: These scripts are required to be _executable_ meaning they must be made executable by running `chmod +x ./scripts/*`.

NOTE: For local deployment, make sure to run `yarn` or `npm install` before running the `deploy_local.sh` script. Otherwise, hardhat will error due to missing dependencies.

NOTE: these scripts will prompt you for the contract name and deployed addresses (when verifying). Also, they use the `-i` flag on `forge` to ask for your private key for deployment. This uses silent mode which keeps your private key from being printed to the console (and visible in logs).


[AGPL-3.0-only](https://github.com/abrandec/erc-42069/blob/master/LICENSE)

## Acknowledgements

- [femplate](https://github.com/abigger87/femplate) by [abigger87](https://github.com/abigger87).
- [foundry](https://github.com/gakonst/foundry)
- [solmate](https://github.com/Rari-Capital/solmate)
- [forge-std](https://github.com/brockelmore/forge-std)
- [clones-with-immutable-args](https://github.com/wighawag/clones-with-immutable-args).
- [foundry-toolchain](https://github.com/onbjerg/foundry-toolchain) by [onbjerg](https://github.com/onbjerg).
- [forge-template](https://github.com/FrankieIsLost/forge-template) by [FrankieIsLost](https://github.com/FrankieIsLost).
- [Georgios Konstantopoulos](https://github.com/gakonst) for [forge-template](https://github.com/gakonst/forge-template) resource.

## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._
