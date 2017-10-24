# Love Bloc

<p align="center">
  <img src="https://media.giphy.com/media/l378xsJp3Yw4zYiJ2/giphy.gif" />
</p>


LoveBloc is a decentralised application that uses blockchain and smart contract technology to allow users of any belief, gender and sexual orientation to form a marriage that is immutable and everlasting


###### What is blockchain?
A blockchain is a distributed database that is shared between a network of computers or nodes. It is a digital ledger of transactions that are publicly accessible and incorruptible.

Ethereum is a blockchain-based distributed computing platform, which focuses on smart contracts.
###### What is a smart contract?
A smart contract is computer code which can facilitate, execute and enforce an agreement using blockchain technology. It allows two parties to do business with one another without the need of a middleman. It is a set of instructions that are executed under specific circumstances.

The smart contract code is encrypted and sent out to nodes via the distributed network. These work to execute the code, with each transaction being recorded in a new block on the chain, along with any data associated with it. 
###### Why blockchain marriage?
There are sadly still many places in the world where certain groups cannot demonstrate their love and commitment through a legal marriage contract. Our app allows anyone to create a marriage with their partner in any location(as long as there is internet!) and without any state interference. It is inclusive and meaningful due to the unchangeable and lasting qualities of blockchain records.

It works by recording a marriage transaction when there is a matching proposal made by two parties.
We hope to implement functionality to allow polyamorous relationships to be included.

## Team
This app was developed over a 9 day period as a final project at Makers Academy, a software development bootcamp. The team consisted of the following lovely people:

[Kathryn Downes](https://github.com/kitkat119), [Antoine Doolaeghe](https://github.com/adoolaeghe), [Funmi Adewodu](https://github.com/funmia), [Oleg Lukyanov](https://github.com/oleglukyanov)


## How to run
1. Install Node.js.

2. Clone the repo to your computer.
```
git clone https://github.com/adoolaeghe/Love-Block
cd Love-Block
```

3. Install truffle testing framework and testrpc, a Node.js based Ethereum client used for development.
```
npm install -g ethereumjs-testrpc
npm install -g truffle
```

4. Install the node dependencies.
```
npm install
```

5. Install Metamask chrome plugin at https://metamask.io/.

6. Run testrpc in a separate terminal window. This will print out 10 pre-funded accounts along with a 12 word mneumonic which will allow you to regenerate these.
```
testrpc
```

7. Open a Metamask account using the 12 word mneumonic. Your account will contain 100 ETH.

8. In your original terminal window run:
```
truffle compile
truffle migrate
npm run dev
```
9. The app will be launched at localhost:3000.


## To run the tests:
```
truffle test
```

## User Stories

```
As a user,
So that I can demonstrate my commitment to another user,
I would like to be able to create a request for their hand in marriage.

As a user,
So that I can consider whether I am sure that I wish to go ahead,
I would like to be able to choose between yes and no.

As a user,
So that I can celebrate the marriage with the blockchain community,
I would like to see a confirmation of my marriage.

As a user,
So that I can show evidence of my marriage,
I would like to receive a certificate once my marriage has been confirmed.
```

## Tech Stack

:computer: Ethereum/Testrpc

:computer: Truffle

:computer: Solidity

:computer: Javascript

:computer: Jade

:computer: Web3.js

## Team charter

A set of values agreed upon by the whole team on the first day of the project.

* Simplicity
* Stand ups daily at 10am
* Retro Daily at 5pm
* Have fun!
* Consider everyone's views and opinions
* Open communication and honesty
* Respect that everyone has a life outside of the project
* Document key moments in the project
* Change pairs regularly
* Have a different stand up/retro leader each day
* Be kind to each other :)
