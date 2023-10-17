// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
contract Manager  is Ownable{

    constructor() Ownable(msg.sender){
        
    }
    mapping(address => Doctor) approvedDoctors;
    mapping (address => Patient) allPatients;
    struct Doctor {
        string name;
        address walletAddress;
        Patient []allPatients;

    }

    struct Diesease {
        string name;
        bool active;

    }
    struct Patient {
        string name;
        uint8 weight;
        string patientAddress;
        uint8 bloodPressureUp;
        uint8 bloodPressureDown;
        uint256 lastUpdated;
        uint24 bloodGlucose;
        address walletAddress;
        Diesease [] allDieseases;

    }

    modifier patientPresent {
        require(allPatients[msg.sender].weight != 0  , "Patient Not Present");
        _; 
    }

    function _isDoctor(address walletAddress) internal view returns (bool){
        return approvedDoctors[walletAddress].walletAddress != address(0);
    }

    function addDoctor(string calldata _name , address _walletAddress) external onlyOwner {
        require(!_isDoctor(_walletAddress), "Doctor Already Present");
        Doctor storage doctor = approvedDoctors[_walletAddress];
        doctor.name = _name;
        doctor.walletAddress = _walletAddress;

    }

    function addPatient(address patientWalletAddress , string calldata _name , uint8 _weight , string calldata _patientAddress ) external {        
        require(_isDoctor(msg.sender) , "Not an Apporved Doctor");
        require(allPatients[patientWalletAddress].weight == 0  , "Patient Already Present");
        Patient storage patient = allPatients[patientWalletAddress];
        patient.name = _name;
        patient.weight = _weight;
        patient.patientAddress = _patientAddress;
    }

    function addPatient( string calldata _name , uint8 _weight , string calldata _patientAddress ) external {        
        require(allPatients[msg.sender].weight == 0  , "Patient Already Present");
        Patient storage patient = allPatients[msg.sender];
        patient.name = _name;
        patient.weight = _weight;
        patient.patientAddress = _patientAddress;
    }
    function updateMinorPatientDetails(uint8 _weight , string calldata _patientAddress , uint8 _bloodPressureUp , uint8 _bloodPressureDown) external patientPresent{
        Patient storage patient = allPatients[msg.sender];
        patient.weight = _weight;
        patient.patientAddress = _patientAddress;
        patient.lastUpdated = block.timestamp;
        patient.bloodPressureUp  = _bloodPressureUp;
        patient.bloodPressureDown = _bloodPressureDown;
    }
    function updatePatientDetails(address _walletAddress , uint8 _weight , string calldata _patientAddress , uint8 _bloodPressureUp , uint8 _bloodPressureDown , uint24 _bloodGlucose) external {
        require(allPatients[msg.sender].weight != 0  , "Patient Not Present");
        require(_isDoctor(msg.sender) , "Caller is not a Doctor");
        Patient storage patient = allPatients[_walletAddress];
        patient.weight = _weight;
        patient.patientAddress = _patientAddress;
        patient.lastUpdated = block.timestamp;
        patient.bloodPressureUp  = _bloodPressureUp;
        patient.bloodPressureDown = _bloodPressureDown;
        patient.bloodGlucose = _bloodGlucose;
    }

    function addDiesease(address patientWalletAddress, string calldata _name) external {
        require(_isDoctor(msg.sender) , "Caller is not a Doctor");
        Patient storage patient = allPatients[patientWalletAddress];
        patient.allDieseases.push(Diesease(_name , true));
    }

    function deletePatient() external {
        delete allPatients[msg.sender];
    }


}