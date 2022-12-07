// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Rucksack.sol";
import "../src/BaseTest.sol";

// create a test case for the Rucksack contract
contract TestRucksack is BaseTest {
    Rucksack rucksack;

    function setUp() public {
        // create a new instance of the Rucksack contract
        rucksack = new Rucksack();
    }

    function testRucksack() public {
        uint256 lines = getNumberOfLines("rucksack.txt");
        bytes[] memory rucksacks = new bytes[](lines);
        for (uint256 index = 0; index < lines; index++) {
            string memory contents = vm.readLine("rucksack.txt");
            // console.log('contents:', contents);
            rucksacks[index] = bytes(contents);
        }
        uint256 priority = rucksack.getSumOfPriorities(rucksacks);
        console.log("priority:", priority);
    }

    function testRucksackMany() public {
        uint256 lines = getNumberOfLines("rucksack.txt");
        bytes[] memory rucksacks = new bytes[](lines);
        for (uint256 index = 0; index < lines; index++) {
            string memory contents = vm.readLine("rucksack.txt");
            // console.log('contents:', contents);
            rucksacks[index] = bytes(contents);
        }
        uint256 priority = rucksack.getSumOfPrioritiesMany(rucksacks);
        console.log("priority:", priority);
    }
}
