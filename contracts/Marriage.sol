pragma solidity ^0.4.4;

contract Marriage {
  bool public complete = false;
  address[2] public couple;
  address public personAddress;
  string public errorString = 'this person is not available';

  function marry() public returns (address) {
    personAddress = msg.sender;
    if (complete == false) {
      if (couple[0] == address(0x0)) {
        couple[0] = personAddress;
        return personAddress;
      } else {
        couple[1] = personAddress;
        switchToComplete();
        return personAddress;
      }
    }
  }

  function getCouple() public returns (address[2]) {
    return couple;
  }

  function switchToComplete() private returns (bool) {
    complete = true;
  }

  function returnErrorString() private returns (string) {
    return errorString;
  }
}
