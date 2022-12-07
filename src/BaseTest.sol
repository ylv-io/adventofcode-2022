// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract BaseTest is Test {
    function getNumberOfLines(string memory file) public view returns (uint256) {
        bytes memory contents = bytes(vm.readFile(file));
        uint256 lines;
        for (uint256 index = 0; index < contents.length; index++) {
            if (contents[index] == 0x0a) {
                lines++;
            }
        }
        return lines;
    }
}
