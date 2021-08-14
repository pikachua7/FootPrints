pragma solidity ^0.5.16;

import "./NFT.sol";
import "./ERC721Token.sol";
import "./SafeMath.sol";
import "./AddressUtils.sol";
import "./PhotographyStorage.sol";

contract Photography is PhotographyStorage{
    
    uint256 public marketPlaceCounter=0;

    mapping (uint256 => uint256) public marketPlaceNFT;
    
    function setOnSale(        
        address nftAddress,
        uint256 assetId,
        uint256 priceInWei) public{
        
        address assetOwner = NFT(nftAddress).ownerOf(assetId);
        
        bytes32 photoId = keccak256(
            abi.encodePacked(
                block.timestamp,
                assetOwner,
                assetId,
                nftAddress,
                priceInWei
            )
        );

        marketPlaceNFT[marketPlaceCounter]=assetId;
        marketPlaceCounter=marketPlaceCounter+1;

        photoByAssetId[nftAddress][assetId] = Photo({
            id: photoId,
            owner: address(uint160(assetOwner)),
            nftAddress: nftAddress,
            price: priceInWei
        });
        
    }
    
    function buyPhoto(        
        address nftAddress,
        uint256 assetId,
        uint256 priceInWei) public payable{
        
        address sender = msg.sender; //buyer
    
        Photo memory photo = photoByAssetId[nftAddress][assetId];
    
        require(photo.id != 0, "Asset not published");
        require(priceInWei == msg.value, "msg.value is not correct");
        address payable seller = photo.owner;
        
        
        delete photoByAssetId[nftAddress][assetId];
        
        // Transfer sale amount to seller
        seller.transfer(msg.value);
        
        NFT(nftAddress).approve(sender, assetId);
        // Transfer asset owner
        NFT(nftAddress).transferFrom(
          seller,
          sender,
          assetId
        );
        
    }
}