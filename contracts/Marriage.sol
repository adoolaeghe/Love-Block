pragma solidity ^0.4.4;

contract Marriage {
  bool public complete = false;
  address[2] public couple;
  address public personAddress;

  function marry() public returns (address) {
    personAddress = msg.sender;
    if (couple[0] == address(0x0)) {
      couple[0] = personAddress;
    } else {
      couple[1] = personAddress;
    }
    return personAddress;
  }

  function getCouple() public returns (address[2]) {
    return couple;
  }
}
