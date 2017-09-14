pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Marriages.sol";

contract TestMarriages {
  Marriages marriages = Marriages(DeployedAddresses.Marriages());

  function testContractAcceptsNewPerson() {
    bytes32 firstName = "John";
    bytes32 middleName = "Spencer";
    bytes32 familyName = "Smith";
    bytes32 dateOfBirth = "19.02.1907";
    bytes32 placeOfBirth = "Edinbourgh";
    uint id = 1287163912837;
    bool expectedStatus = marriages.addPerson(firstName, middleName, familyName, dateOfBirth, placeOfBirth, id);
    Assert.equal(expectedStatus, true, "Contract accepts a new person.");
  }
}
