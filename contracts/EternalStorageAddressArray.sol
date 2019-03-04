pragma solidity ^0.5;

import "./EternalStorageBase.sol";

contract EternalStorageAddressArray is EternalStorageBase {

    modifier isAddressArray(bytes32 module, bytes32 variable) {
        require(_declarations[module][variable] == Types.AddressArray, "Variable is not declared as address array");
        _;
    }

    function getNumberOfElementsInArray(bytes32 module, bytes32 array)
        public view
        externalStorageSet
        isAddressArray(module, array)
        returns (uint256) {
        bytes32 key = singleElementKey(module, array);
        return _eternalStorage.getUint(key);
    }

    function pushAddressToArray(bytes32 module, bytes32 array, address newValue)
        public
        externalStorageSet
        isAddressArray(module, array)
        returns (bool)
    {
        setUint(module, array, getUint(module, array) + 1);
        return setAddressInArray(module, array, getNumberOfElementsInArray(module, array) - 1, newValue);
    }

    function getAddressFromArray(bytes32 module, bytes32 array, uint256 element)
        public view
        externalStorageSet
        isAddressArray(module, array)
        returns (address)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        bytes32 key = indexedElementKey(module, array, element);
        return _eternalStorage.getAddress(key);
    }

    function setAddressInArray(bytes32 module, bytes32 array, uint256 element, address value)
        public
        externalStorageSet
        isAddressArray(module, array)
        returns (bool)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        bytes32 key = indexedElementKey(module, array, element);
        return _eternalStorage.setAddress(key, value);
    }

    function deleteAddressFromArray(bytes32 module, bytes32 array, uint256 element)
        public
        externalStorageSet
        isAddressArray(module, array)
        returns (bool)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        setAddressInArray(module, array, element, getAddressFromArray(module, array, getNumberOfElementsInArray(module, array) - 1));
        bytes32 key = indexedElementKey(module, array, getNumberOfElementsInArray(module, array) - 1);
        return _eternalStorage.deleteAddress(key);
    }

}