// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";

// The contract for the Rock Paper Scissors tournament
contract RockPaperScissors {
    // The hand shapes for Rock, Paper, and Scissors
    enum HandShape {
        Rock,
        Paper,
        Scissors
    }

    // The possible outcomes of a round
    enum Outcome {
        Win,
        Loss,
        Draw
    }

    // The total score for the tournament
    uint256 public totalScore;

    // The number of rounds played
    uint256 public rounds;

    // Play a round of the tournament
    function playRoundSecond(HandShape opponentHand, Outcome desiredOutcome)
        public
    {
        // Calculate our hand based on outcome
        HandShape ourHand;
        if (desiredOutcome == Outcome.Win) {
            ourHand = opponentHand == HandShape.Rock
                ? HandShape.Paper
                : (
                    opponentHand == HandShape.Paper
                        ? HandShape.Scissors
                        : HandShape.Rock
                );
        } else if (desiredOutcome == Outcome.Loss) {
            ourHand = opponentHand == HandShape.Rock
                ? HandShape.Scissors
                : (
                    opponentHand == HandShape.Paper
                        ? HandShape.Rock
                        : HandShape.Paper
                );
        } else {
            ourHand = opponentHand;
        }

        // Calculate the score for the selected hand shape
        uint8 handScore;
        if (ourHand == HandShape.Rock) {
            handScore = 1;
        } else if (ourHand == HandShape.Paper) {
            handScore = 2;
        } else {
            handScore = 3;
        }

        // Calculate the score for the round
        uint8 roundScore;
        if (ourHand == opponentHand) {
            // The round is a draw
            roundScore = 3;
        } else if (
            (ourHand == HandShape.Rock && opponentHand == HandShape.Scissors) ||
            (ourHand == HandShape.Paper && opponentHand == HandShape.Rock) ||
            (ourHand == HandShape.Scissors && opponentHand == HandShape.Paper)
        ) {
            // We win the round
            roundScore = 6;
        } else {
            // We lose the round
            roundScore = 0;
        }

        // Add the score for the selected hand shape and the round to the total score
        totalScore += handScore + roundScore;

        // Increment the number of rounds played
        rounds++;
    }

    // Play a round of the tournament
    function playRound(HandShape opponentHand, HandShape ourHand) public {
        // Calculate the score for the selected hand shape
        uint8 handScore;
        if (ourHand == HandShape.Rock) {
            handScore = 1;
        } else if (ourHand == HandShape.Paper) {
            handScore = 2;
        } else {
            handScore = 3;
        }

        // Calculate the score for the round
        uint8 roundScore;
        if (ourHand == opponentHand) {
            // The round is a draw
            roundScore = 3;
        } else if (
            (ourHand == HandShape.Rock && opponentHand == HandShape.Scissors) ||
            (ourHand == HandShape.Paper && opponentHand == HandShape.Rock) ||
            (ourHand == HandShape.Scissors && opponentHand == HandShape.Paper)
        ) {
            // We win the round
            roundScore = 6;
        } else {
            // We lose the round
            roundScore = 0;
        }

        // Add the score for the selected hand shape and the round to the total score
        totalScore += handScore + roundScore;

        // Increment the number of rounds played
        rounds++;
    }
}
