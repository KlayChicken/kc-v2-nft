pragma solidity ^0.5.6;

import "./Chickiz.sol";
import "./math/SafeMath.sol";
import "./ownership/Ownable.sol";

contract PublicSale is Ownable {
    using SafeMath for uint256;

    //0x56ee689e3bbbafee554618fd25754eca6950e97e
    Chickiz public nft;

    uint256 public price = 99 * 1e18;
    uint256 public nowNum = 2001;
    uint256 public totalLimit = 8001;
    uint256 public transactionLimit = 10;
    bool public saleState = false;

    constructor(Chickiz _nft) public {
        nft = _nft;
    }

    function nftMint(uint256 _num) external payable {
        uint256 totalNum = nowNum.add(_num);
        uint256 totalPrice = price.mul(_num);
        require(saleState == true);
        require(transactionLimit >= _num);
        require(totalLimit >= totalNum);
        require(msg.value >= totalPrice);

        uint256 from = nowNum;
        uint256 to = from.add(_num);
        for (uint256 i = from; i < to; i += 1) {
            nft.mint(msg.sender, i);
        }

        nowNum = nowNum.add(_num);
    }

    function setSaleState(bool newState) public onlyOwner {
        saleState = newState;
    }

    function setTransactionLimit(uint256 lim) public onlyOwner {
        transactionLimit = lim;
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        msg.sender.transfer(balance);
    }
}
