pragma solidity ^0.5;

import "../EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageBoolArray.sol";

contract EternalStorageBoolArray is IEternalStorageBoolArray, EternalStorageWrapperBase {

    function pushBoolToArray(bytes32 module, bytes32 array, bool newValue)
        external
        returns (bool)
    {
        setUint(singleElementKey(module, array), getUint(singleElementKey(module, array)) + 1);
        return _setBoolInArray(module, array, _getNumberOfElementsInArray(module, array) - 1, newValue);
    }

    function getBoolFromArray(bytes32 module, bytes32 array, uint256 element)
        external view
        returns (bool)
    {
        return _getBoolFromArray(module, array, element);
    }

    function setBoolInArray(bytes32 module, bytes32 array, uint256 element, bool value)
        external
        returns (bool)
    {
        return _setBoolInArray(module, array, element, value);
    }

    function deleteBoolFromArray(bytes32 module, bytes32 array, uint256 element)
        external
        returns (bool)
    {
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        _setBoolInArray(module, array, element, _getBoolFromArray(module, array, _getNumberOfElementsInArray(module, array) - 1));
        bytes32 key = indexedElementKey(module, array, _getNumberOfElementsInArray(module, array) - 1);
        return deleteBool(key);
    }

    // Private functions

    function _getBoolFromArray(bytes32 module, bytes32 array, uint256 element)
        private view
        returns (bool)
    {
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        bytes32 key = indexedElementKey(module, array, element);
        return getBool(key);
    }

    function _setBoolInArray(bytes32 module, bytes32 array, uint256 element, bool value)
        private
        returns (bool)
    {
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        bytes32 key = indexedElementKey(module, array, element);
        return setBool(key, value);
    }

}