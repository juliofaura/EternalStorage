pragma solidity ^0.5;

import "./EternalStorageBase.sol";

contract EternalStorageStringArray is EternalStorageBase {

    modifier isStringArray(bytes32 module, bytes32 variable) {
        require(_declarations[module][variable] == Types.StringArray, "Variable is not declared as string array");
        _;
    }

    function getNumberOfElementsInArray(bytes32 module, bytes32 array)
        public view
        externalStorageSet
        isStringArray(module, array)
        returns (uint256) {
        bytes32 key = singleElementKey(module, array);
        return _eternalStorage.getUint(key);
    }

    function pushStringToArray(bytes32 module, bytes32 array, string memory newValue)
        public
        externalStorageSet
        isStringArray(module, array)
        returns (bool)
    {
        setUint(module, array, getUint(module, array) + 1);
        return setStringInArray(module, array, getNumberOfElementsInArray(module, array) - 1, newValue);
    }

    function getStringFromArray(bytes32 module, bytes32 array, uint256 element)
        public view
        externalStorageSet
        isStringArray(module, array)
       returns (string memory)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        bytes32 key = indexedElementKey(module, array, element);
        return _eternalStorage.getString(key);
    }

    function setStringInArray(bytes32 module, bytes32 array, uint256 element, string memory value)
        public
        externalStorageSet
        isStringArray(module, array)
       returns (bool)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        bytes32 key = indexedElementKey(module, array, element);
        return _eternalStorage.setString(key, value);
    }

    function deleteStringFromArray(bytes32 module, bytes32 array, uint256 element)
        public
        externalStorageSet
        isStringArray(module, array)
        returns (bool)
    {
        require(element < getNumberOfElementsInArray(module, array), "Array out of bounds");
        setStringInArray(module, array, element, getStringFromArray(module, array, getNumberOfElementsInArray(module, array) - 1));
        bytes32 key = indexedElementKey(module, array, getNumberOfElementsInArray(module, array) - 1);
        return _eternalStorage.deleteString(key);
    }

}