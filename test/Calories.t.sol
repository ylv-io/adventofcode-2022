// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Calories.sol";

// create a test case for the Calories contract
contract TestCalories is Test {
    function stringToUint(string memory s) public pure returns (uint256) {
        bytes memory b = bytes(s);
        uint256 result = 0;
        for (uint256 i = 0; i < b.length; i++) {
            uint256 c = uint256(uint8(b[i]));
            if (c >= 48 && c <= 57) {
                result = result * 10 + (c - 48);
            }
        }
        return result;
    }

    // a test to check that the contract can parse an input array of calories
    function testShouldParseInputArray() public {
        // create an instance of the contract
        Calories calories = new Calories();

        bytes memory file = bytes(vm.readFile("calories.txt"));
        uint256 lines;
        for (uint256 index = 0; index < file.length; index++) {
            if (file[index] == 0x0a) {
                lines++;
            }
        }
        console.log("lines:", lines);

        uint256[] memory arr = new uint256[](lines);
        for (uint256 index = 0; index < lines; index++) {
            arr[index] = stringToUint(vm.readLine("calories.txt"));
            console.log("num:", arr[index]);
        }

        // iterate through the array and add the calories to the contract
        for (uint256 i = 0; i < arr.length; i++) {
            calories.addCalories(arr[i]);
        }

        // get the elf with the most calories and check that it is correct
        uint256 maxElf = calories.findMaxElf();
        console.log("maxElf:", maxElf);
        // get the amount of calories maxElf has
        uint256 maxCalories = calories.getCalories(maxElf);
        console.log("maxCalories:", maxCalories);
    }
}
