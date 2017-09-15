pragma solidity ^0.4.4;

contract Proposal {
  address[] public proposals;

  function sendProposal(address personAddress) public returns (address) {
    proposals[0] = personAddress;
    return personAddress;
    }
}
