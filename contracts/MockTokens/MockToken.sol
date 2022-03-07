// SPDX-License-Identifier: MIT
pragma solidity =0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockToken is ERC20{
    constructor () ERC20("MOCK","Mock Token"){
        _mint(msg.sender, 100 ether);
    }

    function mint(address a, uint x) external{
        _mint(a, x);
    }

    function burn(address a, uint x) external{
        _burn(a, x);
    }

}