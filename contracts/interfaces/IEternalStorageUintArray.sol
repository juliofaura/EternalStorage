pragma solidity ^0.5;

interface IEternalStorageUintArray {

    function pushUintToArray(bytes32 module, bytes32 array, uint256 newValue) external returns (uint256 index);
    function getUintFromArray(bytes32 module, bytes32 array, uint256 element) external view returns (uint);
    function setUintInArray(bytes32 module, bytes32 array, uint256 element, uint256 value) external returns (bool);
    function deleteUintFromArray(bytes32 module, bytes32 array, uint256 element) external returns (bool);

}