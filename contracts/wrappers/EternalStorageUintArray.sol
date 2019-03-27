pragma solidity ^0.5;

import "./EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageUintArray.sol";
import "../libraries/SafeMath.sol";

contract EternalStorageUintArray is IEternalStorageUintArray, EternalStorageWrapperBase {

    using SafeMath for uint256;

    function pushUintToArray(bytes32 module, bytes32 array, uint256 newValue)
        external
        returns (uint256 index)
    {
        index = getUint(singleElementKey(module, array));
        setUint(singleElementKey(module, array), index.add(1));
        _setUintInArray(module, array, index, newValue);
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
        uint256 manyElements = _getNumberOfElementsInArray(module, array);
        require(element < manyElements, OUT_OF_BOUNDS);
        _setUintInArray(module, array, element, _getUintFromArray(module, array, manyElements.sub(1)));
        bytes32 keyToDelete = indexedElementKey(module, array, manyElements.sub(1));
        setUint(singleElementKey(module, array), manyElements.sub(1));
        return deleteUint(keyToDelete);
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