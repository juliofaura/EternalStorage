pragma solidity ^0.5;

import "../EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageUintDoubleMapping.sol";

contract EternalStorageUintDoubleMapping is IEternalStorageUintDoubleMapping, EternalStorageWrapperBase {

    // Get element:
    function getUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2)
        external view
        returns (uint256)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return getUint(key);
    }

    function getUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2)
        external view
        returns (uint256)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return getUint(key);
    }

    function getUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2)
        external view
        returns (uint256)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return getUint(key);
    }

    // Set element:

    function setUintInDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, uint256 _value)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return setUint(key, _value);
    }

    function setUintInDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2, uint256 _value)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return setUint(key, _value);
    }

    function setUintInDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2, uint256 _value)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return setUint(key, _value);
    }

    // Delete element

    function deleteUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return deleteUint(key);
    }

    function deleteUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return deleteUint(key);
    }

    function deleteUintFromDoubleMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return deleteUint(key);
    }

}
