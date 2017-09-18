// var Marriage = artifacts.require("./Marriage.sol");
var Marriages = artifacts.require("./Marriages.sol");


module.exports = function(deployer) {
  // deployer.deploy(Marriage);
  deployer.deploy(Marriages);
};
