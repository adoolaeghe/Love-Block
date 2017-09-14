pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Marriages.sol";

contract TestMarriages {
  Marriages marriages = Marriages(DeployedAddresses.Marriages());

  function testContractAcceptsNewPerson() {
    address personAddress = msg.sender;
    string firstName = 'John';
    string middleName = 'Spencer';
    string familyName = 'Smith';
    string dateOfBirth = '19.02.1907';
    string placeOfBirth = 'Edinbourgh';
    int id = 1287163912837;
    bool expectedStatus = marriages.addPerson(personAddress, firstName, middleName, familyName, dateOfBirth, placeOfBirth, id);
    Assert.equal(expectedStatus, true, 'Contract accepts a new person.');
  }
}
