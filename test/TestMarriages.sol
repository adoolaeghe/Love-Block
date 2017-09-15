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
    Assert.equal(marriages.proposalMatch(addressJohn, addressMary), false, "Matching proposal not found");
  }

  function testContractStoresProposal() {
    Assert.equal(marriages.proposals(addressJohn), addressMary, "Test contract stores proposal.");
  }

  function testContractAllowsSecondProposal() {
    Assert.equal(marriages.proposalNew(addressMary, addressJohn), true, "Test contract allows making second proposal.");
  }

  function testForExistingProposalsAfterSecondPersonProposed() {
    Assert.equal(marriages.proposalMatch(addressJohn, addressMary), true, "Matching proposal found");
  }

  function testContractAllowsNewMarriagesToBeCreated() {
    showMarId(marId, "This is the marId");
    Assert.equal(marriages.marriageNew(addressJohn, addressMary), marId, "Test contract creates a marriage");
  }

  function testContractCreatesNewIncompleteMarriage() {
    Assert.equal(marriages.marriageStatus(marId), false, "Test contract creates an incomplete marriage by default");
  }

  function testContractCreatesMarriageRecord() {
    Assert.equal(marriages.marriageRecordsId(addressJohn), marId, "Test contract stores marriage records.");
  }

  function testContractAddsPersonToTheMarriage() {
    Assert.equal(marriages.addPerson(marId, addressJohn, "John"), true, "Test contract allows a person to be added to the marriage object");
  }
}

/*contract TestMarriages {
  Marriages marriages = Marriages(DeployedAddresses.Marriages());
  bytes32 firstName = "John";
  bytes32 middleName = "Spencer";
  bytes32 familyName = "Smith";
  bytes32 dateOfBirth = "19.02.1907";
  bytes32 placeOfBirth = "Edinburgh";
  uint id = 1287163912837;

  function testContractAcceptsNewPerson() {
    bool expectedStatus = marriages.addPerson(firstName, middleName, familyName, dateOfBirth, placeOfBirth, id);
    Assert.equal(expectedStatus, true, "Contract accepts a new person.");
  }

  function testContractStoresNewPerson() {
    var (returnedAddress,
          returnedFirstName,
          returnedMiddleName,
          returnedFamilyname,
          returnedDateOfBirth,
          returnedPlaceOfBirth,
          returnedId) = marriages.getPerson(0);

    Assert.equal(returnedAddress, this, "Contract stores a new person address.");
    Assert.equal(returnedFirstName, firstName, "Contract stores a new person first name.");
    Assert.equal(returnedMiddleName, middleName, "Contract stores a new person middle name.");
    Assert.equal(returnedFamilyname, familyName, "Contract stores a new person family name.");
    Assert.equal(returnedDateOfBirth, dateOfBirth, "Contract stores a new person date of birth.");
    Assert.equal(returnedPlaceOfBirth, placeOfBirth, "Contract stores a new person place of birth.");
    Assert.equal(returnedId, id, "Contract stores a new person id number.");
  }
}*/
