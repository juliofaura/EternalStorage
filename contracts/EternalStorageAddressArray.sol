pragma solidity ^0.5;

import "./EternalStorageBase.sol";

contract EternalStorageAddressArray is EternalStorageBase {

    function pushAddressToArray(bytes32 module, bytes32 array, address newValue)
        public
        externalStorageSet
        returns (bool)
    {
        setUint(module, array, getUint(module, array) + 1);
        return setAddressInArray(module, array, getNumberOfElementsInArray(module, array) - 1, newValue);
    }

    function getAddressFromArray(bytes32 module, bytes32 array, uint256 element)
        public view
        externalStorageSet
        returns (address)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        bytes32 key = indexedElementKey(module, array, element);
        return _eternalStorage.getAddress(key);
    }

    function setAddressInArray(bytes32 module, bytes32 array, uint256 element, address value)
        public
        externalStorageSet
        returns (bool)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        bytes32 key = indexedElementKey(module, array, element);
        return _eternalStorage.setAddress(key, value);
    }

    function deleteAddressFromArray(bytes32 module, bytes32 array, uint256 element)
        public
        externalStorageSet
        returns (bool)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        setAddressInArray(module, array, element, getAddressFromArray(module, array, getNumberOfElementsInArray(module, array) - 1));
        bytes32 key = indexedElementKey(module, array, getNumberOfElementsInArray(module, array) - 1);
        return _eternalStorage.deleteAddress(key);
    }

}