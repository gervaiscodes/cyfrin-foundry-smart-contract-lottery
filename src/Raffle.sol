// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Raffle {
    error Raffle__NotEnoughEthSent();

    uint256 private i_entranceFee;
    address payable[] private s_players;

    event EnteredRaffle(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() external payable {
        if(msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }

        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() public {

    }

    function getEntranceFee() external view returns(uint256) {
        return i_entranceFee;
    }
}
