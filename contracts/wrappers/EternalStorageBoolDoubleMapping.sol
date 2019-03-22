pragma solidity ^0.5;

import "../EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageBoolDoubleMapping.sol";

contract EternalStorageBoolDoubleMapping is IEternalStorageBoolDoubleMapping, EternalStorageWrapperBase {

    // Get element:
    function getBoolFromDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2)
        external view
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return getBool(key);
    }

    function getBoolFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2)
        external view
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return getBool(key);
    }

    // Set element:

    function setBoolInDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, bool _value)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return setBool(key, _value);
    }

    function setBoolInDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2, bool _value)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return setBool(key, _value);
    }

    // Delete element

    function deleteBoolFromDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return deleteBool(key);
    }

    function deleteBoolFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return deleteBool(key);
    }

}
