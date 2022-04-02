import { Contract, ethers } from "ethers";
import { ERC42069_ABI } from "./abi/ERC42069_ABI";
import "dotenv/config";

/// ============ ETHERS PROVIDER SETUP ============

// Network to connect to
const network = "arbitrum-rinkeby";

// Read from .env
const api_key = process.env.ALCHEMY_API_KEY;

const provider = new ethers.providers.AlchemyProvider(network,
    api_key
);

/// ============ CONTRACT SETUP ============

/// TODO: Setup contract factory

// Contract Address
const ERC42069_ADDR = '0x29Bd3a45560E7D13Aa95aFC8cC68676454Eb75b0';

// The actual setup
const contract = new ethers.Contract(ERC42069_ADDR, ERC42069_ABI, provider);

/// ============ ASYNC FUNCTION CALLS ============

// here to make sure I didn't break shit
async function bro() {
    console.log(
        await contract.name() + " | ",
        await contract.symbol(), " | ",
        await contract.decimals()
    )
}

bro();