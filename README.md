# ethereum-projects
Projects on the Ethereum blockchain framework

## [Tutorial-Link](https://ethereum.org/developers/docs)

- Transactions are many and thus grouped into batches called `blocks` of dozens to hundreds of them

- In the simplest terms, each `block` on the `Ethereum blockchain` is just some metadata and a list of transactions

- In JSON format, that looks something like this:

```json
{
   "number": 1234567,
   "hash": "0xabc123...",
   "parentHash": "0xdef456...",
   ...,
   "transactions": [...]
}
```

- the `parentHash` is simply the hash of the previous block. Can also be termed as `PreviousHash`

- The smallest denomination of `ether` is called `wei`


Isaac:
- Frontend: React, typescript, react and tailwind
- Backend: Nodejs

Theophillis
- Backend : golang (Gin), postgres

- mtn momo integration -- direct api / or gateway