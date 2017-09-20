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

  /* Creation and completion of the marriage */

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
    Assert.equal(marriages.marriageNew(addressMary, addressJohn), marId, "Test contract creates a marriage.");
  }

  function testContractHasDefaultTimestampOfZero() {
    Assert.equal(marriages.timeStamp(marId), 0, "Test contract has default timestamp of zero");
  }

  function testContractCreatesNewIncompleteMarriage() {
    Assert.equal(marriages.marriageIsComplete(marId), false, "Test contract creates an incomplete marriage by default.");
  }

  function testContractCreatesMarriageRecord() {
    Assert.equal(marriages.marriageGetMarIdForPerson(addressJohn), marId, "Test contract stores marriage records.");
  }

  function testContractAddsPersonToTheMarriage() {
    Assert.equal(marriages.addPerson(marId, addressJohn, "John", "Fred", "Smith", "01/01/80", 123456), true, "Test contract allows a person to be added to the marriage object.");
  }

  function testContractAddsSecondPersonToTheMarriage() {
    Assert.equal(marriages.addPerson(marId, addressMary, "Mary", "Kate", "Jones", "02/02/81", 234567), true, "Test contract allows a second person to be added to the marriage object.");
  }

  function testContractSetsMarriageComplete() {
    Assert.equal(marriages.marriageIsComplete(marId), true, "The marriage sets complete after a second person has been added.");
  }

  function testContractAddsTimestamp() {
    Assert.notEqual(marriages.timeStamp(marId), 0, "Test contract adds a timestamp upon completion of the marriage.");
  }

  /* Retreiving the complete certificate data */

  function testContractStoresPeoplesAddresses() {
    Assert.equal(marriages.marriageGetPersonAddress(marId, 0), addressJohn, "Test contract stores first person address.");
    Assert.equal(marriages.marriageGetPersonAddress(marId, 1), addressMary, "Test contract stores second person address.");
  }

  function testContractStoresPeoplesFirstNames() {
    Assert.equal(marriages.marriageGetPersonFirstName(marId, 0), "John", "Test contract stores first persons first name");
    Assert.equal(marriages.marriageGetPersonFirstName(marId, 1), "Mary", "Test contract stores second persons first name");
  }

  function testContractStoresPeoplesMiddleNames() {
    Assert.equal(marriages.marriageGetPersonMiddleName(marId, 0), "Fred", "Test contract stores first persons middle name");
    Assert.equal(marriages.marriageGetPersonMiddleName(marId, 1), "Kate", "Test contract stores second persons middle name");
  }

  function testContractStoresPeoplesLastNames() {
    Assert.equal(marriages.marriageGetPersonLastName(marId, 0), "Smith", "Test contract stores first persons middle name");
    Assert.equal(marriages.marriageGetPersonLastName(marId, 1), "Jones", "Test contract stores second persons middle name");
  }

  function testContractStoresPeoplesDateOfBirth() {
    Assert.equal(marriages.marriageGetPersonDateOfBirth(marId, 0), "01/01/80", "Test contract stores first persons middle name");
    Assert.equal(marriages.marriageGetPersonDateOfBirth(marId, 1), "02/02/81", "Test contract stores second persons middle name");
  }

  function testContractStoresPeoplesId() {
    Assert.equal(marriages.marriageGetPersonId(marId, 0), 123456, "Test contract stores first persons middle name");
    Assert.equal(marriages.marriageGetPersonId(marId, 1), 234567, "Test contract stores second persons middle name");
  }
}
