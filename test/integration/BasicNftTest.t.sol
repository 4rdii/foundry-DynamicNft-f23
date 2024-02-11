// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("User");
    string public constant SHIBA_INU =
        "ipfs//QmaEmgZtmYACLZZR5ymDeFhc8vHmYjnXMmCahjE8Vqoqpj";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        // strings are array of bytes so we cant compare them togheter
        // for ( loop through the arry ) and compare them
        // or we can convert them to bytes32(abi.encodePacked(arg);)
        // and then hash(keccak256(arg)) them and then compare hash of them

        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(SHIBA_INU);
        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256((abi.encodePacked(SHIBA_INU))) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
