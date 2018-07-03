// pragma solidity ^0.4.19;
pragma experimental ABIEncoderV2;

contract CryptoKnight {

  event NewKnight(uint knightId, string name, uint dna);

  uint dnaDigits = 8;
  uint dnaModulus = 10 ** dnaDigits;

  struct Knight {
    string name;
    uint dna;
  }

  Knight[] public knights;

  function _createKnight(string _name, uint _dna) private {
    uint id = knights.push(Knight(_name, _dna)) - 1;
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

  function getKnights() public view returns (Knight[]) {
    return knights;
  }
}
