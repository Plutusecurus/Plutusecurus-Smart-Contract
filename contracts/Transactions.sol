// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Transactions {

    struct Transaction {
        string transactionId;
        string dateTime;
        address sender;
        address recipient;
        uint amount;
    }

    mapping(string=>Transaction) private transactionById;
    Transaction[] private allTransactions;
    uint private balance;

    constructor() {
        balance = 0;
    }

    function depositETH(
        string memory _transactionId,
        string memory _dateTime
    ) external payable {
        require(msg.value >= 10000, "Minimum transaction should be 10,000 wei to proceed.");

        transactionById[_transactionId] = Transaction(_transactionId, _dateTime, msg.sender, address(this), msg.value);
        allTransactions.push(transactionById[_transactionId]);
    }

    function transactionETHtoETH(
        address _recipient,
        string memory _transactionId,
        string memory _dateTime
    ) external payable {
        require(msg.value >= 10000, "Minimum transaction should be 10,000 wei to proceed.");

        payable (_recipient).transfer(msg.value);

        transactionById[_transactionId] = Transaction(_transactionId, _dateTime, msg.sender, _recipient, msg.value);
        allTransactions.push(transactionById[_transactionId]);
    }

    function transferETH(
        address _recipient,
        uint256 _amount,
        string memory _transactionId,
        string memory _dateTime
    ) external {
        require(_amount >= 10000, "Minimum transaction should be 10,000 wei to proceed.");

        payable (_recipient).transfer(_amount);

        transactionById[_transactionId] = Transaction(_transactionId, _dateTime, msg.sender, _recipient, _amount);
        allTransactions.push(transactionById[_transactionId]);
    }

    function getTransactionById(string memory _transactionId) external view returns (Transaction memory) {
        return transactionById[_transactionId];
    }
}
