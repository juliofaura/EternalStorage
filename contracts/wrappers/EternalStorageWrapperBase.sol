pragma solidity ^0.5;

import "../Ownable.sol";
import "../EternalStorageBase.sol";
import "../interfaces/IEternalStorageWrapperBase.sol";

contract EternalStorageWrapperBase is IEternalStorageWrapperBase, EternalStorageBase {

    string constant OUT_OF_BOUNDS = "Array out of bounds";

    function getNumberOfElementsInArray(bytes32 module, bytes32 array)
        external view
        returns (uint256) {
        return _getNumberOfElementsInArray(module, array);
    }

    // Indexing keys
    function singleElementKey(bytes32 module, bytes32 variableName) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, variableName));
    }

    function indexedElementKey(bytes32 module, bytes32 variableName, uint256 index) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, variableName, "uint", index));
    }

    function indexedElementKey(bytes32 module, bytes32 variableName, address _key) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, variableName, "address", _key));
    }

    function indexedElementKey(bytes32 module, bytes32 variableName, string memory _key) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, variableName, "string", _key));
    }

    function doubleIndexedElementKey(bytes32 module, bytes32 variableName, bytes32 _key1, address _key2) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, variableName, "bytes32", _key1, "address", _key2));
    }

    function doubleIndexedElementKey(bytes32 module, bytes32 variableName, string memory _key1, address _key2) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, variableName, "string", _key1, "address", _key2));
    }

    function doubleIndexedElementKey(bytes32 module, bytes32 variableName, address _key1, address _key2) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, variableName, "address", _key1, "address", _key2));
    }

    function doubleIndexedElementKey(bytes32 module, bytes32 variableName, address _key1, string memory _key2) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, variableName, "address", _key1, "string", _key2));
    }

    function tripleIndexedElementKey(bytes32 module, bytes32 variableName, address _key1, bytes32 _key2, uint256 _key3)
        internal pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(module, variableName, "address", _key1, "bytes32", _key2, "uint", _key3));
    }

    function tripleIndexedElementKey(bytes32 module, bytes32 variableName, bytes32 _key1, address _key2, address _key3)
        internal pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(module, variableName, "bytes32", _key1, "address", _key2, "address", _key3));
    }

    // Array helper
    function _getNumberOfElementsInArray(bytes32 module, bytes32 array)
        internal view
        returns (uint256) {
        bytes32 key = singleElementKey(module, array);
        return getUint(key);
    }

    function _setNumberOfElementsInArray(bytes32 module, bytes32 array, uint256 many)
        internal
        returns (bool) {
        bytes32 key = singleElementKey(module, array);
        return setUint(key, many);
    }

    // uint256

    function getUint(bytes32 module, bytes32 variable)
        external view
        returns (uint)
    {
        bytes32 key = singleElementKey(module, variable);
        return getUint(key);
    }

    function setUint(bytes32 module, bytes32 variable, uint256 value)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return setUint(key, value);
    }

    function deleteUint(bytes32 module, bytes32 variable)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return deleteUint(key);
    }

    // int256

    function getInt(bytes32 module, bytes32 variable)
        external view
        returns (int)
    {
        bytes32 key = singleElementKey(module, variable);
        return getInt(key);
    }

    function setInt(bytes32 module, bytes32 variable, int256 value)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return setInt(key, value);
    }

    function deleteInt(bytes32 module, bytes32 variable)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return deleteInt(key);
    }

    // address

    function getAddress(bytes32 module, bytes32 variable)
        external view
        returns (address)
    {
        bytes32 key = singleElementKey(module, variable);
        return getAddress(key);
    }

    function setAddress(bytes32 module, bytes32 variable, address value)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return setAddress(key, value);
    }

    function deleteAddress(bytes32 module, bytes32 variable)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return deleteAddress(key);
    }

    // bytes

    function getBytes(bytes32 module, bytes32 variable)
        external view
        returns (bytes memory)
    {
        bytes32 key = singleElementKey(module, variable);
        return getBytes(key);
    }

    function setBytes(bytes32 module, bytes32 variable, bytes calldata value)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return setBytes(key, value);
    }

    function deleteBytes(bytes32 module, bytes32 variable)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return deleteBytes(key);
    }

    // bool

    function getBool(bytes32 module, bytes32 variable)
        external view
        returns (bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return getBool(key);
    }

    function setBool(bytes32 module, bytes32 variable, bool value)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return setBool(key, value);
    }

    function deleteBool(bytes32 module, bytes32 variable)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return deleteBool(key);
    }

    // string

    function getString(bytes32 module, bytes32 variable)
        external view
        returns (string memory)
    {
        bytes32 key = singleElementKey(module, variable);
        return getString(key);
    }

    function setString(bytes32 module, bytes32 variable, string calldata value)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return setString(key, value);
    }

    function deleteString(bytes32 module, bytes32 variable)
        external
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return deleteString(key);
    }

}