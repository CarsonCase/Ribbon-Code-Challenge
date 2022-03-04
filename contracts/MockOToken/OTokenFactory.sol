// // SPDX-License-Identifier: MIT
// pragma solidity =0.8.4;

// import "./interfaces/IOtokenFactory.sol";
// import "./OToken.sol";

// /// @dev interface represents functions called in Ribbon
// contract OTokenFactory is IOtokenFactory{

//     address controller;

//     /// @dev max expiry that BokkyPooBahsDateTimeLibrary can handle. (2345/12/31)
//     uint256 private constant MAX_EXPIRY = 11865398400;
//     mapping(bytes32 => address) private idToAddress;
//     address[] public otokens;

//     constructor(address _controller){
//         controller = _controller;
//     }
//     function getOToken(
//         address _underlyingAsset,
//         address _strikeAsset,
//         address _collateralAsset,
//         uint256 _strikePrice,
//         uint256 _expiry,
//         bool _isPut
//         ) external override{
//         bytes32 id = _getOptionId(_underlyingAsset, _strikeAsset, _collateralAsset, _strikePrice, _expiry, _isPut);
//         return idToAddress[id];
//     }
//  /**
//      * @notice create new oTokens
//      * @dev deploy an eip-1167 minimal proxy with CREATE2 and register it to the whitelist module
//      * @param _underlyingAsset asset that the option references
//      * @param _strikeAsset asset that the strike price is denominated in
//      * @param _collateralAsset asset that is held as collateral against short/written options
//      * @param _strikePrice strike price with decimals = 18
//      * @param _expiry expiration timestamp as a unix timestamp
//      * @param _isPut True if a put option, False if a call option
//      * @return newOtoken address of the newly created option
//      */
//     function createOtoken(
//         address _underlyingAsset,
//         address _strikeAsset,
//         address _collateralAsset,
//         uint256 _strikePrice,
//         uint256 _expiry,
//         bool _isPut
//     ) external override returns (address) {
//         require(_expiry > now, "OtokenFactory: Can't create expired option");
//         require(_expiry < MAX_EXPIRY, "OtokenFactory: Can't create option with expiry > 2345/12/31");

//         bytes32 id = _getOptionId(_underlyingAsset, _strikeAsset, _collateralAsset, _strikePrice, _expiry, _isPut);
//         require(idToAddress[id] == address(0), "OtokenFactory: Option already created");

//         require(!_isPut || _strikePrice > 0, "OtokenFactory: Can't create a $0 strike put option");

//         address otokenImpl = AddressBookInterface(addressBook).getOtokenImpl();

//         bytes memory initializationCalldata = abi.encodeWithSelector(
//             OtokenInterface(otokenImpl).init.selector,
//             addressBook,
//             _underlyingAsset,
//             _strikeAsset,
//             _collateralAsset,
//             _strikePrice,
//             _expiry,
//             _isPut
//         );

//         address newOtoken = new OToken(
//             controller,
//             _strikePrice,
//             _expiry,
//             _isPut
//         );

//         idToAddress[id] = newOtoken;
//         otokens.push(newOtoken);

//         return newOtoken;
//     }

//     /**
//      * @dev hash oToken parameters and return a unique option id
//      * @param _underlyingAsset asset that the option references
//      * @param _strikeAsset asset that the strike price is denominated in
//      * @param _collateralAsset asset that is held as collateral against short/written options
//      * @param _strikePrice strike price with decimals = 18
//      * @param _expiry expiration timestamp as a unix timestamp
//      * @param _isPut True if a put option, False if a call option
//      * @return id the unique id of an oToken
//      */
//     function _getOptionId(
//         address _underlyingAsset,
//         address _strikeAsset,
//         address _collateralAsset,
//         uint256 _strikePrice,
//         uint256 _expiry,
//         bool _isPut
//     ) internal pure returns (bytes32) {
//         return
//             keccak256(
//                 abi.encodePacked(_underlyingAsset, _strikeAsset, _collateralAsset, _strikePrice, _expiry, _isPut)
//             );
//     }
// }