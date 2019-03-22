pragma solidity ^0.5;

import "../EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageAllStringMappings.sol";

contract EternalStorageAllStringMappings is IEternalStorageAllStringMappings, EternalStorageWrapperBase {

    // Get element:
    function getUintFromMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (uint)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getUint(key);
    }

    function getIntFromMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (int)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getInt(key);
    }

    function getAddressFromMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (address)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getAddress(key);
    }

    function getBytesFromMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (bytes memory)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getBytes(key);
    }

    function getBoolFromMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getBool(key);
    }

    function getStringFromMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external view
        returns (string memory)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getString(key);
    }


    // Set element:
    function setUintInMapping(bytes32 _module, bytes32 _mapping, string calldata _key, uint256 _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setUint(key, _value);
    }

    function setIntInMapping(bytes32 _module, bytes32 _mapping, string calldata _key, int256 _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setInt(key, _value);
    }

    function setAddressInMapping(bytes32 _module, bytes32 _mapping, string calldata _key, address _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setAddress(key, _value);
    }

    function setBytesInMapping(bytes32 _module, bytes32 _mapping, string calldata _key, bytes calldata _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setBytes(key, _value);
    }

    function setBoolInMapping(bytes32 _module, bytes32 _mapping, string calldata _key, bool _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setBool(key, _value);
    }

    function setStringInMapping(bytes32 _module, bytes32 _mapping, string calldata _key, string calldata _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setString(key, _value);
    }


    // Delete element:
    function deleteUintFromMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteUint(key);
    }

    function deleteIntFromMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteInt(key);
    }

    function deleteAddressFromMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteAddress(key);
    }

    function deleteBoolFromMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteBool(key);
    }

    function deleteStringFromMapping(bytes32 _module, bytes32 _mapping, string calldata _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteString(key);
    }

}
