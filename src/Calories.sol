// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract Calories {
    // create a mapping to store the number of Calories for each Elf
    mapping(uint256 => uint256) public elves;

    // keep track of the current Elf
    uint256 public currentElf;

    // a function to add the Calories to the appropriate Elf's total
    function addCalories(uint256 calories) public {
        // if the calories value is 0, it indicates the start of a new Elf's inventory
        if (calories == 0) {
            currentElf++;
        } else {
            // otherwise, the value represents an item in the Elf's inventory
            elves[currentElf] += calories;
        }
    }

    // a function to find the Elf with the most Calories
    function findMaxElf() public view returns (uint256) {
        uint256 maxCalories = 0;
        uint256 maxElf = 0;
        for (uint256 i = 1; i <= currentElf; i++) {
            if (elves[i] > maxCalories) {
                maxCalories = elves[i];
                maxElf = i;
            }
        }

        return maxElf;
    }

    // a function to get the number of Calories carried by a given Elf
    function getCalories(uint256 elf) public view returns (uint256) {
        return elves[elf];
    }
}
