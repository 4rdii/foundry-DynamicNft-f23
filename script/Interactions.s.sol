// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant SHIBA_INU =
        "ipfs://QmaEmgZtmYACLZZR5ymDeFhc8vHmYjnXMmCahjE8Vqoqpj?filename=shibainu.json";

    function run() external {
        // address mostRecentDeployed = DevOpsTools.get_most_recent_deployment(
        //     "BasicNft",
        //     block.chainid
        // );
        address mostRecentDeployed = 0x42cb140d38872fBd466e576317BE967CbaFDdDA4;
        mintNftOnContract(mostRecentDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(SHIBA_INU);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        // address mostRecentlyDeployedBasicNft = DevOpsTools
        //     .get_most_recent_deployment("MoodNft", block.chainid);
        address mostRecentlyDeployedBasicNft = 0x5FbDB2315678afecb367f032d93F642f64180aa3;

        mintNftOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodNft(mostRecentlyDeployedBasicNft);
    }

    function flipMoodNft(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
