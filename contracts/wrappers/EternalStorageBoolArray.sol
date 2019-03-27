pragma solidity ^0.5;

import "./EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageBoolArray.sol";
import "../libraries/SafeMath.sol";

contract EternalStorageBoolArray is IEternalStorageBoolArray, EternalStorageWrapperBase {

    using SafeMath for uint256;

    function pushBoolToArray(bytes32 module, bytes32 array, bool newValue)
        external
        returns (uint256 index)
    {
        index = getUint(singleElementKey(module, array));
        setUint(singleElementKey(module, array), index.add(1));
        _setBoolInArray(module, array, index, newValue);
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
        uint256 manyElements = _getNumberOfElementsInArray(module, array);
        require(element < manyElements, OUT_OF_BOUNDS);
        _setBoolInArray(module, array, element, _getBoolFromArray(module, array, manyElements.sub(1)));
        bytes32 keyToDelete = indexedElementKey(module, array, manyElements.sub(1));
        setUint(singleElementKey(module, array), manyElements.sub(1));
        return deleteBool(keyToDelete);
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
