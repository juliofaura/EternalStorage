pragma solidity ^0.5;

interface IEternalStorageBoolDoubleMapping {

    // Get element:
    function getBoolFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external view returns (bool);
    function getBoolFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external view returns (bool);

    // Set element:
    function setBoolInDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, bool _value) external returns (bool);
    function setBoolInDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2, bool _value) external returns (bool);

    // Delete element
    function deleteBoolFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external returns (bool);
    function deleteBoolFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external returns (bool);

}
