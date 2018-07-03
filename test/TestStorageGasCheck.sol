pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/StorageGasCheck.sol";

contract TestStorageGasCheck {

    //string constant stringToStore = "0x123456789012345678901234567890 is a cowardly string";

    // function testMovingCoinsWithDeployedAddress() public {
    //     StorageGasCheck sgc = StorageGasCheck(DeployedAddresses.StorageGasCheck());
        
    //     uint256 balance = sgc.getBalance(msg.sender);
    //     //assert(balance > 0);
    //     //Assert.isAtMost(balance, 10000, "Should be at most 10k");
    //     uint256 transferAmount = 1;
    //     sgc.transfer(address(this), transferAmount);
    //     Assert.equal(sgc.getBalance(msg.sender), balance - transferAmount, "Should be 1 less than original.");
    // }

    // Section New

    function testMovingCoinsWithNewStorageGasCheck() public {
        StorageGasCheck sgc = new StorageGasCheck();
        
        uint256 balance = sgc.getBalance(address(this));
        uint256 noobBalance = sgc.getBalance(msg.sender);
        uint256 transferAmount = 1;
        sgc.transfer(msg.sender, transferAmount);
        Assert.equal(sgc.getBalance(address(this)), balance - transferAmount, "Should be 1 less than original.");
        Assert.equal(sgc.getBalance(msg.sender), noobBalance + transferAmount, "Should be 1 more than original.");
    }

    function testStringStorageWithNewStorageGasCheck() public {
        StorageGasCheck sgc = new StorageGasCheck();

        string memory stringToStore = "0x123456789012345678901234567890 is a cowardly string";

        sgc.storeString(stringToStore);

        Assert.equal(sgc.readString(), stringToStore, "Should be 0x123456789012345678901234567890 is a cowardly string");
    }

    function testInitialBalanceWithNewStorageGasCheck() public {
        StorageGasCheck sgc = new StorageGasCheck();

        uint expected = 10000;
        
        Assert.equal(sgc.getBalance(this), expected, "Should be 10,000");
    }

    function testBytes32StorageWithNewStorageGasCheck() public {
        StorageGasCheck sgc = new StorageGasCheck();

        bytes32 bytes32ToStore = "0x123456789012345678901234567890";

        sgc.storeBytes32(bytes32ToStore);

        Assert.equal(sgc.readBytes32(), bytes32ToStore, "Should be 0x123456789012345678901234567890");
    }
}