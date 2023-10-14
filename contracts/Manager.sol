// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.5;
contract Manager {
    mapping(address=>mapping(address=>bool)) approvedAddresses;

    struct Doctor {
        string name;
        address walletAddress;
        

    }
    struct Patient {
        string name;
        address walletAddress;

    }
}