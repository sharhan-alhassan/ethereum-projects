// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract ReceiveEther {
    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}

// Build a charity contract that receives Ether that can be withdrawn by a beneficiary.
// Create a contract called Charity.
// Add a public state variable called owner of the type address.
// Create a donate function that is public and payable without any parameters or function code.
// Create a withdraw function that is public and sends the total balance of the contract to the owner address.

contract Charity {
    // owner: This variable stores the address of the account that deployed the contract. 
    //It is publicly accessible, meaning anyone can view it.
    address public owner;

    // The constructor() function is executed only once, at the time of contract deployment. 
    // It initializes the owner variable with the address of the account that deployed the contract (msg.sender).
    constructor() {
        owner = msg.sender;
    }

    // This function allows anyone to send Ether to the contract. It's declared as public payable, 
    // which means it can be called from outside the contract, and it can receive Ether along with the function call.
    function donate() public payable {}

    function withdraw() public {
        // It first retrieves the current balance of the contract using address(this).balance 
        // and stores it in the amount variable.
        uint amount = address(this).balance;

        // Then, it attempts to send the entire balance (amount) to the owner address using the call function. 
        // The {value: amount} specifies the amount of Ether to send.
        // The bool sent variable captures whether the transaction was successful or not, 
        // and the bytes memory data variable captures any data returned by the recipient of the transaction.
        (bool sent, bytes memory data) = owner.call{value: amount}("");

        // The require(sent, "Ether not sent!") statement ensures that the Ether transfer was successful. If the transfer fails, 
        // it reverts the transaction with the error message "Ether not sent!".
        require(sent, "Ether not sent!");
    }
}