pragma solidity ^0.4.4;

contract Marriages {
  mapping (address => address) public proposals;
  mapping (address => bytes32) public marriageRecords;
  mapping (bytes32 => Marriage) public marriages;

  struct Marriage {
    bool complete;
    Person[] people;
  }

  struct Person {
    address _address;
    bytes32 firstName;
  }

  function proposalNew(address me, address myPartner) public returns (bool) {
    proposals[me] = myPartner;
    return true;
  }

  function proposalMatch(address me, address myPartner) public returns (bool) {
    return proposals[myPartner] == me ? true : false;
  }

  function marriageNew(address person1, address person2) public returns (bytes32) {
    bytes32 marId = keccak256(person1, person2);
    _newMarriageRecord(person1, marId);
    _newMarriageRecord(person2, marId);
    return marId;
  }

  function marriageStatus(bytes32 marId) public returns (bool) {
    return marriages[marId].complete;
  }

  function marriageGetPersonAddress(bytes32 marId, uint256 index) public returns (address) {
    return marriages[marId].people[index]._address;
  }

  function marriageRecordsId(address person) public returns (bytes32) {
    return marriageRecords[person];
  }

  function _newMarriageRecord(address person, bytes32 marId) private returns (bool) {
    marriageRecords[person] = marId;
    return true;
  }

  function addPerson(bytes32 marId, address _person, bytes32 firstName) public returns (bool) {
    marriages[marId].people.push(Person({_address:_person, firstName:firstName}));
    return true;
  }
}
