pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Marriages.sol";

contract TestMarriages {
  Marriages marriages = Marriages(DeployedAddresses.Marriages());
  address addressJohn = 0x124;
  address addressMary = 0x123;
  bytes32 marId = keccak256(addressJohn, addressMary);

  event showAddress(address _sender, string _msg);
  event showMarId(bytes32 _marId, string _msg);

  function testContractAllowsFirstProposal() {
    Assert.equal(marriages.proposalNew(addressJohn, addressMary), true, "Test contract allows making first proposal.");
  }

  function testForExistingProposalsAfterFirtstPersonProposed() {
    Assert.equal(marriages.proposalMatch(addressJohn, addressMary), false, "Matching proposal not found.");
  }

  function testContractStoresProposal() {
    Assert.equal(marriages.proposals(addressJohn), addressMary, "Test contract stores proposal.");
  }

  function testContractAllowsSecondProposal() {
    Assert.equal(marriages.proposalNew(addressMary, addressJohn), true, "Test contract allows making second proposal.");
  }

  function testForExistingProposalsAfterSecondPersonProposed() {
    Assert.equal(marriages.proposalMatch(addressJohn, addressMary), true, "Matching proposal found.");
  }

  function testContractAllowsNewMarriagesToBeCreated() {
    Assert.equal(marriages.marriageNew(addressJohn, addressMary), marId, "Test contract creates a marriage.");
  }

  function testContractCreatesNewIncompleteMarriage() {
    Assert.equal(marriages.marriageIsComplete(marId), false, "Test contract creates an incomplete marriage by default.");
  }

  function testContractCreatesMarriageRecord() {
    Assert.equal(marriages.marriageRecordsId(addressJohn), marId, "Test contract stores marriage records.");
  }

  function testContractAddsPersonToTheMarriage() {
    Assert.equal(marriages.addPerson(marId, addressJohn, "John", "Fred", "Smith", "01/01/80", 1), true, "Test contract allows a person to be added to the marriage object.");
  }

  function testContractStoresPersonInTheMarriage() {
    Assert.equal(marriages.marriageGetPersonAddress(marId, 0), addressJohn, "Test contract stores first person address.");
  }

  function testContractAddsSecondPersonToTheMarriage() {
    Assert.equal(marriages.addPerson(marId, addressMary, "Mary", "Kate", "Jones", "02/02/81", 2), true, "Test contract allows a second person to be added to the marriage object.");
  }

  function testContractSetsMarriageComplete() {
    Assert.equal(marriages.marriageIsComplete(marId), true, "The marriage sets complete after a second person has been added.");
  }
}
