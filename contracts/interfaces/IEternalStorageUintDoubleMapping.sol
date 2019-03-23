pragma solidity ^0.5;

interface IEternalStorageUintDoubleMapping {

    // Get element:
    function getUintFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external view returns (uint256);
    function getUintFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external view returns (uint256);
    function getUintFromDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2) external view returns (uint256);

    // Set element:
    function setUintInDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, uint256 _value) external returns (bool);
    function setUintInDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2, uint256 _value) external returns (bool);
    function setUintInDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2, uint256 _value) external returns (bool);

    // Delete element
    function deleteUintFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external returns (bool);
    function deleteUintFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external returns (bool);
    function deleteUintFromDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2) external returns (bool);

}
