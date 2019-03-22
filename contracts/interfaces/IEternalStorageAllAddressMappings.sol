pragma solidity ^0.5;

interface IEternalStorageAllAddressMappings {

    // Get element:
    function getUintFromMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (uint);
    function getIntFromMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (int);
    function getAddressFromMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (address);
    function getBytesFromMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (bytes memory);
    function getBoolFromMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (bool);
    function getStringFromMapping(bytes32 _module, bytes32 _mapping, address _key) external view returns (string memory);

    // Set element:
    function setUintInMapping(bytes32 _module, bytes32 _mapping, address _key, uint256 _value) external returns (bool);
    function setIntInMapping(bytes32 _module, bytes32 _mapping, address _key, int256 _value) external returns (bool);
    function setAddressInMapping(bytes32 _module, bytes32 _mapping, address _key, address _value) external returns (bool);
    function setBytesInMapping(bytes32 _module, bytes32 _mapping, address _key, bytes calldata _value) external returns (bool);
    function setBoolInMapping(bytes32 _module, bytes32 _mapping, address _key, bool _value) external returns (bool);
    function setStringInMapping(bytes32 _module, bytes32 _mapping, address _key, string calldata _value) external returns (bool);

    // Delete element:
    function deleteUintFromMapping(bytes32 _module, bytes32 _mapping, address _key) external returns (bool);
    function deleteIntFromMapping(bytes32 _module, bytes32 _mapping, address _key) external returns (bool);
    function deleteAddressFromMapping(bytes32 _module, bytes32 _mapping, address _key) external returns (bool);
    function deleteBoolFromMapping(bytes32 _module, bytes32 _mapping, address _key) external returns (bool);
    function deleteStringFromMapping(bytes32 _module, bytes32 _mapping, address _key) external returns (bool);

}
