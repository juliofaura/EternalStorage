pragma solidity ^0.5;

import "./EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageAddressDoubleMapping.sol";

contract EternalStorageAddressDoubleMapping is IEternalStorageAddressDoubleMapping, EternalStorageWrapperBase {

    // Get element:
    function getAddressFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2)
        external view
        returns (address)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return getAddress(key);
    }

    function getAddressFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2)
        external view
        returns (address)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return getAddress(key);
    }

    function getAddressFromDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2)
        external view
        returns (address)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return getAddress(key);
    }

    // Set element:

    function setAddressInDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, address _value)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return setAddress(key, _value);
    }

    function setAddressInDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2, address _value)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return setAddress(key, _value);
    }

    function setAddressInDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2, address _value)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return setAddress(key, _value);
    }

    // Delete element

    function deleteAddressFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return deleteAddress(key);
    }

    function deleteAddressFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return deleteAddress(key);
    }

    function deleteAddressFromDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2)
        external
        returns (bool)
    {
        bytes32 key = doubleIndexedElementKey(_module, _mapping, _key1, _key2);
        return deleteAddress(key);
    }

}
