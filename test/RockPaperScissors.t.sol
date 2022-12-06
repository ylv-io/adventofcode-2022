// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/RockPaperScissors.sol";

contract TestRockPaperScissors is Test {
    RockPaperScissors rockPaperScissors;
    uint256 lines;
    error WrongCodeError(bytes1 code);

    function setUp() public {
        // create a new instance of the Calories contract
        rockPaperScissors = new RockPaperScissors();

        bytes memory file = bytes(vm.readFile("strategy.txt"));
        for (uint256 index = 0; index < file.length; index++) {
            if (file[index] == 0x0a) {
                lines++;
            }
        }
        console.log("lines:", lines);
    }

    // convert unicode letter A or X for HandShape.Rock
    // convert unicode letter B or Y for HandShape.Paper
    // convert unicode letter C or Z for HandShape.Scissors
    function bytesToHandShape(bytes1 from)
        public
        pure
        returns (RockPaperScissors.HandShape)
    {
        if (from == 0x41 || from == 0x58) {
            return RockPaperScissors.HandShape.Rock;
        } else if (from == 0x42 || from == 0x59) {
            return RockPaperScissors.HandShape.Paper;
        } else if (from == 0x43 || from == 0x5a) {
            return RockPaperScissors.HandShape.Scissors;
        }
        revert WrongCodeError(from);
    }

    // convert unicode letter X for Outcome.Loss
    // convert unicode letter Y for Outcome.Draw
    // convert unicode letter Z for Outcome.Win
    function bytesToOutcome(bytes1 from)
        public
        pure
        returns (RockPaperScissors.Outcome)
    {
        if (from == 0x58) {
            return RockPaperScissors.Outcome.Loss;
        } else if (from == 0x59) {
            return RockPaperScissors.Outcome.Draw;
        } else if (from == 0x5a) {
            return RockPaperScissors.Outcome.Win;
        }
        revert WrongCodeError(from);
    }

    function testTotalScore() public {
        for (uint256 index = 0; index < lines; index++) {
            string memory line = vm.readLine("strategy.txt");
            bytes memory letters = bytes(line);
            // console.log(line);
            rockPaperScissors.playRound(
                bytesToHandShape(letters[0]),
                bytesToHandShape(letters[2])
            );
        }
        console.log("totalScore:", rockPaperScissors.totalScore());
    }

    function testTotalScoreSecond() public {
        for (uint256 index = 0; index < lines; index++) {
            string memory line = vm.readLine("strategy.txt");
            bytes memory letters = bytes(line);
            // console.log(line);
            rockPaperScissors.playRoundSecond(
                bytesToHandShape(letters[0]),
                bytesToOutcome(letters[2])
            );
        }
        console.log("totalScore:", rockPaperScissors.totalScore());
    }
}
