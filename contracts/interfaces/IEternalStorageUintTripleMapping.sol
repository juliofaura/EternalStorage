pragma solidity ^0.5;

interface IEternalStorageUintTripleMapping {

    // Get element:
    function getUintFromTripleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, address _key3) external view returns (uint256);

    // Set element:
    function setUintInTripleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, address _key3, uint256 _value) external returns (bool);

    // Delete element
    function deleteUintFromTripleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, address _key3) external returns (bool);

}
