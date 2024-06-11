// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/Test.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    function svgToImageUri(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:application/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    function run() external returns (MoodNFT) {
        // vm.readFile is a foundry cheatcode to read from file system.
        // It needs permission as specified in .toml file
        string memory sadSvg = vm.readFile("./images/sad.svg");
        string memory happySvg = vm.readFile("./images/happy.svg");
        string memory sadSvgImageUri = svgToImageUri(sadSvg);
        string memory happySvgImageUri = svgToImageUri(happySvg);

        vm.startBroadcast();
        MoodNFT moodNft = new MoodNFT(sadSvgImageUri, happySvgImageUri);
        vm.stopBroadcast();
        return moodNft;
    }
}
