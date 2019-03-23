pragma solidity ^0.5;

interface IEternalStorageAllStringMappings {

    // Get element:
    function getUintFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key) external view returns (uint);
    function getIntFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key) external view returns (int);
    function getAddressFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key) external view returns (address);
    function getBytesFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key) external view returns (bytes memory);
    function getBoolFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key) external view returns (bool);
    function getStringFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key) external view returns (string memory);

    // Set element:
    function setUintInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, uint256 _value) external returns (bool);
    function setIntInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, int256 _value) external returns (bool);
    function setAddressInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, address _value) external returns (bool);
    function setBytesInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, bytes calldata _value) external returns (bool);
    function setBoolInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, bool _value) external returns (bool);
    function setStringInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, string calldata _value) external returns (bool);

    // Delete element:
    function deleteUintFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key) external returns (bool);
    function deleteIntFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key) external returns (bool);
    function deleteAddressFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key) external returns (bool);
    function deleteBoolFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key) external returns (bool);
    function deleteStringFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key) external returns (bool);

}
