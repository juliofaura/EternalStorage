pragma solidity ^0.5;

import "../EternalStorageWrapperBase.sol";
import "../interfaces/IEternalStorageAddressArray.sol";

contract EternalStorageAddressArray is IEternalStorageAddressArray, EternalStorageWrapperBase {

    function pushAddressToArray(bytes32 module, bytes32 array, address newValue)
        external
        returns (bool)
    {
        setUint(singleElementKey(module, array), getUint(singleElementKey(module, array)) + 1);
        return _setAddressInArray(module, array, _getNumberOfElementsInArray(module, array) - 1, newValue);
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
        require(element < _getNumberOfElementsInArray(module, array), OUT_OF_BOUNDS);
        _setAddressInArray(module, array, element, _getAddressFromArray(module, array, _getNumberOfElementsInArray(module, array) - 1));
        bytes32 key = indexedElementKey(module, array, _getNumberOfElementsInArray(module, array) - 1);
        return deleteAddress(key);
    }

    // Pricate functions

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