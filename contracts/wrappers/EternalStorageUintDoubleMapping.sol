pragma solidity ^0.5;

import "../EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageUintDoubleMapping.sol";

contract EternalStorageUintDoubleMapping is IEternalStorageUintDoubleMapping, EternalStorageWrapperBase {

    // Get element:
    function getUintFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2)
        external view
        returns (uint256)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return getUint(key);
    }

    function getUintFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2)
        external view
        returns (uint256)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return getUint(key);
    }

    function getUintFromDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2)
        external view
        returns (uint256)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return getUint(key);
    }

    // Set element:

    function setUintInDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, uint256 _value)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return setUint(key, _value);
    }

    function setUintInDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2, uint256 _value)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return setUint(key, _value);
    }

    function setUintInDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2, uint256 _value)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return setUint(key, _value);
    }

    // Delete element

    function deleteUintFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return deleteUint(key);
    }

    function deleteUintFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return deleteUint(key);
    }

    function deleteUintFromDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return deleteUint(key);
    }

}
