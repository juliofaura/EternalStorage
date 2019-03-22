pragma solidity ^0.5;

interface IEternalStorageStringArray {

    function pushStringToArray(bytes32 module, bytes32 array, string calldata newValue) external returns (bool);
    function getStringFromArray(bytes32 module, bytes32 array, uint256 element) external view returns (string memory);
    function setStringInArray(bytes32 module, bytes32 array, uint256 element, string calldata value) external returns (bool);
    function deleteStringFromArray(bytes32 module, bytes32 array, uint256 element) external returns (bool);

}