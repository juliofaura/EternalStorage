pragma solidity ^0.5;

import "./libraries/Strings.sol";
import "./EternalStorage.sol";
import "./EternalStorageConnector.sol";

/**
 * Example of how to use Eternal Storage construct
 * Inspired in a detailed ERC20 token contract
 */
contract Example is EternalStorageConnector {

    using Strings for string;

    // Data structures (in eternal storage)

    bytes32 constant private THIS_CONTRACT_NAME = "ThisContract";

    /**
     * @dev Data structures (implemented in the eternal storage):
     * @dev _NAME : string with the name of the token (e.g. "Santander Electronic Money Token")
     * @dev _SYMBOL : string with the symbol / ticker of the token (e.g. "SANEMEUR")
     * @dev _CURRENCY : string with the symbol of the currency (e.g. "EUR")
     * @dev _DECIMALS : uint with the number of decimals (e.g. 2 for cents) (this is for information purposes only)
     * @dev _INITIALIZED : bool flag set to true when the eternal storage has been initialized
     */
    bytes32 constant private _NAME = "_name";
    bytes32 constant private _SYMBOL = "_symbol";
    bytes32 constant private _CURRENCY = "_currency";
    bytes32 constant private _DECIMALS = "_decimals";
    bytes32 constant private _INITIALIZED = "_initialized";

    event Created(string indexed name, string indexed symbol, string indexed currency, uint8 decimals);

    // Constructor

    constructor (string memory name, string memory symbol, string memory currency, uint8 decimals, address eternalStorage) public {

        if(eternalStorage == address(0)) {
            eternalStorage = address(new EternalStorage());
            EternalStorage(eternalStorage).transferOwnership(msg.sender);
        }

        setEternalStorage(eternalStorage);
        if(whichEternalStorage().getBool(THIS_CONTRACT_NAME, _INITIALIZED)) {
            require(whichEternalStorage().getString(THIS_CONTRACT_NAME, _NAME).equals(name), "Given name different to the one stored in the eternal storage");
            require(whichEternalStorage().getString(THIS_CONTRACT_NAME, _SYMBOL).equals(symbol), "Given symbol different to the one stored in the eternal storage");
            require(whichEternalStorage().getString(THIS_CONTRACT_NAME, _CURRENCY).equals(currency), "Given currency different to the one stored in the eternal storage");
            require(whichEternalStorage().getUint(THIS_CONTRACT_NAME, _DECIMALS) == decimals, "Given decimals different to the one stored in the eternal storage");
        } else {
            whichEternalStorage().setString(THIS_CONTRACT_NAME, _NAME, name);
            whichEternalStorage().setString(THIS_CONTRACT_NAME, _SYMBOL, symbol);
            whichEternalStorage().setString(THIS_CONTRACT_NAME, _CURRENCY, currency);
            whichEternalStorage().setUint(THIS_CONTRACT_NAME, _DECIMALS, uint256(decimals));
            whichEternalStorage().setBool(THIS_CONTRACT_NAME, _INITIALIZED, true);
        }
        emit Created(name, symbol, currency, decimals);
    }

    // External functions

    /**
     * @notice Show the name of the tokenizer entity
     * @return the name of the token.
     */
    function name() external view returns (string memory) {
        return whichEternalStorage().getString(THIS_CONTRACT_NAME, _NAME);
    }

    /**
     * @notice Show the symbol of the token
     * @return the symbol of the token.
     */
    function symbol() external view returns (string memory) {
        return whichEternalStorage().getString(THIS_CONTRACT_NAME, _SYMBOL);
    }

    /**
     * @notice Show the currency that backs the token
     * @return the currency of the token.
     */
    function currency() external view returns (string memory) {
        return whichEternalStorage().getString(THIS_CONTRACT_NAME, _CURRENCY);
    }

    /**
     * @notice Show the number of decimals of the token (remember, this is just for information purposes)
     * @return the number of decimals of the token.
     */
    function decimals() external view returns (uint8) {
        return uint8(whichEternalStorage().getUint(THIS_CONTRACT_NAME, _DECIMALS));
    }

}