# 📚 Learn Smart Contract in One Day

------

## 🛠️Overview

This project is a **full-stack Web3 DApp** demo built in just one day!
 It showcases the complete flow from smart contract development to frontend interaction, using modern blockchain development tools.

------

## 🛠️ Tech Stack



| Layer                    | Technology                      | Purpose                                                  |
| ------------------------ | ------------------------------- | -------------------------------------------------------- |
| Backend (Smart Contract) | **Solidity**                    | Write and deploy smart contracts                         |
| Backend IDE              | **Remix IDE**                   | Solidity code editor, compiler, and blockchain simulator |
| Frontend Framework       | **Next.js (React-based)**       | Build user interface (DApp frontend)                     |
| Frontend Programming     | **TypeScript + React**          | Interactive frontend components                          |
| Blockchain Connector     | **ethers.js**                   | Connect frontend with deployed smart contracts           |
| Frontend IDE             | **Visual Studio Code (VSCode)** | Write and manage frontend source code                    |



## 📂 Project Steps

Summary-Write and test the smart contract in Remix using Solidity, then copy the ABI. Build the frontend in VSCode with Next.js and ethers.js, connect to the blockchain, and use the ABI to interact with the deployed contract.
Here is teach you the basic step and related code,the full code is in Code Chapter

1. **Write the Smart Contract (Backend) using Remix IDE**

   - Use Remix IDE to write your smart contract in **Solidity**.
   - Compile the contract using the built-in compiler.
   - Deploy the contract to the **Remix VM** or a real testnet (e.g., Sepolia).
   - After deployment, **test the contract functions** directly in Remix to verify that it behaves as expected.
   - Once deployed, **copy the contract's ABI (Application Binary Interface)** and address — you’ll need these for frontend integration.

2. **Build the Frontend using Next.js + ethers.js in VSCode**

   - Open **Visual Studio Code** and create a new project using the **Next.js** framework (React-based).

   - Install the `ethers.js` package to interact with the blockchain:

     ```
     npm install ethers
     ```
     
   - In your frontend project, create a file (e.g., `contractInfo.ts`) to store your **contract address** and **ABI**.
   
   - Use `ethers.js` in your frontend to:

     - Connect to MetaMask (or another Web3 wallet)
     - Read data from the contract (e.g., `get()` methods)
     - Send transactions to the contract (e.g., `set()` or `deposit()` methods)

   - Run your frontend with:
   
     ```
     npm run dev
     ```
     
   - Open your browser at http://localhost:3000 and interact with your smart contract through a user-friendly interface.

## 📂 Full Code here

### 🧱 Step 1: Smart Contract (Solidity) — Backend

#### 1. Open Remix IDE

#### 2. Create a new file: `SimpleStorage.sol`

Paste this code:

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleStorage {
    uint256 public storedValue;

    function set(uint256 _value) public {
        storedValue = _value;
    }

    function get() public view returns (uint256) {
        return storedValue;
    }
}
```

#### 3. Compile

- Click the **Solidity Compiler** tab
- Choose version `0.8.20` or similar
- Click **Compile SimpleStorage.sol**

#### 4. Deploy & Test

- Go to **Deploy & Run Transactions**
- Environment: `Remix VM (London)`
- Click **Deploy**
- Use `set()` and `get()` buttons to test

#### 5. Copy the ABI and contract address

- Click the contract in the **Deployed Contracts** panel
- Click the `{}` icon → **Copy ABI**
- Copy contract address (e.g., `0x...`) from **Deployed Contracts**

------

### 💻 Step 2: Frontend (Next.js + ethers.js) — Frontend

#### 1. Create a Next.js App

```
npx create-next-app@latest my-dapp
cd my-dapp
npm install ethers
```

#### 2. Create contractInfo.ts

Create `constants/contractInfo.ts` and paste:

```
export const contractAddress = "0xYourContractAddressHere"; // Replace with Remix address

export const contractABI = [
  {
    "inputs": [{ "internalType": "uint256", "name": "_value", "type": "uint256" }],
    "name": "set",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "get",
    "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }],
    "stateMutability": "view",
    "type": "function"
  }
];
```

------

#### 3. Update `pages/index.tsx`

```
'use client'; // If using Next.js 13+

import { useState } from "react";
import { ethers } from "ethers";
import { contractAddress, contractABI } from "../constants/contractInfo";

export default function Home() {
  const [value, setValue] = useState<number>(0);
  const [currentValue, setCurrentValue] = useState<number>(0);

  async function connectWallet() {
    if (typeof window.ethereum !== "undefined") {
      await window.ethereum.request({ method: "eth_requestAccounts" });
    }
  }

  async function setStorage() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(contractAddress, contractABI, signer);
    const tx = await contract.set(value);
    await tx.wait();
  }

  async function getStorage() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const contract = new ethers.Contract(contractAddress, contractABI, provider);
    const val = await contract.get();
    setCurrentValue(val.toNumber());
  }

  return (
    <div className="flex flex-col items-center justify-center min-h-screen">
      <button onClick={connectWallet}>Connect Wallet</button>
      <input type="number" value={value} onChange={(e) => setValue(Number(e.target.value))} />
      <button onClick={setStorage}>Set Storage</button>
      <button onClick={getStorage}>Get Storage</button>
      <p>Stored Value: {currentValue}</p>
    </div>
  );
}
```

------

### 🧪 Step 3: Run the DApp

```
npm run dev
```

- Visit http://localhost:3000
- Connect MetaMask
- Try setting and getting a value

✅ It will interact with the contract you deployed via Remix!
