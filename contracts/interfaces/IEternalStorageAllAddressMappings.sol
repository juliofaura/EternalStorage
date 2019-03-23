pragma solidity ^0.5;

interface IEternalStorageAllAddressMappings {

    // Get element:
    function getUintFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (uint);
    function getIntFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (int);
    function getAddressFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (address);
    function getBytesFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (bytes memory);
    function getBoolFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (bool);
    function getStringFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (string memory);

    // Set element:
    function setUintInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, uint256 _value) external returns (bool);
    function setIntInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, int256 _value) external returns (bool);
    function setAddressInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, address _value) external returns (bool);
    function setBytesInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, bytes calldata _value) external returns (bool);
    function setBoolInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, bool _value) external returns (bool);
    function setStringInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, string calldata _value) external returns (bool);

    // Delete element:
    function deleteUintFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key) external returns (bool);
    function deleteIntFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key) external returns (bool);
    function deleteAddressFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key) external returns (bool);
    function deleteBoolFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key) external returns (bool);
    function deleteStringFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key) external returns (bool);

}
