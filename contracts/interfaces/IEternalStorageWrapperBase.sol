pragma solidity ^0.5;

interface IEternalStorageWrapperBase {

    function getNumberOfElementsInArray(bytes32 module, bytes32 array) external view returns (uint256);

    // uint256
    function getUint(bytes32 module, bytes32 variable) external view returns (uint);
    function setUint(bytes32 module, bytes32 variable, uint256 value) external returns(bool);
    function deleteUint(bytes32 module, bytes32 variable) external returns(bool);

    // int256
    function getInt(bytes32 module, bytes32 variable) external view returns (int);
    function setInt(bytes32 module, bytes32 variable, int256 value) external returns(bool);
    function deleteInt(bytes32 module, bytes32 variable) external returns(bool);

    // address
    function getAddress(bytes32 module, bytes32 variable) external view returns (address);
    function setAddress(bytes32 module, bytes32 variable, address value) external returns(bool);
    function deleteAddress(bytes32 module, bytes32 variable) external returns(bool);

    // bytes
    function getBytes(bytes32 module, bytes32 variable) external view returns (bytes memory);
    function setBytes(bytes32 module, bytes32 variable, bytes calldata value) external returns(bool);
    function deleteBytes(bytes32 module, bytes32 variable) external returns(bool);

    // bool
    function getBool(bytes32 module, bytes32 variable) external view returns (bool);
    function setBool(bytes32 module, bytes32 variable, bool value) external returns(bool);
    function deleteBool(bytes32 module, bytes32 variable) external returns(bool);

    // string
    function getString(bytes32 module, bytes32 variable) external view returns (string memory);
    function setString(bytes32 module, bytes32 variable, string calldata value) external returns(bool);
    function deleteString(bytes32 module, bytes32 variable) external returns(bool);

}