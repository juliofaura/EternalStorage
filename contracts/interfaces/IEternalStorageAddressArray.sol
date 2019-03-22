pragma solidity ^0.5;

interface IEternalStorageAddressArray {

    function pushAddressToArray(bytes32 module, bytes32 array, address newValue) external returns (bool);
    function getAddressFromArray(bytes32 module, bytes32 array, uint256 element) external view returns (address);
    function setAddressInArray(bytes32 module, bytes32 array, uint256 element, address value) external returns (bool);
    function deleteAddressFromArray(bytes32 module, bytes32 array, uint256 element) external returns (bool);

}