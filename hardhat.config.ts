import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";
const MNEMONIC = process.env.MNEMONIC;

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    hardhat: {
      accounts: {
        mnemonic: MNEMONIC,
        initialIndex: 0,
        path: "m/44'/60'/0'/0",
        count: 1, // adjust number of accounts
        accountsBalance: '100000000000000000000', // 100 ETH in wei
      },
    },
  }
};

export default config;
