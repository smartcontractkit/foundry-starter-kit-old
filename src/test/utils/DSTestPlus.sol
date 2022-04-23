// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.11;

import {ERC20} from "@solmate/tokens/ERC20.sol";
import "@std/Test.sol";

contract DSTestPlus is Test {
    function assertERC20Eq(ERC20 erc1, ERC20 erc2) internal {
        assertEq(address(erc1), address(erc2));
    }
}
