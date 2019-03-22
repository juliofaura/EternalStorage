pragma solidity ^0.5;

interface IEternalStorageUintDoubleMapping {

    // Get element:
    function getUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external view returns (uint256);
    function getUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external view returns (uint256);
    function getUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2) external view returns (uint256);

    // Set element:
    function setUintInDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, uint256 _value) external returns (bool);
    function setUintInDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2, uint256 _value) external returns (bool);
    function setUintInDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2, uint256 _value) external returns (bool);

    // Delete element
    function deleteUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external returns (bool);
    function deleteUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external returns (bool);
    function deleteUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2) external returns (bool);

}
