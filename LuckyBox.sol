pragma solidity ^0.5.6;

import "./token/KIP17/IKIP17.sol";
import "./ownership/Ownable.sol";

contract LuckyBox is Ownable {
    IKIP17 public KCV2;

    function() external payable {}

    function setNFT(IKIP17 adr) external onlyOwner {
        KCV2 = adr;
    }

    function withdraw() public {
        require(KCV2.balanceOf(msg.sender) > 1);
        uint256 balance = address(this).balance;
        msg.sender.transfer(balance);
    }
}
