pragma solidity ^0.5;

interface IEternalStorageBase {

    function isContractConnected(address whichContract) external view returns (bool);
    function approveToConnect(address who) external returns (bool); // only owner
    function revokeApprovalToConnect(address who) external returns (bool); // only owner
    function isApprovedToConnect(address who) external view returns (bool);
    function connectContract() external returns (bool); //only approvedToConnect
    function disconnectContract() external returns (bool); // only connected contract
    function connectContractByOwner(address whichContract) external returns (bool); // only owner
    function disconnectContractByOwner(address whichContract) external returns (bool); // only owner

}