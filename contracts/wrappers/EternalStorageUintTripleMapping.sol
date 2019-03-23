pragma solidity ^0.5;

import "../EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageUintTripleMapping.sol";

contract EternalStorageUintTripleMapping is IEternalStorageUintTripleMapping, EternalStorageWrapperBase {

    // Get element:
    function getUintFromTripleBytes32AddressAddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, address _key3)
        external view
        returns (uint256)
    {
        bytes32 key = tripleIndexedElementKey(_module, _mapping, _key1, _key2, _key3);
        return getUint(key);
    }

    // Set element:

    function setUintInTripleBytes32AddressAddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, address _key3, uint256 _value)
        external
        returns (bool)
    {
        bytes32 key = tripleIndexedElementKey(_module, _mapping, _key1, _key2, _key3);
        return setUint(key, _value);
    }

    // Delete element

    function deleteUintFromTripleBytes32AddressAddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, address _key3)
        external
        returns (bool)
    {
        bytes32 key = tripleIndexedElementKey(_module, _mapping, _key1, _key2, _key3);
        return deleteUint(key);
    }

}
