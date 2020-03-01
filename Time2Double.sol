pragma solidity ^0.4.22;

contract TimeToDouble {

    uint constant MIN_BET = 0.01 ether;
    uint constant MAX_AMOUNT = 100 ether;
    address public owner;
    uint betAmount;

    event BetResult(
       uint result,  // 0 is lose, 1 is win
       uint amount,  // The money user win
       uint flag     // 0 is fail, 1 is success
    );

    constructor () public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require (msg.sender == owner, "OnlyOwner methods called by non-owner.");
        _;
    }

    function kill() external onlyOwner {
        selfdestruct(owner);
    }

    function placeBet(uint userInput) external payable{
        betAmount = msg.value;

        require(betAmount > MIN_BET, "Bet should bigger than 0.01 ETH");
        require(betAmount < MAX_AMOUNT, "Bet should smaller than 100 ETH");

        uint random = getRandom();
        if (userInput == random) {
            refund(msg.sender, uint(betAmount*195/100), random);
        } else {
            emit BetResult(0, 0, random);
        }
    }

    function getRandom() private view returns (uint) {
       return uint(uint256(keccak256(block.timestamp, block.difficulty))%2);
    }

    function refund(address beneficiary, uint amount, uint result) private {
        if (beneficiary.send(amount)) {
            emit BetResult(result, amount, 1);
        } else {
            emit BetResult(result, amount, 0);
        }
    }

    function getOwnerBalance() constant public returns (uint256){
        return address(this).balance;
    }

}
