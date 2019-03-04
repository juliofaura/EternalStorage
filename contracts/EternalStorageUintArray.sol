pragma solidity ^0.5;

import "./EternalStorageBase.sol";

contract EternalStorageUintArray is EternalStorageBase {

    function pushUintToArray(bytes32 module, bytes32 array, uint256 newValue)
        public
        externalStorageSet
        returns (bool)
    {
        setUint(module, array, getUint(module, array) + 1);
        return setUintInArray(module, array, getNumberOfElementsInArray(module, array) - 1, newValue);
    }

    function getUintFromArray(bytes32 module, bytes32 array, uint256 element)
        public view
        externalStorageSet
        returns (uint)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        bytes32 key = indexedElementKey(module, array, element);
        return _eternalStorage.getUint(key);
    }

    function setUintInArray(bytes32 module, bytes32 array, uint256 element, uint256 value)
        public
        externalStorageSet
        returns (bool)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        bytes32 key = indexedElementKey(module, array, element);
        return _eternalStorage.setUint(key, value);
    }

    function deleteUintFromArray(bytes32 module, bytes32 array, uint256 element)
        public
        externalStorageSet
       returns (bool)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        setUintInArray(module, array, element, getUintFromArray(module, array, getNumberOfElementsInArray(module, array) - 1));
        bytes32 key = indexedElementKey(module, array, getNumberOfElementsInArray(module, array) - 1);
        return _eternalStorage.deleteUint(key);
    }

}