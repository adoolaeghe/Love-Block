pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Marriages.sol";

contract TestMarriages {
  Marriages marriages = Marriages(DeployedAddresses.Marriages());
  address testPartnerAddress = 0x123;
  event showAddress(address _sender, string _msg);


  function testContractAllowsMakingProposals() {
    uint32 testReturn = 0;
    Assert.notEqual(marriages.proposalNew(testPartnerAddress), testPartnerAddress, "Test contract allows making proposals.");
  }

  function testContractStoresProposal() {
    showAddress(marriages.proposals(this), "Proposals retirn");
    Assert.equal(marriages.proposals(this), testPartnerAddress, "Test contract stores proposal.");
  }
}

/*contract TestMarriages {
  Marriages marriages = Marriages(DeployedAddresses.Marriages());
  bytes32 firstName = "John";
  bytes32 middleName = "Spencer";
  bytes32 familyName = "Smith";
  bytes32 dateOfBirth = "19.02.1907";
  bytes32 placeOfBirth = "Edinbourgh";
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
