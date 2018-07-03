var StorageGasCheck = artifacts.require("./StorageGasCheck.sol");

module.exports = function(deployer){
    deployer.deploy(StorageGasCheck);
};