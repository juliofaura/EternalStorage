pragma solidity ^0.5;

import "./EternalStorage.sol";
import "../../../OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract EternalStorageBase is Ownable {

    EternalStorage internal _eternalStorage;

    event EternalStorageSet(address oldEternalStorage, address newEternalStorage);

    constructor () internal {
    }

    modifier externalStorageSet() {
        require(isEternalStorageSet(), "Eternal Storage not set");
        _;
    }

    function isEternalStorageSet() public view returns(bool) {
        return _eternalStorage.isContractConnected(address(this));
    }

    function whichEternalStorage() public view returns(EternalStorage) {
        return _eternalStorage;
    }

    function setEternalStorage(address newEternalStorage) public onlyOwner {
        require(newEternalStorage != address(0), "Storage address cannot be zero");
        emit EternalStorageSet(address(_eternalStorage), newEternalStorage);
        _eternalStorage = EternalStorage(newEternalStorage);
        require(isEternalStorageSet(), "Not authorized by EternalStorage");
    }

    // Indexing keys
    function singleElementKey(bytes32 module, bytes32 variableName) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, variableName));
    }

    function indexedElementKey(bytes32 module, bytes32 arrayName, uint256 index) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, arrayName, index));
    }

    function indexedElementKey(bytes32 module, bytes32 arrayName, address _key) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, arrayName, _key));
    }

    function indexedElementKey(bytes32 module, bytes32 arrayName, string memory _key) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, arrayName, _key));
    }

    function doubleIndexedElementKey(bytes32 module, bytes32 arrayName, bytes32 _key1, address _key2) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, arrayName, _key1, _key2));
    }

    function doubleIndexedElementKey(bytes32 module, bytes32 arrayName, address _key1, address _key2) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(module, arrayName, _key1, _key2));
    }

    // Typing (very very basic!!)
    //
    // (This would be a lot better if we could pass complex types as parameters in functions
    // In this case we could then use something like:
    //
    // struct Uint {
    //    bytes32 module;
    //    bytes32 name;
    // }
    //
    // and then:
    //
    // function getUint(Uint variable) {...}
    //
    // or even define a "Type" in the struct to create generic operators)

    enum Types { Undeclared, Uint, Int, Address, Bytes, Bool, String, AddressArray, StringArray, UintArray }

    mapping (bytes32 => mapping (bytes32 => Types)) internal _declarations;

    function declare(bytes32 module, bytes32 variable, Types _type) public returns (bool) {
        require(_declarations[module][variable] == Types.Undeclared, "Variable is already declared");
        _declarations[module][variable] = _type;
        return true;
    }

    modifier isUint(bytes32 module, bytes32 variable) {
        require(_declarations[module][variable] == Types.Uint, "Variable is not declared as uint");
        _;
    }

    modifier isInt(bytes32 module, bytes32 variable) {
        require(_declarations[module][variable] == Types.Int, "Variable is not declared as int");
        _;
    }

    modifier isAddress(bytes32 module, bytes32 variable) {
        require(_declarations[module][variable] == Types.Address, "Variable is not declared as address");
        _;
    }

    modifier isBytes(bytes32 module, bytes32 variable) {
        require(_declarations[module][variable] == Types.Bytes, "Variable is not declared as bytes");
        _;
    }

    modifier isBool(bytes32 module, bytes32 variable) {
        require(_declarations[module][variable] == Types.Bool, "Variable is not declared as bool");
        _;
    }

    modifier isString(bytes32 module, bytes32 variable) {
        require(_declarations[module][variable] == Types.String, "Variable is not declared as string");
        _;
    }

    // uint256

    function getUint(bytes32 module, bytes32 variable)
        public view
        externalStorageSet
        isUint(module, variable)
        returns (uint)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.getUint(key);
    }

    function setUint(bytes32 module, bytes32 variable, uint256 value)
        public
        externalStorageSet
        isUint(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.setUint(key, value);
    }

    function deleteUint(bytes32 module, bytes32 variable)
        public
        externalStorageSet
        isUint(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.deleteUint(key);
    }

    // int256

    function getInt(bytes32 module, bytes32 variable)
        public view
        externalStorageSet
        isInt(module, variable)
        returns (int)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.getInt(key);
    }

    function setInt(bytes32 module, bytes32 variable, int256 value)
        public
        externalStorageSet
        isInt(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.setInt(key, value);
    }

    function deleteInt(bytes32 module, bytes32 variable)
        public
        externalStorageSet
        isInt(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.deleteInt(key);
    }

    // address

    function getAddress(bytes32 module, bytes32 variable)
        public view
        externalStorageSet
        isAddress(module, variable)
        returns (address)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.getAddress(key);
    }

    function setAddress(bytes32 module, bytes32 variable, address value)
        public
        externalStorageSet
        isAddress(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.setAddress(key, value);
    }

    function deleteAddress(bytes32 module, bytes32 variable)
        public
        externalStorageSet
        isAddress(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.deleteAddress(key);
    }

    // bytes

    function getBytes(bytes32 module, bytes32 variable)
        public view
        externalStorageSet
        isBytes(module, variable)
        returns (bytes memory)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.getBytes(key);
    }

    function setBytes(bytes32 module, bytes32 variable, bytes memory value)
        public
        externalStorageSet
        isBytes(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.setBytes(key, value);
    }

    function deleteBytes(bytes32 module, bytes32 variable)
        public
        externalStorageSet
        isBytes(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.deleteBytes(key);
    }

    // bool

    function getBool(bytes32 module, bytes32 variable)
        public view
        externalStorageSet
        isBool(module, variable)
        returns (bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.getBool(key);
    }

    function setBool(bytes32 module, bytes32 variable, bool value)
        public
        externalStorageSet
        isBool(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.setBool(key, value);
    }

    function deleteBool(bytes32 module, bytes32 variable)
        public
        externalStorageSet
        isBool(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.deleteBool(key);
    }

    // string

    function getString(bytes32 module, bytes32 variable)
        public view
        externalStorageSet
        isString(module, variable)
        returns (string memory)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.getString(key);
    }

    function setString(bytes32 module, bytes32 variable, string memory value)
        public
        externalStorageSet
        isString(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.setString(key, value);
    }

    function deleteString(bytes32 module, bytes32 variable)
        public
        externalStorageSet
        isString(module, variable)
        returns(bool)
    {
        bytes32 key = singleElementKey(module, variable);
        return _eternalStorage.deleteString(key);
    }

}