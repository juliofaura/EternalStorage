pragma solidity ^0.5;

import "../EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageAllAddressMappings.sol";

contract EternalStorageAllAddressMappings is IEternalStorageAllAddressMappings, EternalStorageWrapperBase {

    // Get element:
    function getUintFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external view
        returns (uint)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getUint(key);
    }

    function getIntFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external view
        returns (int)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getInt(key);
    }

    function getAddressFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external view
        returns (address)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getAddress(key);
    }

    function getBytesFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external view
        returns (bytes memory)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getBytes(key);
    }

    function getBoolFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external view
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getBool(key);
    }

    function getStringFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external view
        returns (string memory)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return getString(key);
    }


    // Set element:
    function setUintInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, uint256 _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setUint(key, _value);
    }

    function setIntInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, int256 _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setInt(key, _value);
    }

    function setAddressInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, address _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setAddress(key, _value);
    }

    function setBytesInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, bytes calldata _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setBytes(key, _value);
    }

    function setBoolInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, bool _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setBool(key, _value);
    }

    function setStringInAddressMapping(bytes32 _module, bytes32 _mapping, address _key, string calldata _value)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return setString(key, _value);
    }


    // Delete element:
    function deleteUintFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteUint(key);
    }

    function deleteIntFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteInt(key);
    }

    function deleteAddressFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteAddress(key);
    }

    function deleteBytesFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteBytes(key);
    }

    function deleteBoolFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteBool(key);
    }

    function deleteStringFromAddressMapping(bytes32 _module, bytes32 _mapping, address _key)
        external
        returns (bool)
    {
        bytes32 key = indexedElementKey(_module, _mapping, _key);
        return deleteString(key);
    }

}
