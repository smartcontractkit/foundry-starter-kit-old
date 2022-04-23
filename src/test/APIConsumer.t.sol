// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../APIConsumer.sol";
import "./mocks/LinkToken.sol";
import "@std/Test.sol";
import "./mocks/MockOracle.sol";

contract APIConsumerTest is Test {
    APIConsumer public apiConsumer;
    LinkToken public linkToken;
    MockOracle public mockOracle;

    bytes32 public jobId;
    uint256 public fee;
    bytes32 public blankBytes32;

    uint256 public constant AMOUNT = 1 * 10**18;
    uint256 public constant RESPONSE = 777;

    function setUp() public {
        linkToken = new LinkToken();
        mockOracle = new MockOracle(address(linkToken));
        apiConsumer = new APIConsumer(
            address(mockOracle),
            jobId,
            fee,
            address(linkToken)
        );
        linkToken.transfer(address(apiConsumer), AMOUNT);
    }

    function testCanMakeRequest() public {
        bytes32 requestId = apiConsumer.requestVolumeData();
        assertTrue(requestId != blankBytes32);
    }

    function testCanGetResponse() public {
        bytes32 requestId = apiConsumer.requestVolumeData();
        mockOracle.fulfillOracleRequest(requestId, bytes32(RESPONSE));
        assertTrue(apiConsumer.volume() == RESPONSE);
    }
}
