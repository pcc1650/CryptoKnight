pragma solidity ^0.4.19;

contract CryptoKnight {

  event NewKnight(uint knightId, string name, uint dna);

  uint8 dnaDigits = 8;
  uint dnaModulus = 10 ** dnaDigits;

  struct Knight {
    string name;
    uint8 dna;
  }

  Knight[] public knights;

  mapping (uint => address) public knightToOwner;
  mapping (address => uint) public ownerKnightCount;

  function _createKnight(string _name, uint8 _dna) private returns (uint){
    Knight memory knight = Knight(_name, _dna);
    uint id = knights.push(knight) - 1;
    knightToOwner[id] = msg.sender;
    ownerKnightCount[msg.sender]++;
    emit NewKnight(id, _name, _dna);
    return id;
  }

  function _generateRandomDna(string _str) private view returns (uint8) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return uint8(rand % dnaModulus);
  }

  function createRandomKnight(string _name) public returns (uint){
    uint8 randDna = _generateRandomDna(_name);
    uint res = _createKnight(_name, randDna);
    return res;
  }

  function getKnightsCount() public view returns (uint) {
    return knights.length;
  }

  function getKnight(uint index) public view returns(string, uint) {
    return (knights[index].name, knights[index].dna);
  }
}
