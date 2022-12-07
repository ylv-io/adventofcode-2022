// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract Rucksack {
    bytes result;

    // The `getPriority` function converts each item to its priority. Lowercase items have
    // priorities 1 through 26, and uppercase items have priorities 27 through 52.
    function getPriority(bytes1 item) public pure returns (uint256) {
        uint256 asciiCode = uint256(uint8(item));
        if (asciiCode >= 97) {
            // The item is lowercase.
            return asciiCode - 96;
        } else {
            // The item is uppercase.
            return asciiCode - 38;
        }
    }

    // The `intersection` function takes two arrays and returns the intersection of those
    // arrays, i.e. the items that appear in both arrays.
    function intersection(bytes1[] memory a, bytes1[] memory b)
        public
        returns (bytes memory)
    {
        delete result;
        for (uint256 i = 0; i < a.length; i++) {
            for (uint256 j = 0; j < b.length; j++) {
                if (a[i] == b[j]) {
                    result.push(bytes1(a[i]));
                }
            }
        }
        return result;
    }

    // The `getCommonItems` function takes a rucksack's contents as input, splits the
    // rucksack's contents into two compartments, and returns the items that appear in
    // both compartments.
    function getCommonItems(bytes memory rucksack)
        public
        returns (bytes memory)
    {
        uint256 n = rucksack.length / 2;
        bytes1[] memory compartment1 = new bytes1[](n);
        bytes1[] memory compartment2 = new bytes1[](n);
        for (uint256 i = 0; i < n; i++) {
            compartment1[i] = bytes1(rucksack[i]);
        }
        for (uint256 i = 0; i < n; i++) {
            compartment2[i] = bytes1(rucksack[n + i]);
        }
        return intersection(compartment1, compartment2);
    }

    // The `getSumOfPriorities` function takes a list of rucksacks as input, finds the
    // items that appear in both compartments of each rucksack, converts each item to
    // its priority, and returns the sum of those priorities.
    function getSumOfPriorities(bytes[] memory rucksacks)
        public
        returns (uint256)
    {
        uint256 sum = 0;
        for (uint256 i = 0; i < rucksacks.length; i++) {
            console.logBytes(rucksacks[i]);
            bytes memory commonItems = getCommonItems(rucksacks[i]);
            console.logBytes(commonItems);
            sum += getPriority(commonItems[0]);
        }
        return sum;
    }

    function convertBytesToArray(bytes memory input)
        public
        pure
        returns (bytes1[] memory)
    {
        bytes1[] memory ret = new bytes1[](input.length);
        for (uint256 i = 0; i < input.length; i++) {
            ret[i] = bytes1(input[i]);
        }
        return ret;
    }

    function getSumOfPrioritiesMany(bytes[] memory rucksacks)
        public
        returns (uint256)
    {
        uint256 sum = 0;
        for (uint256 i = 0; i < rucksacks.length; i += 3) {
            console.log("rucksacks");
            console.logBytes(rucksacks[i]);
            console.logBytes(rucksacks[i + 1]);
            console.logBytes(rucksacks[i + 2]);
            bytes memory commonItems12 = intersection(
                convertBytesToArray(rucksacks[i]),
                convertBytesToArray(rucksacks[i + 1])
            );
            bytes memory commonItems23 = intersection(
                convertBytesToArray(rucksacks[i + 1]),
                convertBytesToArray(rucksacks[i + 2])
            );
            bytes memory commonItems13 = intersection(
                convertBytesToArray(rucksacks[i]),
                convertBytesToArray(rucksacks[i + 2])
            );
            bytes memory commonItems1223= intersection(
                convertBytesToArray(commonItems12),
                convertBytesToArray(commonItems23)
            );
            bytes memory commonItems2313 = intersection(
                convertBytesToArray(commonItems23),
                convertBytesToArray(commonItems13)
            );
            bytes memory commonItems = intersection(
                convertBytesToArray(commonItems1223),
                convertBytesToArray(commonItems2313)
            );
            console.log("common");
            console.logBytes(commonItems);

            sum += getPriority(commonItems[0]);
        }
        return sum;
    }
}
