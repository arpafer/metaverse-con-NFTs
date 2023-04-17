// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Openzeppelin imports
import "@openzeppelin/contracts@4.4.2/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.4.2/access/Ownable.sol";
import "@openzeppelin/contracts@4.4.2/utils/Counters.sol";

// 0x476Dfee8Ff4128F03781e64DC0d0A855F5eC0461

contract Metaverse is ERC721, Ownable {
   
    constructor() ERC721("META", "APF") {

    }

   // Contadores para regular la cantidad actual de tokens NFT minted
   using Counters for Counters.Counter;
   Counters.Counter private supply;

   // Número total de tokens que estan disponibles
   uint256 public maxSupply = 100;

   // Coste pagado para cada token
   uint256 public cost = 0.001 ether;

   // Propietario y sus propiedades en el metaverso
   mapping (address => Building []) NFTOwners;

   struct Building {
       string name;
       int8 w;
       int8 h;
       int8 d;
       int8 x;
       int8 y;
       int8 z;
   }

   // lista de las construcciones que hay en el metaveso
   Building[] public buildings;

   function getBuildings() public view returns (Building[] memory) {
       return buildings;
   }

   // Tokens NFT creados actualmente
   function totalSupply() public view returns (uint256) {
       return supply.current();
   }

   // creación de las construcciones como un token NFT en el metaverso
   function mint(string memory _buildingName, int8 _w, int8 _h, int8 _d, int8 _x, int8 _y, int8 _z) public payable {
       require(supply.current() <= maxSupply, "Max supply se ha excedido");
       require(msg.value >= cost, "Fondos insuficientes");
       supply.increment();
       _safeMint(msg.sender, supply.current());
       Building memory _newBuild = Building(_buildingName, _w, _h, _d, _x, _y, _z);
       buildings.push(_newBuild);
       NFTOwners[msg.sender].push(_newBuild);
   }

   // functión de extracción de fondos
   function withdraw() external payable onlyOwner {
       address payable _owner = payable(owner());
       _owner.transfer(address(this).balance);
   }

   function getOwnerBuildings() public view returns (Building[] memory) {
       return NFTOwners[msg.sender];
   }

   
}