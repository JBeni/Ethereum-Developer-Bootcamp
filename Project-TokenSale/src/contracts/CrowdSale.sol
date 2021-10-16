// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "../../node_modules/@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "../../node_modules/@openzeppelin/contracts/utils/Context.sol";
import "../../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../../node_modules/@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract CrowdSale {
    using SafeMath for uint;

    function _preValidatePurchase(address beneficiary, uint256 weiAmount) internal view virtual {
        require(beneficiary != address(0), "CrowdSale: beneficiary is the zero address");
        require(weiAmount != 0, "CrowdSale: weiAmount is 0");
        this;// silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
    }

    function _postValidatePurchase(address beneficiary, uint256 weiAmount) internal view virtual {
        // solhint-disable-previous-line no-empty-blocks
    }

    function _deliverTokens(address beneficiary, uint256 tokenAmount) internal virtual {
        //_token.safeTransfer(beneficiary, tokenAmount);
    }

    function _processPurchase(address beneficiary, uint256 tokenAmount) internal virtual {
        _deliverTokens(beneficiary, tokenAmount);
    }

    function _updatePurchasingState(address beneficiary, uint256 weiAmount) internal virtual {
        // solhint-disable-previous-line no-empty-blocks
    }

    function _getTokenAmount(uint256 weiAmount) internal view virtual returns (uint256) {
        //return weiAmount.mul(_rate);
    }

    receive() external payable {
        //buyTokens(_msgSender());
    }

}
