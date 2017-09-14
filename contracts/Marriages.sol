pragma solidity ^0.4.4;

contract Marriages {

  struct Person {
    address _address;
    bytes32 firstName;
    bytes32 middleName;
    bytes32 familyName;
    bytes32 dateOfBirth;
    bytes32 placeOfBirth;
    uint id;
  }

  Person[] public people;

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

}
