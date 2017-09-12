pragma solidity ^0.4.4;

contract Marriage {
  address[2] public couple;
  address public personAddress;

  function marry() public returns (address) {
    personAddress = msg.sender;
    return personAddress;
  }
}
