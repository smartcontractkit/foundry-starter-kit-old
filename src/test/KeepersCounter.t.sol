// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../KeepersCounter.sol";
import "ds-test/test.sol";
import "./utils/Cheats.sol";

contract KeepersCounterTest is DSTest {
    KeepersCounter public counter;
    uint256 public staticTime;
    uint256 public INTERVAL;
    Cheats internal constant cheats = Cheats(HEVM_ADDRESS);

    function setUp() public {
        staticTime = block.timestamp;
        counter = new KeepersCounter(INTERVAL);
        cheats.warp(staticTime);
    }

    function test_checkup_returns_false_before_time() public {
        (bool upkeepNeeded, ) = counter.checkUpkeep("0x");
        assertTrue(!upkeepNeeded);
    }

    function test_checkup_returns_true_after_time() public {
        cheats.warp(staticTime + INTERVAL + 1); // Needs to be more than the interval
        (bool upkeepNeeded, ) = counter.checkUpkeep("0x");
        assertTrue(upkeepNeeded);
    }

    function test_performUpkeep_updates_time() public {
        // Arrange
        uint256 currentCounter = counter.counter();
        cheats.warp(staticTime + INTERVAL + 1); // Needs to be more than the interval

        // Act
        counter.performUpkeep("0x");

        // Assert
        assertTrue(counter.lastTimeStamp() == block.timestamp);
        assertTrue(currentCounter + 1 == counter.counter());
    }

    function test_fuzzing_example(bytes memory variant) public {
        // We expect this to fail, no matter how different the input is!
        cheats.expectRevert(bytes("Time interval not met"));
        counter.performUpkeep(variant);
    }
}
