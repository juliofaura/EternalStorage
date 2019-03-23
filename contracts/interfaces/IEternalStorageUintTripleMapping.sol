pragma solidity ^0.5;

interface IEternalStorageUintTripleMapping {

    // Get element:
    function getUintFromTripleBytes32AddressAddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, address _key3) external view returns (uint256);

    // Set element:
    function setUintInTripleBytes32AddressAddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, address _key3, uint256 _value) external returns (bool);

    // Delete element
    function deleteUintFromTripleBytes32AddressAddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, address _key3) external returns (bool);

}
