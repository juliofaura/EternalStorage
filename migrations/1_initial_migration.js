const Migrations = artifacts.require("Migrations");
const EternalStorage = artifacts.require("EternalStorage");
const Example = artifacts.require("Example");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Migrations);
  deployer.deploy(EternalStorage, {from:accounts[2], gas:10000000, gasPrice:0});
  deployer.deploy(Example, "Test Example", "EMT-EUR", "EUR", 2, "0x0000000000000000000000000000000000000000", {from:accounts[5], gas: 50000000, gasPrice:0})
//  deployer.deploy(Example, "Test Example", "EMT-EUR", "EUR", 2, "0xA43D3F112Dbf3d815a46627CcdDb7224CB91876D", {from:accounts[2], gas: 50000000, gasPrice:0})
//  deployer.deploy(Example, "Test Example", "EMT-EUR", "GBP", 2, "0x0a537980eF1A65632CA867b2D17c2F311ca1FDa7", {from:accounts[2], gas: 50000000, gasPrice:0})
;};
