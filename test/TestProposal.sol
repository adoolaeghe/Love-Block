pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Proposal.sol";

contract TestProposal {
  Proposal proposal = Proposal(DeployedAddresses.Proposal());

  function canCreateNewProposal() {
    address expectedAddress = 0x0;
    address person2 = 0x0;
    address person2Address = proposal.sendProposal(person2);
    Assert.equal(expectedAddress, person2Address, "Can create new proposal");
  }
}
