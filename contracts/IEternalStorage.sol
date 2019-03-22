pragma solidity ^0.5;

/**
 * @title EternalStorage
 * @dev The EternalStorage contract can be used to keep all the storage needed for contracts, which would
 * then access it (to set and read) by reference. This way, contracts can stay storage-less, and therefore
 * can be easily updated (migrated) without affecting the storage.
 * @dev Contracts that will be using this EternalStorage repository need to be whitelisted ("connected")
 * in order to be able to write the storage. Only the owner can whitelist ("connect") and unwhitelist
 * ("disconnect") individual contracts.
 */
contract IEternalStorage {

    /**
     * @notice Returns whether a particular contract is whitelisted ("connected") to be able to
     * write the eternal storage
     * @param whichContract The address of the contract that is connected or not
     */
    function isContractConnected(address whichContract) public view returns (bool);

    /**
     * @notice Approves an address to be able to connect contracts to the storage
     * @param who The address to be approved as a connecting agent
     */
    function approveToConnect(address who) public returns (bool);

    /**
     * @notice Revokes the ability to connect contracts to the storage from an address
     * @param who The address to be revoked as a connecting agent
     */
    function revokeApprovalToConnect(address who) public returns (bool);

    /**
     * @notice Returns whether an address is approved as a connecting agent
     * @param who The address to be checked
     */
    function isApprovedToConnect(address who) public view returns (bool);

    /**
     * @notice Allows a contract to connect to the eternal storage
     * @dev This method is intended to be called from the contract that is to be connected, which should be approved first as a connecting
     * agent. It is also possible to call his method from the constructor of the contract itself, in which case it is necessary to approve
     * the original sender of the contract instantiation transaction as a connection agent (i.e. the "onlyApprovedConnctingAgent" modifier
     * will be checking whether either msg.sender or tx.origin are approved)
     * @dev (typically the owner of the contract to connect and the owner of the eternal storage are the same)
     */
    function connectContract() external returns (bool);

    /**
     * @notice Allows a connected contract to disconnect from the eternal storage
     * @dev Again, this should be called only from a previously connected contract
     */
    function disconnectContract() external returns (bool);

    /**
     * @notice Allows the owner to whitlist ("connect") a contract to be able to write the eternal storage
     * @param whichContract The address of the contract that gets connected
     */
    function connectContract(address whichContract) external returns (bool);

    /**
     * @notice Unwhitlists ("disconnects") a contract so it will no longer be able to write the eternal storage
     * @dev Only the owner can disconnect a contract from the eternal storage
     * @param whichContract The address of the contract that gets disconnected
     */
    function disconnectContract(address whichContract) external returns (bool);

    // uint256

    /**
     * @notice Reads the value of a uint256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function getUint(bytes32 _key) external view returns(uint256);

    /**
     * @notice Sets the value of a uint256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function setUint(bytes32 _key, uint _value) external returns (bool);

    /**
     * @notice Deletes the value of a uint256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteUint(bytes32 _key) external returns (bool);

    // int256

    /**
     * @notice Reads the value of a int256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function getInt(bytes32 _key) external view returns(int256);

    /**
     * @notice Sets the value of a int256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function setInt(bytes32 _key, int256 _value) external returns (bool);

    /**
     * @notice Deletes the value of a int256 corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteInt(bytes32 _key) external returns (bool);

    // address

    /**
     * @notice Reads the value of an address corresponding to a key
     * @param _key The key that indexes the value
     */
    function getAddress(bytes32 _key) external view returns(address);

    /**
     * @notice Sets the value of an address corresponding to a key
     * @param _key The key that indexes the value
     */
    function setAddress(bytes32 _key, address _value) external returns (bool);

    /**
     * @notice Deletes the value of an address corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteAddress(bytes32 _key) external returns (bool);

    // bytes

    /**
     * @notice Reads the value of a bytes32 corresponding to a key
     * @param _key The key that indexes the value
     */
    function getBytes(bytes32 _key) external view returns(bytes memory);

    /**
     * @notice Sets the value of a bytes32 corresponding to a key
     * @param _key The key that indexes the value
     */
    function setBytes(bytes32 _key, bytes calldata _value) external returns (bool);

    /**
     * @notice Deletes the value of a bytes32 corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteBytes(bytes32 _key) external returns (bool);

    // bool

    /**
     * @notice Reads the value of a bool corresponding to a key
     * @param _key The key that indexes the value
     */
    function getBool(bytes32 _key) external view returns(bool);

    /**
     * @notice Sets the value of a bool corresponding to a key
     * @param _key The key that indexes the value
     */
    function setBool(bytes32 _key, bool _value) external returns (bool);

    /**
     * @notice Deletes the value of a bool corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteBool(bytes32 _key) external returns (bool);

    // string

    /**
     * @notice Reads the value of a string corresponding to a key
     * @param _key The key that indexes the value
     */
    function getString(bytes32 _key) external view returns(string memory);

    /**
     * @notice Sets the value of a string corresponding to a key
     * @param _key The key that indexes the value
     */
    function setString(bytes32 _key, string calldata _value) external returns (bool);

    /**
     * @notice Deletes the value of a string corresponding to a key
     * @param _key The key that indexes the value
     */
    function deleteString(bytes32 _key) external returns (bool);

}