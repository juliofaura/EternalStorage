pragma solidity ^0.5;

interface IEternalStorageAddressDoubleMapping {

    // Get element:
    function getAddressFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external view returns (address);
    function getAddressFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external view returns (address);
    function getAddressFromDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2) external view returns (address);

    // Set element:
    function setAddressInDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, address _value) external returns (bool);
    function setAddressInDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2, address _value) external returns (bool);
    function setAddressInDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2, address _value) external returns (bool);

    // Delete element
    function deleteAddressFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external returns (bool);
    function deleteAddressFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external returns (bool);
    function deleteAddressFromDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2) external returns (bool);

}
