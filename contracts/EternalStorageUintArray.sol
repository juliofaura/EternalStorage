pragma solidity ^0.5;

import "./EternalStorageBase.sol";

contract EternalStorageUintArray is EternalStorageBase {

    modifier isUintArray(bytes32 module, bytes32 variable) {
        require(_declarations[module][variable] == Types.UintArray, "Variable is not declared as uint array");
        _;
    }

    function getNumberOfElementsInArray(bytes32 module, bytes32 array)
        public view
        externalStorageSet
        isUintArray(module, array)
        returns (uint256) {
        bytes32 key = singleElementKey(module, array);
        return _eternalStorage.getUint(key);
    }

    function pushUintToArray(bytes32 module, bytes32 array, uint256 newValue)
        public
        externalStorageSet
        isUintArray(module, array)
        returns (bool)
    {
        setUint(module, array, getUint(module, array) + 1);
        return setUintInArray(module, array, getNumberOfElementsInArray(module, array) - 1, newValue);
    }

    function getUintFromArray(bytes32 module, bytes32 array, uint256 element)
        public view
        externalStorageSet
        isUintArray(module, array)
        returns (uint)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        bytes32 key = indexedElementKey(module, array, element);
        return _eternalStorage.getUint(key);
    }

    function setUintInArray(bytes32 module, bytes32 array, uint256 element, uint256 value)
        public
        externalStorageSet
        isUintArray(module, array)
        returns (bool)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        bytes32 key = indexedElementKey(module, array, element);
        return _eternalStorage.setUint(key, value);
    }

    function deleteUintFromArray(bytes32 module, bytes32 array, uint256 element)
        public
        externalStorageSet
        isUintArray(module, array)
       returns (bool)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        setUintInArray(module, array, element, getUintFromArray(module, array, getNumberOfElementsInArray(module, array) - 1));
        bytes32 key = indexedElementKey(module, array, getNumberOfElementsInArray(module, array) - 1);
        return _eternalStorage.deleteUint(key);
    }

}