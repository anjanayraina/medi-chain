pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../contracts/Manager.sol";

contract ManagerTest is Test {
    Manager manager;

    function setUp() public {
        manager = new Manager();
    }

    function test_ownerSet() public {
        require(msg.sender == manager.getOwner());
    }
}
