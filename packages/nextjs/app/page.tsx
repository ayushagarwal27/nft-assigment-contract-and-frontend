"use client";

import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { Address } from "~~/components/scaffold-eth";

const Home: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  async function mintNFT() {
    const response = await fetch("http://localhost:3000/mint", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        address: connectedAddress,
      }),
    });
    console.log(await response.json());
  }

  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="px-5 flex flex-col items-center">
          <h1 className="text-center">
            <span className="block text-2xl mb-2">Welcome </span>
          </h1>
          <div className="flex justify-center items-center space-x-2 flex-col sm:flex-row">
            <p className="my-2 font-medium">Connected Address:</p>
            <Address address={connectedAddress} />
          </div>

          <button onClick={mintNFT} className="bg-sky-500 px-4 py-2 rounded-lg hover:opacity-80 mx-auto text-white">Mint NFT</button>
        </div>
      </div>
    </>
  );
};

export default Home;
