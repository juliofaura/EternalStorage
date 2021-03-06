pragma solidity ^0.5;

interface IEternalStorageStringDoubleMapping {

    // Get element:
    function getStringFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external view returns (string memory);
    function getStringFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external view returns (string memory);
    function getStringFromDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2) external view returns (string memory);

    // Set element:
    function setStringInDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2, string calldata _value) external returns (bool);
    function setStringInDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2, string calldata _value) external returns (bool);
    function setStringInDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2, string calldata _value) external returns (bool);

    // Delete element
    function deleteStringFromDoubleBytes32AddressMapping(bytes32 _module, bytes32 _mapping, bytes32 _key1, address _key2) external returns (bool);
    function deleteStringFromDoubleAddressAddressMapping(bytes32 _module, bytes32 _mapping, address _key1, address _key2) external returns (bool);
    function deleteStringFromDoubleAddressStringMapping(bytes32 _module, bytes32 _mapping, address _key1, string calldata _key2) external returns (bool);

}
