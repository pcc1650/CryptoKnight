pragma solidity ^0.4.19;

contract CryptoKnight {

  event NewKnight(uint knightId, string name, uint dna);

  uint dnaDigits = 8;
  uint dnaModulus = 10 ** dnaDigits;

  struct Knight {
    string name;
    uint dna;
  }

  Knight[] public knights;

  mapping (uint => address) public knightToOwner;
  mapping (address => uint) public ownerKnightCount;

  function _createKnight(string _name, uint _dna) private {
    uint id = knights.push(Knight(_name, _dna)) - 1;
    knightToOwner[id] = msg.sender;
    ownerKnightCount[msg.sender]++;
    NewKnight(id, _name, _dna);
  }

  function _generateRandomDna(string _str) private view returns (uint) {
    uint rand = uint(keccak256(_str));
    return rand % dnaModulus;
  }

  function createRandomKnight(string _name) public {
    uint randDna = _generateRandomDna(_name);
    _createKnight(_name, randDna);
  }

  function getKnightsCount() public constant returns (uint) {
    return knights.length;
  }

  function getKnight(uint index) public constant returns(string, uint) {
    return (knights[index].name, knights[index].dna);
  }
}
