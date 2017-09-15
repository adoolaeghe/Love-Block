var Marriage = artifacts.require("./Marriage.sol");
var Marriages = artifacts.require("./Marriages.sol");
var Proposal = artifacts.require("./Proposal.sol");


module.exports = function(deployer) {
  deployer.deploy(Marriage);
  deployer.deploy(Marriages);
  deployer.deploy(Proposal);
};
