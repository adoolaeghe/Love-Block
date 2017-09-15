pragma solidity ^0.4.4;

contract Marriages {
  mapping (address => address) public proposals;


  function proposalNew(address me, address myPartner) returns (bool) {
    proposals[me] = myPartner;
    return true;
  }

  function proposalMatch(address me, address myPartner) returns (bool) {
    return proposals[myPartner] == me ? true : false;
  }

  function marriageNew(address person1, address person2) returns (bytes32) {
    return keccak256(person1, person2);
  }









  /*struct Person {
    address _address;
    bytes32 firstName;
    bytes32 middleName;
    bytes32 familyName;
    bytes32 dateOfBirth;
    bytes32 placeOfBirth;
    uint id;
  }*/

  /*Person[] public people;

  function addPerson(bytes32 _firstName, bytes32 _middleName, bytes32 _familyName, bytes32 _dateOfBirth, bytes32 _placeOfBirth, uint _id) public returns (bool) {
    people.length++;
    people[people.length-1]._address = msg.sender;
    people[people.length-1].firstName = _firstName;
    people[people.length-1].middleName = _middleName;
    people[people.length-1].familyName = _familyName;
    people[people.length-1].dateOfBirth = _dateOfBirth;
    people[people.length-1].placeOfBirth = _placeOfBirth;
    people[people.length-1].id = _id;
    return true;
  }

  function getPerson(uint256 _index) public returns (address, bytes32, bytes32, bytes32, bytes32, bytes32, uint) {
    return (people[_index]._address,
            people[_index].firstName,
            people[_index].middleName,
            people[_index].familyName,
            people[_index].dateOfBirth,
            people[_index].placeOfBirth,
            people[_index].id);
  }*/
}
