pragma solidity ^0.4.4;

contract Marriage {
  address[2] public couple;
  address public personAddress;

  function marry() public returns (address) {
    personAddress = msg.sender;
    couple[0] = personAddress;
    return personAddress;
  }

  function getCouple() public returns (address[2]) {
    return couple;
  }
}
