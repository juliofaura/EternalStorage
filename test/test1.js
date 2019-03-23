const EternalStorage = artifacts.require("EternalStorage");
const truffleAssert = require('truffle-assertions'); // install with: npm install truffle-assertions

contract("EternalStorage", accounts => {
    var instance
    var ownerAccount = accounts[0]
    var sendingContract = accounts[1]
    var anotherSendingContract = accounts[2]
    var notConnectedContract = accounts[3]

    var MODULE1 = web3.utils.fromUtf8("Module1")
    var MODULE2 = web3.utils.fromUtf8("Module2")

    var SIMPLE_VARIABLE1 = web3.utils.fromUtf8("_simple_variable1")
    var SIMPLE_VARIABLE2 = web3.utils.fromUtf8("_simple_variable2")

    var UINT_ARRAY_VARIABLE2 = web3.utils.fromUtf8("_uint_array_variable2")
    var UINT_ARRAY_VARIABLE1 = web3.utils.fromUtf8("_uint_array_variable1")

    var ADDRESS_ARRAY_VARIABLE2 = web3.utils.fromUtf8("_address_array_variable2")
    var ADDRESS_ARRAY_VARIABLE1 = web3.utils.fromUtf8("_address_array_variable1")

    var BOOL_ARRAY_VARIABLE2 = web3.utils.fromUtf8("_bool_array_variable2")
    var BOOL_ARRAY_VARIABLE1 = web3.utils.fromUtf8("_bool_array_variable1")

    var STRING_ARRAY_VARIABLE2 = web3.utils.fromUtf8("_string_array_variable2")
    var STRING_ARRAY_VARIABLE1 = web3.utils.fromUtf8("_string_array_variable1")

    var MAPPING_VARIABLE1 = web3.utils.fromUtf8("_mapping_variable1")
    var MAPPING_VARIABLE2 = web3.utils.fromUtf8("_mapping_variable2")

    var UINT_VALUE1 = 1687
    var UINT_VALUE2 = 28524
    var UINT_VALUE3 = 16435
    var UINT_VALUE4 = 898273947
    var UINT_VALUE5 = 97

    var INT_VALUE1 = -1687
    var INT_VALUE2 = -28524

    var ADDRESS_VALUE1 = accounts[9]
    var ADDRESS_VALUE2 = accounts[8]
    var ADDRESS_VALUE3 = accounts[7]
    var ADDRESS_VALUE4 = accounts[6]
    var ADDRESS_VALUE5 = accounts[5]

    var BYTES_VALUE1 = '0x4a87f878979b7090076788fabbc7895986def8797907cc78901286488290078dadddb8757578effbb32348d78e78d8da'
    var BYTES_VALUE2 = '0xdd7879876f9876e9018234567987679d8789f7e9e987987cc9a797876996d00023328498ffefefdadc748923479aa678'

    var BOOL_VALUE1 = true
    var BOOL_VALUE2 = false
    var BOOL_VALUE3 = true
    var BOOL_VALUE4 = false
    var BOOL_VALUE5 = true

    var STRING_VALUE1 = "987y24kjlnflknvj np89ñip98p9nuq3p0 9n7ppoi p nb'790apuidpfo audfp097 qnpo t4iu npsdo8g7n pqoi4taodfuiyn"
    var STRING_VALUE2 = "jhdof87ynqljhnp98sb h iuh iohu klh hl bp98 apoiauhdfln uayofiu nañodsifu nlaioduf laksduyfb lasiduf hhjk"
    var STRING_VALUE3 = "1098yuih akdshjf poaihf y09 y7u4ithqfep9oauf yoaiusdjfàp ioshdf pñlaousdf p9iquh lkajsdh piuaohw elfkajdh "
    var STRING_VALUE4 = "'18kahd flkjahd foiauh dflkajhds 998q3p94irue adsofh pquy4h lkajhds vpouahe ñlajkhsd fpo auhweij fñaljhsd "
    var STRING_VALUE5 = "a dslifha dñf hqo4iyr poakhfj dnaoñushkd fpaouweghf qpowejhrg alkjdshfg liauiñ lihsañdfl jhañldshjalkdsjhgla"

    var ADDRESS_KEY1 = "0x89D42382C2b7996c9C4CDe6039C69F9Acd46366E"
    var ADDRESS_KEY2 = "0x2cbeBA2e48D25bce5740a6ecdF4dEeeAFa5832e7"

    var STRING_KEY1 = "oajhfdnoqiuwyrn0vq983yunvpaowe8fhv'098q2787yhaljkhdfoiyualksñdjn alkdfh alksdhfl kajd"
    var STRING_KEY2 = "98yiuhojlk  iouao idhflkjah a laksfliu qyo4iruhalsdkufh oailudshf ñalskdjf asdkljfh asldk"

    var BYTES32_KEY1 = '0x672398234ad5c9f8da645237845678ddee67f639a6aabbdd237815692587936a'
    var BYTES32_KEY2 = '0x78392759f4a6d7e52e3eabc6c7c8c95a3fefe6b78b4b3b6a6a6d8e8ffafeef56'

    // runs before all tests
    before(done => {
        EternalStorage.new({from: ownerAccount})
        .then(_instance => {
            instance = _instance;
        })
        .then(done).catch(done);
    });


    //Now testing basic permissioning

    it("Should start with the owner approved to connect", done => {
        instance.isApprovedToConnect.call(ownerAccount).then(_result => {
            assert(_result, "Owner is not approved to connect");
        })
        .then(done).catch(done);
    });

    it("Should start with no others approved to connect", done => {
        instance.isApprovedToConnect.call(sendingContract).then(_result => {
            assert(!_result, "Non owner is approved to connect");
        })
        .then(done).catch(done);
    });

    // it('Non approved contract should not be able to connect', async () => {
    //     let err = null    
    //     try {
    //       await instance.connectContract({from:sendingContract})
    //     } catch (error) {
    //       err = error
    //     }
    //     assert.ok(err instanceof Error)
    // })
    // (Different way to assert reverts, now using the one below)

    it('Non approved contract should not be able to connect', async () => {
        await truffleAssert.reverts(instance.connectContract({from:sendingContract}), "", "Was able to connect");
    })

    it('Non approved address should not be able to approve a contract to connect', async () => {
        await truffleAssert.reverts(instance.approveToConnect(sendingContract, {from:sendingContract}), "", "Was able to approve");
    })

    it("Owner should be able to approve a contract to connect", done => {
        instance.approveToConnect(sendingContract, {from:ownerAccount}).then(_tx => {
            // Another way to check for events:
            // truffleAssert.eventEmitted(_tx, "ApprovalToConnectGranted", (ev) => {
            //     return ev.who == sendingContract;
            // })
            var event = _tx.logs[0];
            assert.equal(event.event, "ApprovalToConnectGranted", "ApprovalToConnectGranted event not issued");
            assert.equal(event.args.who, sendingContract, "Incorrect argument in ApprovalToConnectGranted event");
            instance.isApprovedToConnect.call(sendingContract).then(_result => {
                assert(_result, "Contract not approved to connect");
            })
        })
        .then(done).catch(done);
    });

    it("Approved contract should be able to connect", done => {
        instance.connectContract({from:sendingContract}).then(_tx => {
            var event = _tx.logs[0];
            assert.equal(event.event, "ContractConnected", "ContractConnected event not issued");
            assert.equal(event.args.whichContract, sendingContract, "Incorrect argument in ContractConnected event");
            instance.isContractConnected.call(sendingContract).then(_result => {
                assert(_result, "Contract not connected");
            })
        })
        .then(done).catch(done);
    });

    it("Owner should be able to directly connect a contract", done => {
        instance.connectContractByOwner(anotherSendingContract, {from:ownerAccount}).then(_tx => {
            var event = _tx.logs[0];
            assert.equal(event.event, "ContractConnectedByOwner", "ContractConnected event not issued");
            assert.equal(event.args.whichContract, anotherSendingContract, "Incorrect argument in ContractConnected event");
            instance.isContractConnected.call(anotherSendingContract).then(_result => {
                assert(_result, "Contract not connected");
            })
        })
        .then(done).catch(done);
    });

    it("Previously connected contract should stay connected", done => {
        instance.isContractConnected.call(sendingContract).then(_result => {
            assert(_result, "Contract not connected");
        })
        .then(done).catch(done);
    });

    // Not connected contracts

    it('Non connected contract should not be able to store anything', async () => {
        await truffleAssert.reverts(instance.setUint(MODULE1, SIMPLE_VARIABLE1, UINT_VALUE3, {from:notConnectedContract}), "", "Was able to store uint");
    })

    // Storing values into Eternal Storage

    it("Connected contract should be able to store an uint", done => {
        instance.setUint(MODULE1, SIMPLE_VARIABLE1, UINT_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store another uint on the same module and different variable", done => {
        instance.setUint(MODULE1, SIMPLE_VARIABLE2, UINT_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store another uint on another module and the same variable", done => {
        instance.setUint(MODULE2, SIMPLE_VARIABLE1, UINT_VALUE3, {from:sendingContract}).then(_result => {
        })    
        .then(done).catch(done);
    });    

    it("Another connected contract should be able to store an uint with the same module and variable name", done => {
        instance.setUint(MODULE1, SIMPLE_VARIABLE1, UINT_VALUE2, {from:anotherSendingContract}).then(_result => {
        })    
        .then(done).catch(done);
    });    

    it("Connected contract should be able to store an int", done => {
        instance.setInt(MODULE1, SIMPLE_VARIABLE1, INT_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Another connected contract should be able to store an int", done => {
        instance.setInt(MODULE2, SIMPLE_VARIABLE2, INT_VALUE2, {from:anotherSendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store an address", done => {
        instance.setAddress(MODULE1, SIMPLE_VARIABLE1, ADDRESS_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Another connected contract should be able to store an address", done => {
        instance.setAddress(MODULE2, SIMPLE_VARIABLE2, ADDRESS_VALUE2, {from:anotherSendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a bytes array", done => {
        instance.setBytes(MODULE1, SIMPLE_VARIABLE1, BYTES_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Another connected contract should be able to store a bytes array", done => {
        instance.setBytes(MODULE2, SIMPLE_VARIABLE2, BYTES_VALUE2, {from:anotherSendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a bool", done => {
        instance.setBool(MODULE1, SIMPLE_VARIABLE1, BOOL_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Another connected contract should be able to store a bool", done => {
        instance.setBool(MODULE2, SIMPLE_VARIABLE2, BOOL_VALUE2, {from:anotherSendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store an string", done => {
        instance.setString(MODULE1, SIMPLE_VARIABLE1, STRING_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Another connected contract should be able to store an string", done => {
        instance.setString(MODULE2, SIMPLE_VARIABLE2, STRING_VALUE2, {from:anotherSendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    // Reading simple values

    it("Uint values should be correctly stored (1)", done => {
        instance.getUint.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE1, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Uint values should be correctly stored (2)", done => {
        instance.getUint.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE2, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Uint values should be correctly stored (3)", done => {
        instance.getUint.call(MODULE2, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE3, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Uint values should be correctly stored (4)", done => {
        instance.getUint.call(MODULE1, SIMPLE_VARIABLE1, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE2, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized uint variables should yield zero", done => {
        instance.getUint.call(MODULE2, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Int values should be correctly stored (1)", done => {
        instance.getInt.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, INT_VALUE1, "Int value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Int values should be correctly stored (2)", done => {
        instance.getInt.call(MODULE2, SIMPLE_VARIABLE2, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, INT_VALUE2, "Int value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized int variables should yield zero", done => {
        instance.getInt.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Int value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Address values should be correctly stored (1)", done => {
        instance.getAddress.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE1, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Address values should be correctly stored (2)", done => {
        instance.getAddress.call(MODULE2, SIMPLE_VARIABLE2, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE2, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized address variables should yield zero", done => {
        instance.getAddress.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Byte array values should be correctly stored (1)", done => {
        instance.getBytes.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, BYTES_VALUE1, "Bytes value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Byte array values should be correctly stored (2)", done => {
        instance.getBytes.call(MODULE2, SIMPLE_VARIABLE2, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, BYTES_VALUE2, "Bytes value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized bytes array variables should yield zero", done => {
        instance.getBytes.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, null, "Bytes value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Bool values should be correctly stored (1)", done => {
        instance.getBool.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE1, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Bool values should be correctly stored (2)", done => {
        instance.getBool.call(MODULE2, SIMPLE_VARIABLE2, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE2, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized bool variables should yield false", done => {
        instance.getBool.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, false, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("String values should be correctly stored (1)", done => {
        instance.getString.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE1, "String value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("String values should be correctly stored (2)", done => {
        instance.getString.call(MODULE2, SIMPLE_VARIABLE2, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE2, "String value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized string variables should yield zero", done => {
        instance.getString.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, "", "String value not correctly stored");
        })
        .then(done).catch(done);
    });


    // Uint arrays

    it("Uinitialized uint arrays should have zero elements", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, UINT_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint array does not have zero elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an uint into an array (1)", done => {
        instance.pushUintToArray(MODULE1, UINT_ARRAY_VARIABLE1, UINT_VALUE5, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store an uint into an array (2)", done => {
        instance.pushUintToArray(MODULE1, UINT_ARRAY_VARIABLE1, UINT_VALUE4, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an uint into an array (3)", done => {
        instance.pushUintToArray(MODULE1, UINT_ARRAY_VARIABLE1, UINT_VALUE3, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an uint into an array (4)", done => {
        instance.pushUintToArray(MODULE1, UINT_ARRAY_VARIABLE1, UINT_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an uint array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, UINT_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 4, "Uint array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete an uint from an array", done => {
        instance.deleteUintFromArray(MODULE1, UINT_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an uint array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, UINT_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "Uint array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to change the value of an uint in an array", done => {
        instance.setUintInArray(MODULE1, UINT_ARRAY_VARIABLE1, 0, UINT_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an uint array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, UINT_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "Uint array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Uint array values should be correctly stored (1)", done => {
        instance.getUintFromArray.call(MODULE1, UINT_ARRAY_VARIABLE1, 0, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE1, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Uint array values should be correctly stored (2)", done => {
        instance.getUintFromArray.call(MODULE1, UINT_ARRAY_VARIABLE1, 1, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE4, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Uint array values should be correctly stored (3)", done => {
        instance.getUintFromArray.call(MODULE1, UINT_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE2, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    // Address arrays

    it("Uinitialized address arrays should have zero elements", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, ADDRESS_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint array does not have zero elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an address into an array (1)", done => {
        instance.pushAddressToArray(MODULE1, ADDRESS_ARRAY_VARIABLE1, ADDRESS_VALUE5, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store an address into an array (2)", done => {
        instance.pushAddressToArray(MODULE1, ADDRESS_ARRAY_VARIABLE1, ADDRESS_VALUE4, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an address into an array (3)", done => {
        instance.pushAddressToArray(MODULE1, ADDRESS_ARRAY_VARIABLE1, ADDRESS_VALUE3, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an address into an array (4)", done => {
        instance.pushAddressToArray(MODULE1, ADDRESS_ARRAY_VARIABLE1, ADDRESS_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an address array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, ADDRESS_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 4, "Address array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete an address from an array", done => {
        instance.deleteAddressFromArray(MODULE1, ADDRESS_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an address array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, ADDRESS_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "Address array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to change the value of an address in an array", done => {
        instance.setAddressInArray(MODULE1, ADDRESS_ARRAY_VARIABLE1, 0, ADDRESS_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an address array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, ADDRESS_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "Address array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Address array values should be correctly stored (1)", done => {
        instance.getAddressFromArray.call(MODULE1, ADDRESS_ARRAY_VARIABLE1, 0, {from:sendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE1, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Address array values should be correctly stored (2)", done => {
        instance.getAddressFromArray.call(MODULE1, ADDRESS_ARRAY_VARIABLE1, 1, {from:sendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE4, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Address array values should be correctly stored (3)", done => {
        instance.getAddressFromArray.call(MODULE1, ADDRESS_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE2, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    // Bool arrays

    it("Uinitialized bool arrays should have zero elements", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, BOOL_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint array does not have zero elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an bool into an array (1)", done => {
        instance.pushBoolToArray(MODULE1, BOOL_ARRAY_VARIABLE1, BOOL_VALUE5, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store an bool into an array (2)", done => {
        instance.pushBoolToArray(MODULE1, BOOL_ARRAY_VARIABLE1, BOOL_VALUE4, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an bool into an array (3)", done => {
        instance.pushBoolToArray(MODULE1, BOOL_ARRAY_VARIABLE1, BOOL_VALUE3, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an bool into an array (4)", done => {
        instance.pushBoolToArray(MODULE1, BOOL_ARRAY_VARIABLE1, BOOL_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an bool array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, BOOL_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 4, "Bool array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete an bool from an array", done => {
        instance.deleteBoolFromArray(MODULE1, BOOL_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an bool array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, BOOL_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "Bool array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to change the value of an bool in an array", done => {
        instance.setBoolInArray(MODULE1, BOOL_ARRAY_VARIABLE1, 0, BOOL_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an bool array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, BOOL_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "Bool array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Bool array values should be correctly stored (1)", done => {
        instance.getBoolFromArray.call(MODULE1, BOOL_ARRAY_VARIABLE1, 0, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE1, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Bool array values should be correctly stored (2)", done => {
        instance.getBoolFromArray.call(MODULE1, BOOL_ARRAY_VARIABLE1, 1, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE4, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Bool array values should be correctly stored (3)", done => {
        instance.getBoolFromArray.call(MODULE1, BOOL_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE2, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    // String arrays

    it("Uinitialized string arrays should have zero elements", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, STRING_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint array does not have zero elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an string into an array (1)", done => {
        instance.pushStringToArray(MODULE1, STRING_ARRAY_VARIABLE1, STRING_VALUE5, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store an string into an array (2)", done => {
        instance.pushStringToArray(MODULE1, STRING_ARRAY_VARIABLE1, STRING_VALUE4, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an string into an array (3)", done => {
        instance.pushStringToArray(MODULE1, STRING_ARRAY_VARIABLE1, STRING_VALUE3, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to push an string into an array (4)", done => {
        instance.pushStringToArray(MODULE1, STRING_ARRAY_VARIABLE1, STRING_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an string array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, STRING_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 4, "String array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete an string from an array", done => {
        instance.deleteStringFromArray(MODULE1, STRING_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an string array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, STRING_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "String array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to change the value of an string in an array", done => {
        instance.setStringInArray(MODULE1, STRING_ARRAY_VARIABLE1, 0, STRING_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Number of elements in an string array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, STRING_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "String array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("String array values should be correctly stored (1)", done => {
        instance.getStringFromArray.call(MODULE1, STRING_ARRAY_VARIABLE1, 0, {from:sendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE1, "String value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("String array values should be correctly stored (2)", done => {
        instance.getStringFromArray.call(MODULE1, STRING_ARRAY_VARIABLE1, 1, {from:sendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE4, "String value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("String array values should be correctly stored (3)", done => {
        instance.getStringFromArray.call(MODULE1, STRING_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE2, "String value not correctly stored");
        })
        .then(done).catch(done);
    });

    // Address mappings

    it("Connected contract should be able to store a value into a mapping (address => uint)", done => {
        instance.setUintInAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, UINT_VALUE3, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a mapping (address => int)", done => {
        instance.setIntInAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, INT_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a mapping (address => address)", done => {
        instance.setAddressInAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, ADDRESS_VALUE3, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a mapping (address => bytes)", done => {
        instance.setBytesInAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, BYTES_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a mapping (address => bool)", done => {
        instance.setBoolInAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, BOOL_VALUE3, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a mapping (address => string)", done => {
        instance.setStringInAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, STRING_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });



    // Read address mapping

    it("address => uint mappings should be correctly stored", done => {
        instance.getUintFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE3, "Uint value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => int mappings should be correctly stored", done => {
        instance.getIntFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, INT_VALUE2, "Int value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => address mappings should be correctly stored", done => {
        instance.getAddressFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE3, "Address value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => bytes mappings should be correctly stored", done => {
        instance.getBytesFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, BYTES_VALUE2, "Bytes value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => bool mappings should be correctly stored", done => {
        instance.getBoolFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE3, "Bool value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => string mappings should be correctly stored", done => {
        instance.getStringFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE2, "String value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    // Deleting values

    it("Connected contract should be able to delete a value into a mapping (address => uint)", done => {
        instance.deleteUintFromAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a mapping (address => int)", done => {
        instance.deleteIntFromAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a mapping (address => address)", done => {
        instance.deleteAddressFromAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a mapping (address => bytes)", done => {
        instance.deleteBytesFromAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a mapping (address => bool)", done => {
        instance.deleteBoolFromAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a mapping (address => string)", done => {
        instance.deleteStringFromAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    // Read zero values

    it("address => uint mappings should be correctly stored", done => {
        instance.getUintFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => int mappings should be correctly stored", done => {
        instance.getIntFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Int value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => address mappings should be correctly stored", done => {
        instance.getAddressFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Address value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => bytes mappings should be correctly stored", done => {
        instance.getBytesFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, null, "Bytes value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => bool mappings should be correctly stored", done => {
        instance.getBoolFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, false, "Bool value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => string mappings should be correctly stored", done => {
        instance.getStringFromAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, "", "String value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });



    // String mappings

    it("Connected contract should be able to store a value into a mapping (address => uint)", done => {
        instance.setUintInStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, UINT_VALUE3, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a mapping (address => int)", done => {
        instance.setIntInStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, INT_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a mapping (address => address)", done => {
        instance.setAddressInStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, ADDRESS_VALUE3, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a mapping (address => bytes)", done => {
        instance.setBytesInStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, BYTES_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a mapping (address => bool)", done => {
        instance.setBoolInStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, BOOL_VALUE3, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a mapping (address => string)", done => {
        instance.setStringInStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, STRING_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    // Read string mapping

    it("address => uint mappings should be correctly stored", done => {
        instance.getUintFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE3, "Uint value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => int mappings should be correctly stored", done => {
        instance.getIntFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, INT_VALUE2, "Int value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => address mappings should be correctly stored", done => {
        instance.getAddressFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE3, "Address value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => bytes mappings should be correctly stored", done => {
        instance.getBytesFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, BYTES_VALUE2, "Bytes value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => bool mappings should be correctly stored", done => {
        instance.getBoolFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE3, "Bool value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => string mappings should be correctly stored", done => {
        instance.getStringFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE2, "String value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    // Deleting values

    it("Connected contract should be able to delete a value into a mapping (address => uint)", done => {
        instance.deleteUintFromStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a mapping (address => int)", done => {
        instance.deleteIntFromStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a mapping (address => address)", done => {
        instance.deleteAddressFromStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a mapping (address => bytes)", done => {
        instance.deleteBytesFromStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a mapping (address => bool)", done => {
        instance.deleteBoolFromStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a mapping (address => string)", done => {
        instance.deleteStringFromStringMapping(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    // Read zero values

    it("address => uint mappings should be correctly deleted", done => {
        instance.getUintFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => int mappings should be correctly deleted", done => {
        instance.getIntFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Int value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => address mappings should be correctly deleted", done => {
        instance.getAddressFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Address value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => bytes mappings should be correctly deleted", done => {
        instance.getBytesFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, null, "Bytes value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => bool mappings should be correctly deleted", done => {
        instance.getBoolFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, false, "Bool value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => string mappings should be correctly deleted", done => {
        instance.getStringFromStringMapping.call(MODULE1, MAPPING_VARIABLE1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, "", "String value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });


    // Uint double mappings

    it("Connected contract should be able to store a value into a double mapping (bytes32 => mapping (address => uint))", done => {
        instance.setUintInDoubleBytes32AddressMapping(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, UINT_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a double mapping (address => mapping (address => uint))", done => {
        instance.setUintInDoubleAddressAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, ADDRESS_KEY2, UINT_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a double mapping (address => mapping (string => uint))", done => {
        instance.setUintInDoubleAddressStringMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, STRING_KEY1, UINT_VALUE3, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("bytes32 => address => uint mappings should be correctly stored", done => {
        instance.getUintFromDoubleBytes32AddressMapping.call(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE1, "Uint value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => address => uint mappings should be correctly stored", done => {
        instance.getUintFromDoubleAddressAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, ADDRESS_KEY2, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE2, "Uint value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => string => uint mappings should be correctly stored", done => {
        instance.getUintFromDoubleAddressStringMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE3, "Uint value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a double mapping (bytes32 => mapping (address => uint))", done => {
        instance.deleteUintFromDoubleBytes32AddressMapping(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a double mapping (address => mapping (address => uint))", done => {
        instance.deleteUintFromDoubleAddressAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, ADDRESS_KEY2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a double mapping (address => mapping (string => uint))", done => {
        instance.deleteUintFromDoubleAddressStringMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, STRING_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("bytes32 => address => uint mappings should be correctly deleted", done => {
        instance.getUintFromDoubleBytes32AddressMapping.call(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => address => uint mappings should be correctly deleted", done => {
        instance.getUintFromDoubleAddressAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, ADDRESS_KEY2, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => string => uint mappings should be correctly deleted", done => {
        instance.getUintFromDoubleAddressStringMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, STRING_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });

    // Bool double mappings

    it("Connected contract should be able to store a value into a double mapping (bytes32 => mapping (address => bool))", done => {
        instance.setBoolInDoubleBytes32AddressMapping(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, BOOL_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a value into a double mapping (address => mapping (address => bool))", done => {
        instance.setBoolInDoubleAddressAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, ADDRESS_KEY2, BOOL_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("bytes32 => address => bool mappings should be correctly stored", done => {
        instance.getBoolFromDoubleBytes32AddressMapping.call(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE1, "Uint value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => address => bool mappings should be correctly stored", done => {
        instance.getBoolFromDoubleAddressAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, ADDRESS_KEY2, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE2, "Uint value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a different value into a double mapping (bytes32 => mapping (address => bool))", done => {
        instance.setBoolInDoubleBytes32AddressMapping(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, !BOOL_VALUE1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to store a different value into a double mapping (address => mapping (address => bool))", done => {
        instance.setBoolInDoubleAddressAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, ADDRESS_KEY2, !BOOL_VALUE2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("bytes32 => address => bool mappings should be correctly stored", done => {
        instance.getBoolFromDoubleBytes32AddressMapping.call(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, !BOOL_VALUE1, "Uint value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => address => bool mappings should be correctly stored", done => {
        instance.getBoolFromDoubleAddressAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, ADDRESS_KEY2, {from:sendingContract}).then(_value => {
            assert.equal(_value, !BOOL_VALUE2, "Uint value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a double mapping (bytes32 => mapping (address => bool))", done => {
        instance.deleteBoolFromDoubleBytes32AddressMapping(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a double mapping (address => mapping (address => bool))", done => {
        instance.deleteBoolFromDoubleAddressAddressMapping(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, ADDRESS_KEY2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("bytes32 => address => bool mappings should be correctly deleted", done => {
        instance.getBoolFromDoubleBytes32AddressMapping.call(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, {from:sendingContract}).then(_value => {
            assert.equal(_value, false, "Bool value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });

    it("address => address => bool mappings should be correctly deleted", done => {
        instance.getBoolFromDoubleAddressAddressMapping.call(MODULE1, MAPPING_VARIABLE1, ADDRESS_KEY1, ADDRESS_KEY2, {from:sendingContract}).then(_value => {
            assert.equal(_value, false, "Bool value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });

    // Uint tripple mappings

    it("Connected contract should be able to store a value into a triple mapping (bytes32 => mapping (address => mapping (address => uint))", done => {
                instance.setUintInTripleBytes32AddressAddressMapping(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, ADDRESS_KEY2, UINT_VALUE4, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("bytes32 => address => uint mappings should be correctly stored", done => {
        instance.getUintFromTripleBytes32AddressAddressMapping.call(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, ADDRESS_KEY2, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE4, "Uint value not correctly stored in address mapping");
        })
        .then(done).catch(done);
    });

    it("Connected contract should be able to delete a value into a double mapping (bytes32 => mapping (address => uint))", done => {
        instance.deleteUintFromTripleBytes32AddressAddressMapping(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, ADDRESS_KEY2, {from:sendingContract}).then(_result => {
        })
        .then(done).catch(done);
    });

    it("bytes32 => address => uint mappings should be correctly deleted", done => {
        instance.getUintFromTripleBytes32AddressAddressMapping.call(MODULE1, MAPPING_VARIABLE1, BYTES32_KEY1, ADDRESS_KEY1, ADDRESS_KEY2, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint value not correctly deleted in address mapping");
        })
        .then(done).catch(done);
    });

    //
    //
    // Now reading all values to test potential collisions
    //
    //

    it("Uint values should be correctly stored (1)", done => {
        instance.getUint.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE1, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Uint values should be correctly stored (2)", done => {
        instance.getUint.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE2, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Uint values should be correctly stored (3)", done => {
        instance.getUint.call(MODULE2, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE3, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Uint values should be correctly stored (4)", done => {
        instance.getUint.call(MODULE1, SIMPLE_VARIABLE1, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE2, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized uint variables should yield zero", done => {
        instance.getUint.call(MODULE2, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Int values should be correctly stored (1)", done => {
        instance.getInt.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, INT_VALUE1, "Int value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Int values should be correctly stored (2)", done => {
        instance.getInt.call(MODULE2, SIMPLE_VARIABLE2, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, INT_VALUE2, "Int value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized int variables should yield zero", done => {
        instance.getInt.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Int value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Address values should be correctly stored (1)", done => {
        instance.getAddress.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE1, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Address values should be correctly stored (2)", done => {
        instance.getAddress.call(MODULE2, SIMPLE_VARIABLE2, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE2, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized address variables should yield zero", done => {
        instance.getAddress.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, 0, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Byte array values should be correctly stored (1)", done => {
        instance.getBytes.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, BYTES_VALUE1, "Bytes value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Byte array values should be correctly stored (2)", done => {
        instance.getBytes.call(MODULE2, SIMPLE_VARIABLE2, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, BYTES_VALUE2, "Bytes value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized bytes array variables should yield zero", done => {
        instance.getBytes.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, null, "Bytes value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Bool values should be correctly stored (1)", done => {
        instance.getBool.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE1, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Bool values should be correctly stored (2)", done => {
        instance.getBool.call(MODULE2, SIMPLE_VARIABLE2, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE2, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized bool variables should yield false", done => {
        instance.getBool.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, false, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("String values should be correctly stored (1)", done => {
        instance.getString.call(MODULE1, SIMPLE_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE1, "String value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("String values should be correctly stored (2)", done => {
        instance.getString.call(MODULE2, SIMPLE_VARIABLE2, {from:anotherSendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE2, "String value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Non intialized string variables should yield zero", done => {
        instance.getString.call(MODULE1, SIMPLE_VARIABLE2, {from:sendingContract}).then(_value => {
            assert.equal(_value, "", "String value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Number of elements in an uint array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, UINT_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "Uint array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Uint array values should be correctly stored (1)", done => {
        instance.getUintFromArray.call(MODULE1, UINT_ARRAY_VARIABLE1, 0, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE1, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Uint array values should be correctly stored (2)", done => {
        instance.getUintFromArray.call(MODULE1, UINT_ARRAY_VARIABLE1, 1, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE4, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Uint array values should be correctly stored (3)", done => {
        instance.getUintFromArray.call(MODULE1, UINT_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_value => {
            assert.equal(_value, UINT_VALUE2, "Uint value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Number of elements in an address array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, ADDRESS_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "Address array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Address array values should be correctly stored (1)", done => {
        instance.getAddressFromArray.call(MODULE1, ADDRESS_ARRAY_VARIABLE1, 0, {from:sendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE1, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Address array values should be correctly stored (2)", done => {
        instance.getAddressFromArray.call(MODULE1, ADDRESS_ARRAY_VARIABLE1, 1, {from:sendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE4, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Address array values should be correctly stored (3)", done => {
        instance.getAddressFromArray.call(MODULE1, ADDRESS_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_value => {
            assert.equal(_value, ADDRESS_VALUE2, "Address value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Number of elements in an bool array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, BOOL_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "Bool array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("Bool array values should be correctly stored (1)", done => {
        instance.getBoolFromArray.call(MODULE1, BOOL_ARRAY_VARIABLE1, 0, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE1, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Bool array values should be correctly stored (2)", done => {
        instance.getBoolFromArray.call(MODULE1, BOOL_ARRAY_VARIABLE1, 1, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE4, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Bool array values should be correctly stored (3)", done => {
        instance.getBoolFromArray.call(MODULE1, BOOL_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_value => {
            assert.equal(_value, BOOL_VALUE2, "Bool value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("Number of elements in an string array should be correctly reflected", done => {
        instance.getNumberOfElementsInArray.call(MODULE1, STRING_ARRAY_VARIABLE1, {from:sendingContract}).then(_value => {
            assert.equal(_value, 3, "String array does not have the correct number of elements");
        })
        .then(done).catch(done);
    });

    it("String array values should be correctly stored (1)", done => {
        instance.getStringFromArray.call(MODULE1, STRING_ARRAY_VARIABLE1, 0, {from:sendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE1, "String value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("String array values should be correctly stored (2)", done => {
        instance.getStringFromArray.call(MODULE1, STRING_ARRAY_VARIABLE1, 1, {from:sendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE4, "String value not correctly stored");
        })
        .then(done).catch(done);
    });

    it("String array values should be correctly stored (3)", done => {
        instance.getStringFromArray.call(MODULE1, STRING_ARRAY_VARIABLE1, 2, {from:sendingContract}).then(_value => {
            assert.equal(_value, STRING_VALUE2, "String value not correctly stored");
        })
        .then(done).catch(done);
    });

});
