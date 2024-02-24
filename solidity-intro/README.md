

## [Tutorial-Link] (https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.24+commit.e11b9ed9.js)

- Visibility of a variable refers to whether a variable can be accesse inside and/or outside of a contract

- A contract in solity starts with the keyworkd `contract`. Example below

```sh
contract HelloWorld {
    # meaning, great variable is public and can accessed outside of the contract
    string public greet = "Hello World!";
}
```

## Primitives
- uint
```sh
- - refer to solidity-intro/primitives.sol for more examples

We use the keywords int and int8 to int256 to declare an integer type. Integers can be positive, negative, or zero and range from 8 bits to 256 bits. The type int is the same as int256.
```

- address
```sh
- refer to solidity-intro/primitives.sol for more examples

Variables of the type address hold a 20-byte value, which is the size of an Ethereum address. There is also a special kind of Ethereum address, address payable, which can receive ether from the contract.
```

## Variables
- There are three different types of variables in Solidity: `State Variables`, `Local Variables`, and `Global Variables`.

```sh
1. State Variables
State Variables are stored in the contract storage and thereby on the blockchain. They are declared inside the contract but outside the function. This contract has two state variables, the string text(line 6) and the uint num (line 7).

2. Local Variables
Local Variables are stored in the memory and their values are only accessible within the function they are defined in. Local Variables are not stored on the blockchain. In this contract, the uint i (line 11) is a local variable.

3. Global Variables
Global Variables, also called Special Variables, exist in the global namespace. They don't need to be declared but can be accessed from within your contract. Global Variables are used to retrieve information about the blockchain, particular addresses, contracts, and transactions.

In this example, we use block.timestamp (line 14) to get a Unix timestamp of when the current block was generated and msg.sender (line 15) to get the caller of the contract function’s address.

```

## Functions

- This section will give a short introduction to functions and teach you how to use them to read from and write to a state variable.

- As in other languages, we use functions in Solidity to create modular, reusable code. However, Solidity functions have some particularities.

Solidity functions can be split into two types:

```sh
Functions that modify the state of the blockchain, like writing to a state variable. In this contract, the set function (line 9) changes the state variable num.
Functions that don't modify the state of the blockchain. These functions are marked view or pure. For example, in this contract, the get function (line 14) marked view that only returns num does not change the state.
```

- `View functions`: The function reads the `state variable` but does not modify it

- `Pure functions`: The funxtion promise to neither modify nor to read the `state`.

```sh
# Example
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract ViewAndPure {
    uint public x = 1;

    // Promise not to modify the state.
    function addToX(uint y) public view returns (uint) {
        return x + y;
    }

    // Promise not to modify or read from the state.
    function add(uint i, uint j) public pure returns (uint) {
        return i + j;
    }
}
```

## Funxtions - Modifiers and Constructors
- `Function Modifiers`: are used to change the behavior of a function. For example, they often check for a condition prior to executing a function to restrict access or validate inputs.

- Basically, before a function runs you can supply it a couple of `modifier functions` to first run before the actual function itself runs

- They are a powerful feature that allows you to enforce certain rules or constraints before executing the function

- In the below, the function `changeOwner` first calls the two modifiers `onlyOwner` and `validAddress` -- which even take a parameeter

- At the `changeOwner` you can find the two modifier functions

```sh
    // Modifier to check that the caller is the owner of
    // the contract.
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _;
    }

    // Modifiers can take inputs. This modifier checks that the
    // address passed in is not the zero address.
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }
```

- `Function Constructors`: A constructor function is executed upon the creation of a contract. You can use it to run contract initialization code.

- Example below, the `constructor` first set the `owner` to be the owner of the contract

```sh
constructor() {
        // Set the transaction sender as the owner of the contract.
        owner = msg.sender;
    }
```

## Functions - Inputs and Outputs
- Multiple named Outputs
Functions can return multiple values that can be named and assigned to their name.

- The `returnMany` function (line 6) shows how to return multiple values. You will often return multiple values. It could be a function that collects outputs of various functions and returns them in a single function call for example.

- The `named` function (line 19) shows how to name return values. Naming return values helps with the readability of your contracts. Named return values make it easier to keep track of the values and the order in which they are returned. You can also assign values to a name.

- The `assigned` function (line 33) shows how to assign values to a name. When you assign values to a name you can omit (leave out) the return statement and return them individually.

## Visibility

- The `visibility` specifier is used to control who has access to functions and state variables.

- There are four types of visibilities: `external`, `public`, `internal`, and `-`.

- They regulate if functions and state variables can be called `from inside the contract`, from `contracts that derive from the contract (child contracts)`, or from `other contracts and transactions`.

- `private`: Can be called from inside the contract

- `internal`: 
* Can be called from inside the contract
* Can be called from a child contract

