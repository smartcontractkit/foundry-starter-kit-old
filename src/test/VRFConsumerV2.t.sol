// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../VRFConsumerV2.sol";
import "./mocks/MockVRFCoordinatorV2.sol";
import "./mocks/LinkToken.sol";
import "./utils/Cheats.sol";
import "@std/Test.sol";

contract VRFConsumerV2Test is Test {
    LinkToken public linkToken;
    MockVRFCoordinatorV2 public vrfCoordinator;
    VRFConsumerV2 public vrfConsumer;
    Cheats internal constant cheats = Cheats(HEVM_ADDRESS);

    uint96 public constant FUND_AMOUNT = 1 * 10**18;

    // Initialized as blank, fine for testing
    uint64 public subId;
    bytes32 public keyHash; // gasLane

    event ReturnedRandomness(uint256 requestId, uint256[] randomWords);

    function setUp() public {
        linkToken = new LinkToken();
        vrfCoordinator = new MockVRFCoordinatorV2();
        subId = vrfCoordinator.createSubscription();
        vrfCoordinator.fundSubscription(subId, FUND_AMOUNT);
        vrfConsumer = new VRFConsumerV2(
            subId,
            address(vrfCoordinator),
            address(linkToken),
            keyHash
        );
    }

    function testCanRequestRandomness() public {
        uint256 startingRequestId = vrfConsumer.requestId();
        vrfConsumer.requestRandomWords();
        assertTrue(vrfConsumer.requestId() != startingRequestId);
    }

    function testCanGetRandomResponse() public {
        vrfConsumer.requestRandomWords();
        uint256 requestId = vrfConsumer.requestId();

        uint256[] memory words = getWords(requestId);

        vrfCoordinator.fulfillRandomWords(requestId, address(vrfConsumer));
        assertTrue(vrfConsumer.randomWords(0) == words[0]);
        assertTrue(vrfConsumer.randomWords(1) == words[1]);
    }

    function testEmitsEventOnFulfillment() public {
        vrfConsumer.requestRandomWords();
        uint256 requestId = vrfConsumer.requestId();
        uint256[] memory words = getWords(requestId);

        cheats.expectEmit(false, false, false, true);
        emit ReturnedRandomness(requestId, words);
        vrfCoordinator.fulfillRandomWords(requestId, address(vrfConsumer));
    }

    function getWords(uint256 requestId)
        public
        view
        returns (uint256[] memory)
    {
        uint256[] memory words = new uint256[](vrfConsumer.numWords());
        for (uint256 i = 0; i < vrfConsumer.numWords(); i++) {
            words[i] = uint256(keccak256(abi.encode(requestId, i)));
        }
        return words;
    }
}
