//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ContractOne is ERC721 {
    uint256 public totalSupply;
    uint256 public constant MAX_SUPPLY = 100;
    mapping(address => bool) public hasMinted;

    constructor() ERC721("ContractOneNFT", "CONE") {
        totalSupply = 0;
    }

    function mintNFT() public {
        require(totalSupply < MAX_SUPPLY, "All NFTs have been minted");
        require(!hasMinted[msg.sender], "You have already minted an NFT");

        totalSupply += 1;
        hasMinted[msg.sender] = true;
        _safeMint(msg.sender, totalSupply);
    }
}