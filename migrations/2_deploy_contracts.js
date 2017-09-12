var Marriage = artifacts.require("./Marriage.sol");

module.exports = function(deployer) {
  deployer.deploy(Marriage);
};
