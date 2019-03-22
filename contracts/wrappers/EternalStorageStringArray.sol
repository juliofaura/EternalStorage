pragma solidity ^0.5;

import "../EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageStringArray.sol";

contract EternalStorageStringArray is IEternalStorageStringArray, EternalStorageWrapperBase {

    function pushStringToArray(bytes32 module, bytes32 array, string calldata newValue)
        external
        returns (bool)
    {
        setUint(singleElementKey(module, array), getUint(singleElementKey(module, array)) + 1);
        return _setStringInArray(module, array, _getNumberOfElementsInArray(module, array) - 1, newValue);
    }

    function getStringFromArray(bytes32 module, bytes32 array, uint256 element)
        external view
       returns (string memory)
    {
        return _getStringFromArray(module, array, element);
    }

    function setStringInArray(bytes32 module, bytes32 array, uint256 element, string calldata value)
        external
       returns (bool)
    {
        return _setStringInArray(module, array, element, value);
    }

    function deleteStringFromArray(bytes32 module, bytes32 array, uint256 element)
        external
        returns (bool)
    {
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        _setStringInArray(module, array, element, _getStringFromArray(module, array, _getNumberOfElementsInArray(module, array) - 1));
        bytes32 key = indexedElementKey(module, array, _getNumberOfElementsInArray(module, array) - 1);
        return deleteString(key);
    }

    // Private functions

    function _getStringFromArray(bytes32 module, bytes32 array, uint256 element)
        private view
       returns (string memory)
    {
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        bytes32 key = indexedElementKey(module, array, element);
        return getString(key);
    }

    function _setStringInArray(bytes32 module, bytes32 array, uint256 element, string memory value)
        private
       returns (bool)
    {
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        bytes32 key = indexedElementKey(module, array, element);
        return setString(key, value);
    }

}