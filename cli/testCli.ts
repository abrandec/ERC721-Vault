import { Contract, ethers } from "ethers";
import { erc42069 } from "./abi/ERC42069";
import "dotenv/config";

// Network to connect to
const network = "arbitrum-rinkeby";

// Read from .env
const api_key = process.env.ALCHEMY_API_KEY;

// Contract Addresses
const ERC42069_ADDR = '0x29Bd3a45560E7D13Aa95aFC8cC68676454Eb75b0';

const provider = new ethers.providers.AlchemyProvider(network,
    api_key
);

const contract = new ethers.Contract(ERC42069_ADDR, erc42069, provider);
async function bro() {
    console.log(
        await contract.name() + " | ",
        await contract.symbol(), " | ",
        await contract.decimals()
    )
}

bro();