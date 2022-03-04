// SPDX-License-Identifier: MIT
pragma solidity =0.8.4;

interface IOtoken{
    function isPut() external returns(bool);

    function strikePrice() external returns(uint256);

    function expiryTimestamp() external view returns (uint256);
    
    function collateralAsset() external view returns (address);
}
