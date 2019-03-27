pragma solidity ^0.5;

interface IEternalStorageBoolArray {

    function pushBoolToArray(bytes32 module, bytes32 array, bool newValue) external returns (uint256 index);
    function getBoolFromArray(bytes32 module, bytes32 array, uint256 element) external view returns (bool);
    function setBoolInArray(bytes32 module, bytes32 array, uint256 element, bool value) external returns (bool);
    function deleteBoolFromArray(bytes32 module, bytes32 array, uint256 element) external returns (bool);

}