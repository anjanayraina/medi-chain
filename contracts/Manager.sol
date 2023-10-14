// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
contract Manager  is Ownable{

    constructor() Ownable(msg.sender){
        
    }
    mapping(address=>mapping(address=>bool)) approvedAddresses;

    struct Doctor {
        string name;
        address walletAddress;

    }

    struct Diesease {
        string name;
        string []symptoms;
        string [] 


    }
    struct Patient {
        string name;
        address walletAddress;



    }
}