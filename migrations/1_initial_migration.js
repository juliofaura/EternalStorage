const Migrations = artifacts.require("Migrations");
const EternalStorage = artifacts.require("EternalStorage");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Migrations);
  deployer.deploy(EternalStorage, {from:accounts[0], gas:10000000, gasPrice:0});
};
