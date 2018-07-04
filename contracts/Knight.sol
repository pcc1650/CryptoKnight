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

  function _createKnight(string _name, uint8 _dna) private {
    Knight memory knight = Knight(_name, _dna);
    uint id = knights.push(knight) - 1;
    knightToOwner[id] = msg.sender;
    ownerKnightCount[msg.sender]++;
    NewKnight(id, _name, _dna);
  }

  function _generateRandomDna(string _str) private view returns (uint8) {
    uint rand = uint(keccak256(_str));
    return uint8(rand % dnaModulus);
  }

  function createRandomKnight(string _name) public {
    uint8 randDna = _generateRandomDna(_name);
    _createKnight(_name, randDna);
  }

  function getKnightsCount() public view returns (uint) {
    return knights.length;
  }

  function getKnight(uint index) public view returns(string, uint) {
    return (knights[index].name, knights[index].dna);
  }
}
