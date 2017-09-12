pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Marriage.sol";

contract TestMarriage {
  Marriage marriage = Marriage(DeployedAddresses.Marriage());
  event myEvent1(address _sender, string _msg);

  function testCallReturnsUserAddress() {
    address returnAddress = marriage.marry();
    address expectedAddress = this;
    myEvent1(msg.sender,"Sender address");
    myEvent1(returnAddress,"Return address");
    Assert.equal(returnAddress, expectedAddress, "Contract returns callers address");
  }
}
