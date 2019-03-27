pragma solidity ^0.5;

import "./EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageAddressArray.sol";
import "../libraries/SafeMath.sol";

contract EternalStorageAddressArray is IEternalStorageAddressArray, EternalStorageWrapperBase {

    using SafeMath for uint256;

    function pushAddressToArray(bytes32 module, bytes32 array, address newValue)
        external
        returns (uint256 index)
    {
        index = _getNumberOfElementsInArray(module, array);
        _setNumberOfElementsInArray(module, array, index + 1);
        _setAddressInArray(module, array, index, newValue);
    }

    function getAddressFromArray(bytes32 module, bytes32 array, uint256 element)
        external view
        returns (address)
    {
        return _getAddressFromArray(module, array, element);
    }

    function setAddressInArray(bytes32 module, bytes32 array, uint256 element, address value)
        external
        returns (bool)
    {
        return _setAddressInArray(module, array, element, value);
    }

    function deleteAddressFromArray(bytes32 module, bytes32 array, uint256 element)
        external
       returns (bool)
    {
        uint256 manyElements = _getNumberOfElementsInArray(module, array);
        require(element < manyElements, OUT_OF_BOUNDS);
        _setAddressInArray(module, array, element, _getAddressFromArray(module, array, manyElements.sub(1)));
        bytes32 keyToDelete = indexedElementKey(module, array, manyElements.sub(1));
        setUint(singleElementKey(module, array), manyElements.sub(1));
        return deleteAddress(keyToDelete);
    }

    // Private functions

    function _getAddressFromArray(bytes32 module, bytes32 array, uint256 element)
        private view
        returns (address)
    {
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        bytes32 key = indexedElementKey(module, array, element);
        return getAddress(key);
    }

    function _setAddressInArray(bytes32 module, bytes32 array, uint256 element, address value)
        private
        returns (bool)
    {
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        bytes32 key = indexedElementKey(module, array, element);
        return setAddress(key, value);
    }

}