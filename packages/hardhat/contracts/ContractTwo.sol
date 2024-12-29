//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../contracts/ContractOne.sol";

contract ContractTwo is ERC721 {
    uint256 public totalSupply;
    uint256 public constant MAX_SUPPLY = 40;
    uint256 public constant FIRST_15_COST = 0.00000005 ether;
    uint256 public constant REMAINING_COST = 0.0006 ether;
    uint256 public constant NAME_COST = 0.0004 ether;
    
    ContractOne public contractOne;
    mapping(uint256 => string) public customNames;

     event NameChanged(uint256 indexed tokenId, string newName);

    constructor(address contractOneAddress) ERC721("ContractTwoNFT", "CTWO") {
        contractOne = ContractOne(contractOneAddress);
        totalSupply = 0;
    }

    function mintNFT(uint256 quantity, string memory customName) public payable {
        require(quantity > 0 && quantity <= 5, "Can mint between 1 and 5 NFTs per transaction");
        require(totalSupply + quantity <= MAX_SUPPLY, "Exceeds maximum supply");
        require(contractOne.balanceOf(msg.sender) > 0, "Must own an NFT from ContractOne");

        uint256 cost;
        if (totalSupply < 15) {
            cost = FIRST_15_COST * quantity;
        } else {
            cost = REMAINING_COST * quantity;
        }

        if (bytes(customName).length > 0) {
            cost += NAME_COST;
        }

        require(msg.value >= cost, "Insufficient ETH sent");

        for (uint256 i = 0; i < quantity; i++) {
            totalSupply += 1;
            _safeMint(msg.sender, totalSupply);
            if (bytes(customName).length > 0) {
                customNames[totalSupply] = customName;
                 emit NameChanged(totalSupply, customName);
            }
        }
    }
}
