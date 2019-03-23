pragma solidity ^0.5;

import "./wrappers/EternalStorageUintArray.sol";
import "./wrappers/EternalStorageAddressArray.sol";
import "./wrappers/EternalStorageBoolArray.sol";
import "./wrappers/EternalStorageStringArray.sol";
import "./wrappers/EternalStorageAllAddressMappings.sol";
import "./wrappers/EternalStorageAllStringMappings.sol";
import "./wrappers/EternalStorageBoolDoubleMapping.sol";
import "./wrappers/EternalStorageUintDoubleMapping.sol";
import "./wrappers/EternalStorageUintTripleMapping.sol";

/**
 * @title EternalStorage
 * @dev The EternalStorage contract can be used to keep all the storage needed for contracts, which would
 * then access it (to set and read) by reference. This way, contracts can stay storage-less, and therefore
 * can be easily updated (migrated) without affecting the storage.
 * @dev Contracts that will be using this EternalStorage repository need to be whitelisted ("connected")
 * in order to be able to write the storage. Only the owner can whitelist ("connect") and unwhitelist
 * ("disconnect") individual contracts.
 */
contract EternalStorage is
    EternalStorageUintArray,
    EternalStorageAddressArray,
    EternalStorageBoolArray,
    EternalStorageStringArray,
    EternalStorageAllAddressMappings,
    EternalStorageAllStringMappings,
    EternalStorageBoolDoubleMapping,
    EternalStorageUintDoubleMapping,
    EternalStorageUintTripleMapping
{
}