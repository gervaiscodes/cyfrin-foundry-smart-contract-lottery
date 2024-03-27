// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import {VRFConsumerBaseV2} from "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract Raffle is VRFConsumerBaseV2 {
    error Raffle__NotEnoughEthSent();
    error Raffle__TransferFailed();

    uint16 private constant REQUEST_CONFIRMATION = 3;
    uint32 private constant NUM_WORDS = 1;

    uint256 private immutable i_entranceFee;
    uint256 private immutable i_interval;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    uint64 private immutable i_subscriptionId;
    uint32 private immutable i_callbackGasLimit;
    bytes32 private immutable i_gasLane;
    address payable[] private s_players;
    uint256 private s_lastTimestamp;
    address private s_recentWinner;

    event EnteredRaffle(address indexed player);

    constructor(
        uint256 entranceFee,
        uint256 interval,
        address vrfCoordinator,
        bytes32 gasLane,
        uint64 subscriptionId,
        uint32 callbackGasLimit
    ) VRFConsumerBaseV2(vrfCoordinator) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinator);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
        s_lastTimestamp = block.timestamp;
    }

    function enterRaffle() external payable {
        if(msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }

        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() external {
        if(block.timestamp - s_lastTimestamp < i_interval) {
            revert();
        }

        uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATION,
            i_callbackGasLimit,
            NUM_WORDS
        );
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override {
        uint256 indexOfWinner = randomWords[0] % s_players.length;
        address payable winner = s_players[indexOfWinner];
        s_recentWinner = winner;
        (bool success, ) = winner.call{value: address(this).balance}("");
        if(!success) {
            revert Raffle__TransferFailed();
        }
    }

    function getEntranceFee() external view returns(uint256) {
        return i_entranceFee;
    }
}
