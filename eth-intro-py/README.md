
## 1. Prerequisites Installation

- `web3.py` is the gateway to the Ethereum in order to interact, execute and run operations on the EVM
(Ethereum Virtual Machine)

- 


## 2. Setup
```sh
# Install dependencies
pip install ipython
pip install web3
pip install 'web3[tester]'

# Run ipython terminal
ipython

# import Web3 from web3
from web3 import Web3
```

```sh
1 ether = 1000000000000000000 wei
1 wei = 0.000000000000000001 ether
```
- Convert to and from wei
```sh
# Convert 1 either to wei
In [2]: Web3.to_wei(1, 'ether')
Out[2]: 1000000000000000000

# Convert 500000000 wei to gwei
In [3]: Web3.from_wei(500000000, 'gwei')
Out[3]: Decimal('0.5')
```

## 3. Notes:
- You can communicate wih the `EVM` in three different ways
1. IPC -- Inter-process Communiction
2. HTTP
3. Websockets

- To connect to the real `EVM` download an ethereum node at `https://geth.ethereum.org/`

- Start Geth in one terminal window and wait for it to sync the network. The default HTTP port is `8545`, but is configurable.

- Tell `Web3.py` to connect to the node via HTTP, on `localhost:8545`. `w3 = Web3(Web3.HTTPProvider('http://127.0.0.1:8545'))`

- Use the `w3` instance to interact with the node.

- While this is one `“real”` way to do it, the syncing process takes `hours` and is unnecessary if you just want a development environment. Web3.py exposes a fourth provider for this purpose, the `EthereumTesterProvider`. This tester provider links to a `simulated Ethereum node` with relaxed permissions and fake currency to play with.

- The simulated node is called `eth-tester` available at `https://github.com/ethereum/eth-tester`

```sh
# Connect to eth-tester (EthereumTesterProvider)
In [4]: w3 = Web3(Web3.EthereumTesterProvider())

# Test connection to the blockchain
In [5]: w3.is_connected()
Out[5]: True
```

## 4. Accounts
```sh
# Get list of Accounts
In [9]: w3.eth.accounts
Out[9]: 
['0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf',
 '0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF',
 '0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69',
 '0x1efF47bc3a10a45D4B230B5d10E37751FE6AA718',
 '0xe1AB8145F7E55DC933d51a18c793F901A3A0b276',
 '0xE57bFE9F44b819898F47BF37E5AF72a0783e1141',
 '0xd41c057fd1c78805AAC12B0A94a405c0461A6FBb',
 '0xF1F6619B38A98d6De0800F1DefC0a6399eB6d30C',
 '0xF7Edc8FA1eCc32967F827C9043FcAe6ba73afA5c',
 '0x4CCeBa2d7D2B4fdcE4304d3e09a1fea9fbEb1528']
```

- If you run this command, you should see a list of ten strings that begin with `0x`. Each is a `public address` and is, in some ways, analogous to the account number on a checking account. You would provide this address to someone that wanted to send you ether.

```sh
#  Let’s find out how much is in the first account:
In [10]: w3.eth.get_balance(w3.eth.accounts[0])
Out[10]: 1000000000000000000000000

# Or pass the hex value of the account
In [12]: w3.eth.get_balance('0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf')
Out[12]: 1000000000000000000000000

# Convert the above value (in wei) to "ether" 
In [13]: w3.from_wei(1000000000000000000000000, 'ether')
Out[13]: Decimal('1000000')
```

## 5. Block Data
```sh
# Get the latest block
# This gives the genesis block, no transactions, no previousHash(parentHash)
In [15]: w3.eth.get_block('latest')
Out[15]: 
AttributeDict({'number': 0,
 'hash': HexBytes('0x89c1256be74b405eb61b29b0882010aaa79b5d586e41f41fe6fc442b255152fb'),
 'parentHash': HexBytes('0x0000000000000000000000000000000000000000000000000000000000000000'),
 'nonce': HexBytes('0x0000000000000000'),
 'sha3Uncles': HexBytes('0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347'),
 'logsBloom': HexBytes('0x00'),
 'transactionsRoot': HexBytes('0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421'),
 'receiptsRoot': HexBytes('0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421'),
 'stateRoot': HexBytes('0xf1588db9a9f1ed91effabdec31f93cb4212b008c8b8ba047fd55fabebf6fd727'),
 'miner': '0x0000000000000000000000000000000000000000',
 'difficulty': 0,
 'totalDifficulty': 0,
 'mixHash': HexBytes('0x0000000000000000000000000000000000000000000000000000000000000000'),
 'size': 548,
 'extraData': HexBytes('0x0000000000000000000000000000000000000000000000000000000000000000'),
 'gasLimit': 30029122,
 'gasUsed': 0,
 'timestamp': 1706543179,
 'transactions': [],
 'uncles': [],
 'baseFeePerGas': 1000000000,
 'withdrawals': [],
 'withdrawalsRoot': HexBytes('0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421')})
```

## 6. Transactions
- Send a transaction from one account to another

```sh
# Send 3 ether from account 3 to account 1 with a gas fee of 2100 wei
tx_hash = w3.eth.send_transaction(
    {
        'from': w3.eth.accounts[3],
        'to': w3.eth.accounts[1],
        'value': w3.to_wei(3, 'ether'),
        'gas': 21000
    }
)

# Fetch the transaction hash value of tx_hash
In [17]: tx_hash
Out[17]: HexBytes('0x97429e9f8ff9c6f129ce4935b7f25d9faf660640c30386d7d28ddb49c6d3a20e')

# Wait for the transaction to be included in a block: 
w3.eth.wait_for_transaction_receipt(tx_hash)

# Fetch the transaction details
In [20]: w3.eth.get_transaction(tx_hash)
    ...: 
Out[20]: 
AttributeDict({'type': 2,
 'hash': HexBytes('0x97429e9f8ff9c6f129ce4935b7f25d9faf660640c30386d7d28ddb49c6d3a20e'),
 'nonce': 0,
 'blockHash': HexBytes('0xb3007ec7cfadf38dddfc42a4b9bceafe035fecd48006c6e8e109674cffc07c0d'),
 'blockNumber': 1,
 'transactionIndex': 0,
 'from': '0x1efF47bc3a10a45D4B230B5d10E37751FE6AA718',
 'to': '0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF',
 'value': 3000000000000000000,
 'gas': 21000,
 'data': HexBytes('0x'),
 'r': HexBytes('0xb39294049c4f29b26ee66dc775f355feb17745efba19290dfd3ab9cd9fe9e4b7'),
 's': HexBytes('0x37067ca268af2724182ff3b5d5e4792097348ff72c293412bd30c5cad7f5d57e'),
 'v': 0,
 'chainId': 131277322940537,
 'maxFeePerGas': 1000000000,
 'maxPriorityFeePerGas': 1000000000,
 'accessList': [],
 'gasPrice': 1000000000})
```