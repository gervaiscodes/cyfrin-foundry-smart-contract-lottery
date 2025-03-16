# Raffle Lottery Smart Contract

## Overview

This project implements a decentralized raffle lottery system using Solidity and Foundry. The smart contracts facilitate a fair lottery system where participants can enter by paying a fee, and a winner is randomly selected based on Chainlink VRF (Verifiable Random Function).

## Project Structure

- **Contracts:**
  - `Raffle.sol` - The core smart contract handling the lottery mechanism.
  - `LinkToken.sol` - Contract related to Chainlink token interactions.

- **Deployment Scripts:**
  - `DeployRaffle.s.sol` - Deploys the `Raffle.sol` contract.
  - `HelperConfig.s.sol` - Provides helper configurations for deployments.
  - `Interactions.s.sol` - Handles interactions with the deployed contract.

- **Testing:**
  - `RaffleTest.t.sol` - Contains unit tests for the Raffle contract.

- **Configuration & Build:**
  - `foundry.toml` - Configuration for Foundry.
  - `Makefile` - Contains useful commands for building, testing, and deploying the contracts.

## Installation

### Prerequisites

- [Foundry](https://github.com/foundry-rs/foundry) (For compiling, testing, and deploying smart contracts)
- Node.js & npm/yarn (For additional scripting needs)

### Setup

1. Clone the repository:

```sh
git clone <repository-url>
cd <repository-folder>
```

2. Install dependencies:

```sh
forge install
```

3. Build the project:

```sh
forge build
```

## Running Tests

To run the test suite, execute:

```sh
forge test
```

## Deployment

To deploy the contracts using Foundry scripts:

```sh
forge script script/DeployRaffle.s.sol --rpc-url <NETWORK_RPC_URL> --private-key <PRIVATE_KEY> --broadcast
```

## Usage

- Users enter the raffle by sending ETH to the contract.
- Chainlink VRF ensures fair randomness in selecting a winner.
- The winner is rewarded with the total collected ETH after the draw.

## License

This project is licensed under the MIT License.

## Acknowledgements

- Chainlink VRF for secure randomness.
- Foundry for Solidity development tools.
