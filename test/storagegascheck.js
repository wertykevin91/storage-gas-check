var StorageGasCheck = artifacts.require("./StorageGasCheck.sol");

contract('StorageGasCheck', function(accounts){
    it("Check transfer functions.", function(){

        var contract;
        var initialBalance = 10000;
        var initialAccount = accounts[0];
        var amountToTransfer = 20;
        var amtChecks = [];

        return StorageGasCheck.deployed().then(function(instance){
            contract = instance;
        }).then(function(){
            return contract.getBalance.call(initialAccount);
        }).then(function(balance){
            var a0Balance = balance.toNumber();
            assert.equal(a0Balance, initialBalance, "Initial balance should be 10,000");
        }).then(function(){
            return contract.transfer(accounts[1], amountToTransfer);
        }).then(function(something){
            //console.log(something);
            return contract.getBalance.call(accounts[0]);
        }).then(function(balance){
            amtChecks.push(balance.toNumber());
            return contract.getBalance.call(accounts[1]);
        }).then(function(balance){
            amtChecks.push(balance.toNumber());
            assert.equal(amtChecks[0], (initialBalance - amountToTransfer), "Amount should be 10000 - 20");
            assert.equal(amtChecks[1], amountToTransfer, "Amount should be 20");
        });
    });
    it("Check storage functions.", function(){

        var stringToStore = "Institutional money is coming. At least that's been the refrain from desperate cryptocurrency traders for the past six months, praying for an influx of new fiat to shore up prices...";
        var secondStringToStore = "kek";
        var bytes32ToStore = "0x012345678901234567890123456789";
        var contract;
        var utils = web3._extend.utils;
        // Check the web3
        //console.log(utils);
        //console.log(web3);

        return StorageGasCheck.deployed().then(function(instance){
            
            contract = instance;
        }).then(function(){
            return contract.readBytes32.call();    
        }).then(function(storedBytes32){
            assert.equal('""', '"' + utils.toUtf8(storedBytes32).trim() + '"', "Empty bytes32");
            return contract.readString.call();
        }).then(function(storedString){
            assert.equal('', utils.toUtf8(storedString), "Empty string");
        }).then(function(){
            return contract.storeBytes32(utils.fromUtf8(bytes32ToStore));
        }).then(function(receipt){
            console.log("Storing bytes32: " + receipt.receipt.gasUsed);
            return contract.readBytes32.call();    
        }).then(function(storedBytes32){
            assert.equal(bytes32ToStore, utils.toUtf8(storedBytes32), bytes32ToStore);
            return contract.storeString(utils.fromUtf8(stringToStore));
        }).then(function(receipt){
            console.log("Storing long string: " + receipt.receipt.gasUsed);
            return contract.readString.call();    
        }).then(function(storedString){
            assert.equal(stringToStore, utils.toUtf8(storedString), stringToStore);
            return contract.storeString(utils.fromUtf8(secondStringToStore));
        }).then(function(receipt){
            console.log("Storing short string: " + receipt.receipt.gasUsed);
            return contract.readString.call();
        }).then(function(storedString){
            assert.equal(secondStringToStore, utils.toUtf8(storedString), secondStringToStore);
        });
    });
});