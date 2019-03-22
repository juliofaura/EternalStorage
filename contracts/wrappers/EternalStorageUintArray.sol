pragma solidity ^0.5;

import "../EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageUintArray.sol";

contract EternalStorageUintArray is IEternalStorageUintArray, EternalStorageWrapperBase {

    function pushUintToArray(bytes32 module, bytes32 array, uint256 newValue)
        external
        returns (bool)
    {
        setUint(singleElementKey(module, array), getUint(singleElementKey(module, array)) + 1);
        return _setUintInArray(module, array, _getNumberOfElementsInArray(module, array) - 1, newValue);
    }

    function getUintFromArray(bytes32 module, bytes32 array, uint256 element)
        external view
        returns (uint)
    {
        return _getUintFromArray(module, array, element);
    }

    function setUintInArray(bytes32 module, bytes32 array, uint256 element, uint256 value)
        external
        returns (bool)
    {
        return _setUintInArray(module, array, element, value);
    }

    function deleteUintFromArray(bytes32 module, bytes32 array, uint256 element)
        external
       returns (bool)
    {
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        _setUintInArray(module, array, element, _getUintFromArray(module, array, _getNumberOfElementsInArray(module, array) - 1));
        bytes32 key = indexedElementKey(module, array, _getNumberOfElementsInArray(module, array) - 1);
        return deleteUint(key);
    }

    // Private functions

    function _getUintFromArray(bytes32 module, bytes32 array, uint256 element)
        private view
        returns (uint)
    {
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        bytes32 key = indexedElementKey(module, array, element);
        return getUint(key);
    }

    function _setUintInArray(bytes32 module, bytes32 array, uint256 element, uint256 value)
        private
        returns (bool)
    {
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        bytes32 key = indexedElementKey(module, array, element);
        return setUint(key, value);
    }

}