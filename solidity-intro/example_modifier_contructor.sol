// Create a new function, increaseX in the contract. 
// The function should take an input parameter of type uint 
// and increase the value of the variable x by the value of the input parameter.
// Make sure that x can only be increased.
// The body of the function increaseX should be empty.

contract functionModifier {
    // We will use these variables to demonstrate how to use
    // modifiers.
    address public owner;
    uint public x = 10;
    bool public locked;

    constructor() {
        // Set the transaction sender as the owner of the contract.
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _;
    }

    modifier biggerThan0(uint y) {
        require(y > 0, "Not bigger than x");
        _;
    }
    
    modifier increaseXbyY(uint y) {
        _;
        x = x + y;
    }

    // increaseX function below first runs the three modifier functions
    // onlyOwner, biggerThan0(y) and increaseXbyY(y)
    function increaseX(uint y) public onlyOwner biggerThan0(y) increaseXbyY(y){
    }
}