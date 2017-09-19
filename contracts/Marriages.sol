pragma solidity ^0.4.4;

contract Marriages {
  mapping (address => address) public proposals;
  mapping (address => bytes32) public marriageRecords;
  mapping (bytes32 => Marriage) public marriages;

  struct Marriage {
    bool complete;
    Person[] people;
    uint256 timeStamp;
  }

  struct Person {
    address _address;
    bytes32 firstName;
    bytes32 middleName;
    bytes32 lastName;
    bytes32 dateOfBirth;
    uint id;
  }

  function proposalNew(address me, address myPartner) public returns (bool) {
    require (!_personIsMarried(me) && !_personIsMarried(myPartner));
    proposals[me] = myPartner;
    return true;
  }

  function proposalMatch(address me, address myPartner) public returns (bool) {
    return proposals[myPartner] == me ? true : false;
  }

  function marriageNew(address person1, address person2) public returns (bytes32) {
    require (_canMarry(person1, person2));
    bytes32 marId = keccak256(person1, person2);
    _newMarriageRecord(person1, marId);
    _newMarriageRecord(person2, marId);
    return marId;
  }

  function marriageIsComplete(bytes32 marId) public returns (bool) {
    return marriages[marId].complete;
  }

  function marriageGetPersonAddress(bytes32 marId, uint256 index) public returns (address) {
    return marriages[marId].people[index]._address;
  }

  function marriageRecordsId(address person) public returns (bytes32) {
    return marriageRecords[person];
  }

  function addPerson(bytes32 marId, address _person, bytes32 firstName, bytes32 middleName, bytes32 lastName, bytes32 dateOfBirth, uint id) public returns (bool) {
    marriages[marId].people.push(Person({_address:_person, firstName:firstName, middleName:middleName, lastName:lastName, dateOfBirth:dateOfBirth, id:id}));
    _marriageCompleteIfRequired(marId);
    return true;
  }

  function timeStamp(bytes32 marId) public returns (uint256) {
    return marriages[marId].timeStamp;
  }

  /* Private implementation */

  function _newMarriageRecord(address person, bytes32 marId) private returns (bool) {
    marriageRecords[person] = marId;
    return true;
  }

  function _canMarry(address person1, address person2) private returns (bool) {
    if(_personIsMarried(person1)) { return false; }
    if(_personIsMarried(person2)) { return false; }
    if(!(proposalMatch(person1, person2) && proposalMatch(person2, person1))) { return false; }
    return true;
  }

  function _marriageCompleteIfRequired(bytes32 marId) private returns (bool) {
    if (marriages[marId].people.length == 2) {
      marriages[marId].complete = true;
      _setTimeStamp(marId);
      return true;
    } else {
      return false;
    }
  }

  function _personIsMarried(address person) private returns(bool) {
    return marriageIsComplete(marriageRecordsId(person));
  }

  function _setTimeStamp(bytes32 marId) private returns(uint256) {
    uint256 timeNow = now;
    marriages[marId].timeStamp = timeNow;
    return timeNow;
  }
}
