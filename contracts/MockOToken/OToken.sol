// // SPDX-License-Identifier: MIT
// pragma solidity =0.8.4;

// import "./interfaces/IOtoken.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// contract OToken is IOtoken, ERC20{
//     address controller;
//     /// @notice strike price with decimals = 8
//     uint256 public override strikePrice;

//     /// @notice expiration timestamp of the option, represented as a unix timestamp
//     uint256 public override expiryTimestamp;

//     /// @notice True if a put option, False if a call option
//     bool public override isPut;

//     constructor(address _controller, uint256 _strikePrice, uint256 _expiry, bool _isPut)
//     ERC20("Test OToken","TOT"){
//         controller = _controller;
//         strikePrice = _strikePrice;
//         expiryTimestamp = _expiry;
//         isPut = _isPut;
//     }

//     /**
//      * @notice mint oToken for an account
//      * @dev Controller only method where access control is taken care of by _beforeTokenTransfer hook
//      * @param account account to mint token to
//      * @param amount amount to mint
//      */
//     function mintOtoken(address account, uint256 amount) external {
//         require(msg.sender == controller, "Otoken: Only Controller can mint Otokens");
//         _mint(account, amount);
//     }
// }
