pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Marriage.sol";

contract TestMarriage {
  Marriage marriage = Marriage(DeployedAddresses.Marriage());
  event myEvent1(address _sender, string _msg);

  function testContractStatusUponCreation() {
    bool expectedStatus = marriage.complete();
    Assert.equal(expectedStatus, false, "Contract is imcomplete upon instantiation");
  }

  function testCallReturnsUserAddress() {
    address returnAddress = marriage.marry();
    address expectedAddress = this;
    myEvent1(msg.sender,"Sender address");
    myEvent1(returnAddress,"Return address");
    Assert.equal(returnAddress, expectedAddress, "Contract returns callers address");
  }

  function testGetFirstUserByAddress() {
    address expected = this;
    address user = marriage.couple(0);
    Assert.equal(user, expected, "a first user can be added to a marriage");
  }

  function testGetSecondUserByAddress() {
    address secondUserAddress = marriage.marry();
    address expected = this;
    address user = marriage.couple(1);
    Assert.equal(user, expected, "a second user can be added to a marriage");
  }

  function testOnlyTwoPersonCanBeMarried() {
    uint size1 = marriage.getCouple().length;
    address thirdUserAddress = marriage.marry();
    uint size2 = marriage.getCouple().length;
    Assert.equal(size1, size2, "Only two users can get married");
  }
}