- `public`:
* Can be called from inside the contract
* Can be called from a child contract
* Can be called from other contracts or transactions

- `external`:
* Can be called from other contracts or transactions
* State variables can not be external


## Data Structures - Mappings
- In Solidity, `mappings` are a collection of key types and corresponding value type pairs.

- `Mappings` are declared with the syntax `mapping(KeyType => ValueType) VariableName`

- `Mappings` are like `Dictionaries` in python, a key-value pair data structure

- In this contract, we are creating the public mapping `myMap` that associates the key type `address` with the value type `uint`.

```sh
mapping(address => uint) public myMap;
```

## Data structures -- Structs

- In Solidity, we can define custom data types in the form of structs. Structs are a collection of variables that can consist of different data types.

`Defining structs`
- We define a struct using the struct keyword and a name (line 5). Inside curly braces, we can define our struct’s members, which consist of the variable names and their data types.

`Initializing structs`

- There are different ways to initialize a struct.

- `Positional parameters`: We can provide the name of the struct and the values of its members as parameters in parentheses (line 16).

- `Key-value mapping`: We provide the name of the struct and the keys and values as a mapping inside curly braces (line 19).

- `Initialize and update a struct`: We initialize an empty struct first and then update its member by assigning it a new value (line 23).


## Data structures -- Enums

```sh
In Solidity enums are custom data types consisting of a limited set of constant values. We use enums when our variables should only get assigned a value from a predefined set of values.

In this contract, the state variable status can get assigned a value from the limited set of provided values of the enum Status representing the various states of a shipping status.

Defining enums
We define an enum with the enum keyword, followed by the name of the custom type we want to create (line 6). Inside the curly braces, we define all available members of the enum.

Initializing an enum variable
We can initialize a new variable of an enum type by providing the name of the enum, the visibility, and the name of the variable (line 16). Upon its initialization, the variable will be assigned the value of the first member of the enum, in this case, Pending (line 7).

Even though enum members are named when you define them, they are stored as unsigned integers, not strings. They are numbered in the order that they were defined, the first member starting at 0. The initial value of status, in this case, is 0.

Accessing an enum value
To access the enum value of a variable, we simply need to provide the name of the variable that is storing the value (line 25).

Updating an enum value
We can update the enum value of a variable by assigning it the uint representing the enum member (line 30). Shipped would be 1 in this example. Another way to update the value is using the dot operator by providing the name of the enum and its member (line 35).

Removing an enum value
We can use the delete operator to delete the enum value of the variable, which means as for arrays and mappings, to set the default value to 0.

Watch a video tutorial on Enums.

⭐️ Assignment
Define an enum type called Size with the members S, M, and L.
Initialize the variable sizes of the enum type Size.
Create a getter function getSize() that returns the value of the variable sizes.
```

## Data Locations

- The values of variables in Solidity can be stored in different data locations: `memory`, `storage`, and `calldata`.

- `Storage`:
- Values stored in storage are stored `permanently` on the `blockchain` and, therefore, are expensive to use.

- `Memory`:
- Values stored in memory are only stored `temporarily` and are not on the blockchain. They only exist during the execution of an external function and are discarded afterward. They are cheaper to use than values stored in storage.

- `Calldata`:
- Calldata stores function arguments. Like memory, calldata is only stored temporarily during the execution of an external function. In contrast to values stored in memory, values stored in calldata can not be changed. Calldata is the cheapest data location to use.


## Transactions -- Sending Ether
```sh
In this section, we will learn how a contract can send and receive Ether.

Sending Ether
We have three different options to transfer Ether: transfer(), send() and call().

transfer
<address payable>.transfer(uint256 amount)

transfer() throws an exception on failure
Forwards a fixed 2300 gas stipend
An example of transfer() can be seen in the SendEther contract (line 35). Transfer() is not recommended to be used anymore.

send
<address payable>.send(uint256 amount) returns (bool)

send() returns false on failure
Forwards a fixed 2300 gas stipend
An example of send() can be seen in the SendEther contract (line 41). Send() is not recommended to be used anymore.

call
<address>.call(bytes memory) returns (bool, bytes memory)

call() returns false on failure
Forwards the maximum amount of gas, but this is adjustable
An example of call() can be seen in the SendEther contract (line 48). Call() is currently recommended if you are transfering Ether.

The reason transfer() and send() were introduced was to guard against reentry attacks by limiting the forwarded gas to 2300, which would be insufficient to make a reentrant call that can modify storage.

As we discussed in the last section, each operation on Ethereum has a specific cost associated with it. Certain operations have become more cost intensive over time, so the gas costs associated with them are also raised. When gas costs for operations are subject to change it is not good to use a hardcoded gas amount like transfer(), and send() do.

That’s why call() instead of transfer() is now recommended to send Ether.
```