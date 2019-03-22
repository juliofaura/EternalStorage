pragma solidity ^0.5;

interface IEternalStorageBoolDoubleMapping {

    // Get element:
    function getBoolFromDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external view returns (bool);
    function getBoolFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external view returns (bool);

    // Set element:
    function setBoolInDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, bool _value) external returns (bool);
    function setBoolInDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2, bool _value) external returns (bool);

    // Delete element
    function deleteBoolFromDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external returns (bool);
    function deleteBoolFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external returns (bool);

}
