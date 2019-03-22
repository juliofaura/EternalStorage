pragma solidity ^0.5;

import "./Pausable.sol";
import "./interfaces/IEternalStorageBase.sol";

/**
 * @title EternalStorage
 * @dev The EternalStorage contract can be used to keep all the storage needed for contracts, which would
 * then access it (to set and read) by reference. This way, contracts can stay storage-less, and therefore
 * can be easily updated (migrated) without affecting the storage.
 * @dev Contracts that will be using this EternalStorage repository need to be whitelisted ("connected")
 * in order to be able to write the storage. Only the owner can whitelist ("connect") and unwhitelist
 * ("disconnect") individual contracts.
 */
contract EternalStorageBase is IEternalStorageBase, Pausable {

    // Data structures

    mapping (address => bool) private _connectedContracts;
    mapping (address => bool) private _approvedToConnect;

    mapping(address => mapping(bytes32 => uint256)) private _uIntStorage;
    mapping(address => mapping(bytes32 => int256)) private _intStorage;
    mapping(address => mapping(bytes32 => address)) private _addressStorage;
    mapping(address => mapping(bytes32 => bytes)) private _bytesStorage;
    mapping(address => mapping(bytes32 => bool)) private _boolStorage;
    mapping(address => mapping(bytes32 => string)) private _stringStorage;

    // Events

    event ContractConnected(address indexed whichContract);
    event ContractDisconnected(address indexed whichContract);
    event ApprovalToConnectGranted(address indexed who);
    event ApprovalToConnectRevoked(address indexed who);

    // Modifiers

    /**
     * @dev Throws if called by any account other than the _userContract.
     */
    // modifier onlyConnectedContract() {
    //     require(_connectedContracts[msg.sender], "Calling contract not connected");
    //     _;
    // }

    /**
     * @dev Throws if called by an agent that is not approved.
     */
    modifier onlyApprovedToConnect {
        require(_approvedToConnect[msg.sender] || _approvedToConnect[tx.origin], "Sender of connection request not approved");
        _;
    }

    // Constructor
    constructor() public {
        _approveToConnect(msg.sender);
    }

    // Interface functions (all external)

    /**
     * @notice Returns whether a particular contract is whitelisted ("connected") to be able to
     * write the eternal storage
     * @param whichContract The address of the contract that is connected or not
     */
    function isContractConnected(address whichContract) external view returns (bool) {
        return _connectedContracts[whichContract];
    }

    /**
     * @notice Approves an address to be able to connect contracts to the storage
     * @param who The address to be approved as a connecting agent
     */
    function approveToConnect(address who) external onlyOwner returns (bool) {
        return _approveToConnect(who);
    }

    /**
     * @notice Revokes the ability to connect contracts to the storage from an address
     * @param who The address to be revoked as a connecting agent
     */
    function revokeApprovalToConnect(address who) external onlyOwner returns (bool) {
        _approvedToConnect[who] = false;
        emit ApprovalToConnectRevoked(who);
        return true;
    }

    /**
     * @notice Returns whether an address is approved as a connecting agent
     * @param who The address to be checked
     */
    function isApprovedToConnect(address who) external view returns (bool) {
        return _approvedToConnect[who];
    }

    /**
     * @notice Allows a contract to connect to the eternal storage
     * @dev This method is intended to be called from the contract that is to be connected, which should be approved first as a connecting
     * agent. It is also possible to call his method from the constructor of the contract itself, in which case it is necessary to approve
     * the original sender of the contract instantiation transaction as a connection agent (i.e. the "onlyApprovedConnctingAgent" modifier
     * will be checking whether either msg.sender or tx.origin are approved)
     * @dev (typically the owner of the contract to connect and the owner of the eternal storage are the same)
     */
    function connectContract() external onlyApprovedToConnect returns (bool) {
        _connectedContracts[msg.sender] = true;
        _approvedToConnect[msg.sender] = true; // So the contract can connect other contracts
        emit ContractConnected(msg.sender);
        return true;
    }

    /**
     * @notice Allows a connected contract to disconnect from the eternal storage
     * @dev Again, this should be called only from a previously connected contract
     */
    function disconnectContract() external returns (bool) {
        require(_connectedContracts[msg.sender], "Contract is not connected");
        _connectedContracts[msg.sender] = false;
        emit ContractDisconnected(msg.sender);
        return true;
    }

    /**
     * @notice Allows the owner to whitlist ("connect") a contract to be able to write the eternal storage
     * @param whichContract The address of the contract that gets connected
     */
    function connectContract(address whichContract) external onlyOwner returns (bool) {
        _connectedContracts[whichContract] = true;
        emit ContractConnected(whichContract);
        return true;
    }

    /**
     * @notice Unwhitlists ("disconnects") a contract so it will no longer be able to write the eternal storage
     * @dev Only the owner can disconnect a contract from the eternal storage
     * @param whichContract The address of the contract that gets disconnected
     */
    function disconnectContract(address whichContract) external onlyOwner returns (bool) {
        _connectedContracts[whichContract] = false;
        emit ContractDisconnected(whichContract);
        return true;
    }

    // uint256

    /**
     * @notice Reads the value of a uint256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function getUint(bytes32 _key) internal view returns(uint256) {
        onlyConnectedContract();
        return _uIntStorage[tx.origin][_key];
    }

    /**
     * @notice Sets the value of a uint256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function setUint(bytes32 _key, uint _value) internal returns (bool) {
        onlyConnectedContract();
        _uIntStorage[tx.origin][_key] = _value;
        return true;
    }

    /**
     * @notice Deletes the value of a uint256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteUint(bytes32 _key) internal returns (bool) {
        onlyConnectedContract();
        delete _uIntStorage[tx.origin][_key];
        return true;
    }

    // int256

    /**
     * @notice Reads the value of a int256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function getInt(bytes32 _key) internal view returns(int256) {
        onlyConnectedContract();
        return _intStorage[tx.origin][_key];
    }

    /**
     * @notice Sets the value of a int256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function setInt(bytes32 _key, int256 _value) internal returns (bool) {
        onlyConnectedContract();
        _intStorage[tx.origin][_key] = _value;
        return true;
    }

    /**
     * @notice Deletes the value of a int256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteInt(bytes32 _key) internal returns (bool) {
        onlyConnectedContract();
        delete _intStorage[tx.origin][_key];
        return true;
    }

    // address

    /**
     * @notice Reads the value of an address corresponding to a key
     * @param _key The key that indexes the value
     */
    function getAddress(bytes32 _key) internal view returns(address) {
        onlyConnectedContract();
        return _addressStorage[tx.origin][_key];
    }

    /**
     * @notice Sets the value of an address corresponding to a key
     * @param _key The key that indexes the value
     */
    function setAddress(bytes32 _key, address _value) internal returns (bool) {
        onlyConnectedContract();
        _addressStorage[tx.origin][_key] = _value;
        return true;
    }

    /**
     * @notice Deletes the value of an address corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteAddress(bytes32 _key) internal returns (bool) {
        onlyConnectedContract();
        delete _addressStorage[tx.origin][_key];
        return true;
    }

    // bytes

    /**
     * @notice Reads the value of a bytes32 corresponding to a key
     * @param _key The key that indexes the value
     */
    function getBytes(bytes32 _key) internal view returns(bytes memory) {
        onlyConnectedContract();
        return _bytesStorage[tx.origin][_key];
    }

    /**
     * @notice Sets the value of a bytes32 corresponding to a key
     * @param _key The key that indexes the value
     */
    function setBytes(bytes32 _key, bytes memory _value) internal returns (bool) {
        onlyConnectedContract();
        _bytesStorage[tx.origin][_key] = _value;
        return true;
    }

    /**
     * @notice Deletes the value of a bytes32 corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteBytes(bytes32 _key) internal returns (bool) {
        onlyConnectedContract();
        delete _bytesStorage[tx.origin][_key];
        return true;
    }

    // bool

    /**
     * @notice Reads the value of a bool corresponding to a key
     * @param _key The key that indexes the value
     */
    function getBool(bytes32 _key) internal view returns(bool) {
        onlyConnectedContract();
        return _boolStorage[tx.origin][_key];
    }

    /**
     * @notice Sets the value of a bool corresponding to a key
     * @param _key The key that indexes the value
     */
    function setBool(bytes32 _key, bool _value) internal returns (bool) {
        onlyConnectedContract();
        _boolStorage[tx.origin][_key] = _value;
        return true;
    }

    /**
     * @notice Deletes the value of a bool corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteBool(bytes32 _key) internal returns (bool) {
        onlyConnectedContract();
        delete _boolStorage[tx.origin][_key];
        return true;
    }

    // string

    /**
     * @notice Reads the value of a string corresponding to a key
     * @param _key The key that indexes the value
     */
    function getString(bytes32 _key) internal view returns(string memory) {
        onlyConnectedContract();
        return _stringStorage[tx.origin][_key];
    }

    /**
     * @notice Sets the value of a string corresponding to a key
     * @param _key The key that indexes the value
     */
    function setString(bytes32 _key, string memory _value) internal returns (bool) {
        onlyConnectedContract();
        _stringStorage[tx.origin][_key] = _value;
        return true;
    }

    /**
     * @notice Deletes the value of a string corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteString(bytes32 _key) internal returns (bool) {
        onlyConnectedContract();
        delete _stringStorage[tx.origin][_key];
        return true;
    }

    // Private functions

    function onlyConnectedContract() private whenNotPaused view {
        require(_connectedContracts[msg.sender], "Calling contract not connected");
    }

    function _approveToConnect(address who) private onlyOwner returns (bool) {
        _approvedToConnect[who] = true;
        emit ApprovalToConnectGranted(who);
        return true;
    }

}