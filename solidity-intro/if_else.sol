// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract IfElse {
    function foo(uint x) public pure returns (uint) {
        if (x < 10) {
            return 0;
        } else if (x < 20) {
            return 1;
        } else {
            return 2;
        }
    }

    function ternary(uint _x) public pure returns (uint) {
        // if (_x < 10) {
        //     return 1;
        // }
        // return 2;

        // shorthand way to write if / else statement
        return _x < 10 ? 1 : 2;
    }

    // New function
    function evenCheck(uint _y) public pure returns (bool) {
        // shorthand
        return _y % 2 == 0 ? true: false;

        // Long hand
        // if (_y % 2 == 0) {
        //     return true;
        // } else {
        //     return false;
        // }
    }
}