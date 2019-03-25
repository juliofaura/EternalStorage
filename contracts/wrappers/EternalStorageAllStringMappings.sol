pragma solidity ^0.5;

import "./EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageAllStringMappings.sol";

contract EternalStorageAllStringMappings is IEternalStorageAllStringMappings, EternalStorageWrapperBase {

    // Get element:
    function getUintFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (uint)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getUint(key);
    }

    function getIntFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (int)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getInt(key);
    }

    function getAddressFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (address)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getAddress(key);
    }

    function getBytesFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (bytes memory)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getBytes(key);
    }

    function getBoolFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getBool(key);
    }

    function getStringFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (string memory)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getString(key);
    }


    // Set element:
    function setUintInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, uint256 _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setUint(key, _value);
    }

    function setIntInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, int256 _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setInt(key, _value);
    }

    function setAddressInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, address _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setAddress(key, _value);
    }

    function setBytesInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, bytes calldata _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setBytes(key, _value);
    }

    function setBoolInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, bool _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setBool(key, _value);
    }

    function setStringInStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key, string calldata _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setString(key, _value);
    }


    // Delete element:
    function deleteUintFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteUint(key);
    }

    function deleteIntFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteInt(key);
    }

    function deleteAddressFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteAddress(key);
    }

    function deleteBytesFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteBytes(key);
    }

    function deleteBoolFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteBool(key);
    }

    function deleteStringFromStringMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteString(key);
    }

}
