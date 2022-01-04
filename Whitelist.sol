pragma solidity ^0.5.6;

import "./ownership/Ownable.sol";

contract Whitelist is Ownable {
    mapping(address => bool) public isWhitelist;
    uint256 public totalNum;
    address[] public whitelist;
    bool public whitelistIsActive = true;

    function putIn() external {
        require(whitelistIsActive);
        require(!isWhitelist[msg.sender]);
        isWhitelist[msg.sender] = true;
        totalNum += 1;
        whitelist.push(msg.sender);
    }

    function setWhitelistState(bool newState) public onlyOwner {
        whitelistIsActive = newState;
    }
}
