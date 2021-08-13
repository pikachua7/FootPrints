pragma solidity ^0.5.16;

/**
 * @title Interface for contracts conforming to ERC-721
 */


contract PhotographyStorage {

    
    struct Photo {
        bytes32 id;
        address payable owner;
        address nftAddress;
        uint256 price;
    }
    
  uint256 public nftCounter;
    
  // From NFT registry assetId to Photo (to avoid asset collision)
  mapping (address => mapping(uint256 => Photo)) public photoByAssetId;
  
}