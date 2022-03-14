// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../VRFConsumerV2.sol";
import "./mocks/MockVRFCoordinatorV2.sol";
import "./mocks/LinkToken.sol";
import "./utils/Cheats.sol";
import "ds-test/test.sol";

contract VRFConsumerV2Test is DSTest {
    LinkToken public linkToken;
    MockVRFCoordinatorV2 public vrfCoordinator;
    VRFConsumerV2 public vrfConsumer;
    Cheats internal constant cheats = Cheats(HEVM_ADDRESS);

    uint96 constant FUND_AMOUNT = 1 * 10**18;

    // Initialized as blank, fine for testing
    uint64 subId;
    bytes32 keyHash; // gasLane

    event ReturnedRandomness(uint256[] randomWords);

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

    function test_can_request_randomness() public {
        uint256 startingRequestId = vrfConsumer.s_requestId();
        vrfConsumer.requestRandomWords();
        assertTrue(vrfConsumer.s_requestId() != startingRequestId);
    }

    function test_can_get_random_response() public {
        vrfConsumer.requestRandomWords();
        uint256 requestId = vrfConsumer.s_requestId();

        uint256[] memory words = getWords(requestId);

        vrfCoordinator.fulfillRandomWords(requestId, address(vrfConsumer));
        assertTrue(vrfConsumer.s_randomWords(0) == words[0]);
        assertTrue(vrfConsumer.s_randomWords(1) == words[1]);
    }

    function test_emits_event_on_fulfillment() public {
        vrfConsumer.requestRandomWords();
        uint256 requestId = vrfConsumer.s_requestId();
        uint256[] memory words = getWords(requestId);

        cheats.expectEmit(false, false, false, true);
        emit ReturnedRandomness(words);
        vrfCoordinator.fulfillRandomWords(requestId, address(vrfConsumer));
    }

    function getWords(uint256 requestId)
        public
        view
        returns (uint256[] memory)
    {
        uint256[] memory words = new uint256[](vrfConsumer.s_numWords());
        for (uint256 i = 0; i < vrfConsumer.s_numWords(); i++) {
            words[i] = uint256(keccak256(abi.encode(requestId, i)));
        }
        return words;
    }
}
