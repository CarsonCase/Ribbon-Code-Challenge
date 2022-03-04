// // SPDX-License-Identifier: MIT
// pragma solidity =0.8.4;

// import "./interfaces/IController.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import {Actions} from  "./interfaces/IController.sol";

// /// @dev interface represents functions actually called in the Ribbon contracts
// contract GammaController is IController{
//     IERC20 otoken;
//     mapping(address => uint256) internal accountVaultCounter;
    
//     /// @dev mapping to map vault by each vault type, naked margin vault should be set to 1, spread/max loss vault should be set to 0
//     mapping(address => mapping(uint256 => uint256)) internal vaultType;


//     constructor(IERC20 _oToken){
//         otoken = _oToken;
//     }

//     function getAccountVaultCounter() external override{

//     }

//     function operate() external override{

//     }

//     function getVault() external override{

//     }

//     /**
//      * @notice execute a variety of actions
//      * @dev for each action in the action array, execute the corresponding action, only one vault can be modified
//      * for all actions except SettleVault, Redeem, and Call
//      * @param _actions array of type Actions.ActionArgs[], which expresses which actions the user wants to execute
//      * @return vaultUpdated, indicates if a vault has changed
//      * @return owner, the vault owner if a vault has changed
//      * @return vaultId, the vault Id if a vault has changed
//      */
//     function _runActions(Actions.ActionArgs[] memory _actions)
//         internal
//         returns (
//             bool,
//             address,
//             uint256
//         )
//     {
//         address vaultOwner;
//         uint256 vaultId;
//         bool vaultUpdated;

//         for (uint256 i = 0; i < _actions.length; i++) {
//             Actions.ActionArgs memory action = _actions[i];
//             Actions.ActionType actionType = action.actionType;

//             // actions except Settle, Redeem, Liquidate and Call are "Vault-updating actinos"
//             // only allow update 1 vault in each operate call
//             if (
//                 (actionType != Actions.ActionType.SettleVault) &&
//                 (actionType != Actions.ActionType.Redeem) &&
//                 (actionType != Actions.ActionType.Liquidate) &&
//                 (actionType != Actions.ActionType.Call)
//             ) {
//                 // check if this action is manipulating the same vault as all other actions, if a vault has already been updated
//                 if (vaultUpdated) {
//                     require(vaultOwner == action.owner, "C12");
//                     require(vaultId == action.vaultId, "C13");
//                 }
//                 vaultUpdated = true;
//                 vaultId = action.vaultId;
//                 vaultOwner = action.owner;
//             }

//             if (actionType == Actions.ActionType.OpenVault) {
//                 _openVault(_actions[i].owner, _actions[i].vaultId);
//             } else if (actionType == Actions.ActionType.DepositCollateral) {
//                 // _depositCollateral(Actions._parseDepositArgs(action));
//             } else if (actionType == Actions.ActionType.MintShortOption) {
//                 _mintOtoken(_actions[i].secondAddress, _actions[i].amount);
//             }
//         }

//         return (vaultUpdated, vaultOwner, vaultId);
//     }

//     function _openVault(address _owner, uint _id)
//         internal
//     {
//         uint256 vaultId = accountVaultCounter[_owner] + (1);

//         require(_id == vaultId, "C15");

//         // store new vault
//         accountVaultCounter[_owner] = vaultId;
//         vaultType[_owner][_id] = 0; //hardcoded to 0 since Ribbon doesn't do max loss vaults

//     }

//     function _mintOtoken(address _to, uint _amount)
//             internal
//         {
//             otoken.mintOtoken(_to, _amount);
//         }
// }