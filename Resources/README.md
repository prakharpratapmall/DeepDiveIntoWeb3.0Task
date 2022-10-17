# Resources and Discussions

Before we begin with the Ethereum blockchain and solidity, you all need to know what Blockchains are and some of the central concepts they are based on. 


According to [Wikipedia](https://en.wikipedia.org/wiki/Blockchain]), Blockchain is a series of Blocks (like a linked list) connected via cryptography rather than the address pointer usually stored in a linked list. In layman's terms, Cryptography is a mathematical tool that can convert any length input into, for example, a fixed-length output, called the hash, in the form of a uniform distribution on the range of the output, such that it is difficult to find any other input which produced the same output (this can be made increasingly difficult by using an extensive range of possible outputs, think why?). 


Blocks in a Blockchain typically store the previous Block's hash along with information about Transactions etc., in the Block. Linking the blocks together with cryptography essentially makes tampering with the Blockchain difficult; for example, if in a Blockchain there are n blocks, and the attacker tries to modify Block i, then the hash of the entire Block i will change, due to which the hash stored in Block i+1 will change, due to which the hash of Block i+! will change, and so on... the attacker would have to modify every Block after the ith block! 


Now, if the entire Blockchain was stored on a single server, like in a Bank, if the attacker modified the Blockchain in the above way, the attack would be successful! So, this is where the Peer-to-Peer (P2P) nature of Blockchains comes into view. A copy of the entire Blockchain network is stored on EVERY blockchain node, which is a part of the network, and there are millions of such nodes; thus, you can understand that it will be tough to modify the state of the Blockchain for the attacker in a short period. Modifying the Blockchain needs consensus (more than half the nodes should agree to a state of the Blockchain for it to be accepted). Thus to do something like this, the attacker will have to control 50% of the total number of nodes to make changes in the Blockchain network. This essentially shows that the Blockchain is tamper-proof!


Suppose none of these technical terms made sense to you (it didn't to me as well when I was starting). In that case, the following video is a pretty good introduction to what blockchains and cryptocurrency are. He has explained the overall concept and some technical details on how cryptographic primitives are deployed inside to make the system tamper-proof (as we say it). Watch the video first and then go through the writeup again and try to make sense of the steps involved.
[Video](https://youtu.be/bBC-nXj3Ng4)


If you like reading more than watching a video, read [this](https://onezero.medium.com/how-does-the-blockchain-work-98c8cd01d2ae) and the Wikipedia article linked above



Now, you all must have heard about mining in some way or the other. Mining is the process by which new blocks are published (added) onto the blockchain. The nodes are in a constant race to get transactions, verify them, package them into a block and publish them on a Blockchain, as they are driven by incentives (usually mining a block results in some reward being given to the miner, in the form of new Cryptocurrency tokens or rewards for approving transactions).



Now, it is a straightforward process to verify a transaction. You might recall that for a block to be added to the blockchain, a majority of the nodes must agree to the contents of the block (must verify it). Thus, if the mining process just involved verifying transactions before publishing them, several nodes can publish a block simultaneously or with a minimal difference in publishing time, which can lead to difficulty in achieving consensus by the nodes ([read](https://en.wikipedia.org/wiki/Fork_(blockchain))). Also, a malicious node can spam the network with a fraudulent block, which can have a significant chance of being accepted. 



Thus, it is crucial to make this process of mining (publishing new blocks) slower and the process of verification of blocks faster so that Blocks aren't mined simultaneously and malicious blocks can be appropriately verified and aren't spammed. Essentially, we want a difficult and time-consuming problem to solve but easy to verify.



We'll now discuss how mining works currently (called the proof of work mechanism), in a simple way: 



Suppose you have a string/an image/anything else. You convert it into binary. You put the bytes together. You now have a long sequence of bits. 



Now assume that this sequence of bits represents a number. A very large number. But still a finite positive integer.



Suppose you have a mathematical function f(x): Z->[1,100]. This function can take any integer as the input, but always produces the output as an integer between 1 and 100. It is given that this function produces a uniform distribution. 



So you give this function an integer as an input. What is the probability that the output will be 5?
1/100 ?



What is the probability that the output will be less than or equal to 5?
1/20 ?



Let's call 5 our target. Now suppose you want to throw random numbers into the function as input, and you want the output to be less than or equal to our target (which is 5). What is the expected number of times you'll have to try?
20 ?



Now suppose you decrease the target to 4. What is the expected number of times you'll have to try to find an integer x such that f(x)<=target?
25 ?



Thus, now you have to try harder (do more work) to find such a number.
Now suppose you increase the target to 10. What is the expected number of times you'll have to try to find an integer x such that f(x)<=target?10?


Now you have to do less work to find such a number.


This is the essence of mining. You try to find such an input for a function which produces an output that is less than the target. The function used is a hash function, like the SHA-256 hash function. It produces 256 bits as the output (hence the name). If you represent the bytes as an integer, it would lie in the range [0, 2^256). The number is usually written in the hexadecimal format. So the hash value can range from0x0000000000000000000000000000000000000000000000000000000000000000 to 
0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF. But the hash function can take any sequence of bytes as input.
Also, if you change even a single bit in the input, the generated output is very different from the earlier output. 


For example: 

SHA256("iitk1") = b4576713e62c31a60b14df3d1fb5f50f29427af23e6acde5183ff661a5b5027a
SHA256("iitk2") = c1b5c76ac773146743cde3a6d82b4a023c76b60e198ee3748a64d713a77f3d9a
SHA256("iitk21") = 5ad35839b939dc27a16af30c2b8a932aa64baaf37f3487f7a8cfe22d42ca81d7


Here, we had some constant data ("iitk"), and a changing value (the number at the end). Mining is the process of finding this changing value that when combined with our data ("iitk" in our case) will produce an output below the target. Since the range of SHA256 hash function is huge, the target chosen is very high. If we chose the target to be 0x0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, the smallest positive integer that satisfies out target is 184519.



SHA256("iitk184519") = 0000e11b0268ff370bf302c8db25888f04fe1569cd20e5cac10b21d3b7db6413
As soon as we have found this magic number 184519, we have achieved success. You might think that this was pretty fast, but try reducing the target value, to say x000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF. You'll see that you will need significantly more time. However, verifying that the nonce you found is correct takes a split second, and you can see that you got the nonce correctly using [this](https://emn178.github.io/online-tools/sha256.html)!



So the mechanism you built for mining in the first Assignment is called proof of work, because essentially you have to prove that you did the mining correctly by trying to find a difficult to get to nonce value which can be verified by anyone. With a small enough target, the average time taken to mine the block can be set anything, like 10 minutes in Bitcoin and between 10-20 seconds in Ethereum.



Currently, most of the popular cryptocurrencies use a proof of work mechanism to do mining.
An aside: Last year you might have heard about Elon saying that Tesla will stop accepting Bitcoin as it is not environment friendly. This is actually true as the proof of work mechanism leads to a lot of heavy computation, and most of it is wasted as several million nodes compete with each other to find the nonce, while only one of the block (by the node which does it first) is accepted. 



Ethereum is trying to move away from this heavy computation based mining system to a system called proof of stake, in which not every node sits and tries to mine bitcoin, but instead there are a few large nodes, on which people stake their coins (sort of like betting on a node), and the node which mines the next block is chosen with a probability proportional to the amount of stake it has in comparison to other nodes. The reward hence generated by the node is distributed among the stakeholders in proportion to the stake which they put in the node(after the node makes some cut from the reward to account for the energy expenses and profits) 



This ensures that only one node has to perform the complex task of mining while the rest can save the energy. The consensus for the Pos mechanism is arrived at a different way though than PoW, and unlike PoW which has no punishment for incorrect mining of blocks (the amount of energy wasted is the punishment), PoS punishes malicious use by cutting the stake of the nodes by drastic amounts, something which obviously the stakeholders wouldn't want. (it is this comparison of incentives, whether to cheat and risk losing the stake, or to play it safe and do it right, is what is called game theory. And the PoS mechanism is designed in such a way that any rational node will always perform correct mining and there is no incentive to cheat!) 



Read about it [here](https://blockgeeks.com/guides/proof-of-work-vs-proof-of-stake/) :

Q: Are validators betting on a block and validators betting on a node the same thing as one node is assigned a block to mine?

A: So one of the reasons why we call the users staking the ether as stakeholders and not validators straight away because an ordinary user, like you and me, does not usually have the resources to become a node and perform mining operations (usually requiring several high end GPUs, and also require the system to be up all time mining, there being severe penalties for the system being offline and not validating). But we also want to put our ETH to use and make it grow! So we bet our coins on the larger nodes, which act as the validators, and their total stake is represented as the total amount of the Ether which has been bet on it. So basically non-miner users (stakeholders) can bet on nodes capable of mining (validators), and validators don't bet on each other. And the validators are assigned mining and validation (block integrity checks) depending on the amount of stake which they have.



Q: If the most probable node to mine the next block is the one with the maximum stake in it, it will result in an unstable equilibrium as all the validators could bet on a single node and everyone keeps winning. By making the node with the least stake as the one to mine the next block, a stable equilibrium is created. Have I misunderstood something here?

A: It is a pretty valid doubt, and in fact, it makes a hell lot of sense at first if all users stake on a single validator, and it will result in that validator being assigned the mining task every time. It will be an always winning case for all the users who staked!




However, you do need to realize that Blockchains are Decentralized networks. What we are trying to achieve is to remove any centralization of power (just one node controlling the whole blockchain is something no one wants!). Consensus is an important part of a Blockchain, and in PoS at least 51% of the staked Ether must agree to the block being proposed. (that is if n validators and the 1 mining node agree that the block mined is correct, then these n+1 nodes should control 51% of the total staked ether). 
So forget a 100% stake for winning everytime... things will start literally falling apart when one node has more than even 51% stake! If a node has > 51% stake, it can propose any shit in the next block being mined and no one can challenge it... It can even transfer the ether which all of the ordinary users staked into it, to its own account, and you will lose all your ether! Basically the state of the Blockchain network will be what the node decides it to be. The entire Blockchain network would fall-off, and it will become a centralized network, with the node having full control of the amount of ether you have, and anyone in the world has. This is something totally against the concept of Blockchain, and no one wants this. So, the people stop trusting Ethereum and the value of Ethereum will drop to zero (you might have seen from the comment I made in the morning, that the value of these cryptos depends on what the people think its worth, and if something like this happens, it will be nothing). Thus, if y'all stake your ether on a single node, the Blockchain is bound to fail, and you all will become the next Ozymandias, the King of ... sand! So it will probably never come to that. The rewards from staking are pretty small as compared to the risk of losing all your ETH and its value dropping to zero xD.

What I just explained above is called the 51% attack in blockchain. Basically if anyone is in control of 51% of nodes in Proof of Work, or 51% of the currency in Proof of stake, then the Blockchain becomes centralized, as one party can control it, and it is bound to fail if something like this happens. However, the incentives the attacker gets from doing something like this is minuscule compared to the harms and it is safe to say something like this won't ever happen. Read about 
[Ethereum](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/) for more clarity on these two questions.



Also, read [this](https://www.investopedia.com/terms/1/51-attack.asp) if you want to know more about 51% attacks on Blockchains.


And [this](https://www.poetryfoundation.org/poems/46565/ozymandias) if you wanna know about Ozymandias.
Btw trivia: the best Breaking bad episode (arguably) also has the same name, Ozymandias. And you can imagine what happened in that episode to happen to you if one node has a 51% stake xD


We know that Bitcoin is a cryptocurrency, something which you can use as something of value, sort of like the Indian Rupee or US Dollar. You can use it to buy stuff, and trade something of value. And you might be thinking, well, what is so different in Ethereum that is not there in Bitcoin? Why do we need this another cryptocurrency when Bitcoin suffices in all the aspects of serving as a currency. Well, Bitcoin being just a currency is the exact problem. The world needs more! 

We don't just need to have a decentralized currency, but we also want the world to have decentralized voting, decentralized auctions, decentralized identity management, decentralized asset transferring, etc. These things are currently done in a centralized way and people don't usually have control over their results, such as Ballot tampering / booth capturing in voting, fraud and collusion with the auctioner in an auction, Facebook sharing your identity with Cambridge analytica, which gets leaked, and Bank frauds... there are countless issues with how they are done currently. 

Having them work in a decentralized way, such that its not just one single party that is aware of the results and actual count, but every single node in the world is aware of the number of votes cast, the auction amount bid, encrypted data stored, and asset transfer made. Having this decentralization of the records remove any possibility of fraud, as every node in the world can prove a fake claim wrong, as they have proof of the actual results of these processes.


Bitcoin, being just a currency, can not do all this. 

Thus we need a decentralized mechanism to perform such tasks. These tasks can, obviously, be modeled as a computer code. 

Thus we need something to execute computer code in a decentralized fashion, essentially forming a World Computer! 

Ethereum aims to do just that. Now you might be thinking that Ethereum also has its own currency, called Ether, ETH. But its main purpose is to incentivize participation of more and more users and nodes in the World Computer, so as to increase the capacity of the world computer! The more transactions, the more blocks mined, the more ETH produced, and more rewards for the participants! 

The Ether acts as sort of a connective fluid, joining you and me, the ordinary users, to some random node in China, to perform and verify crucial decentralized tasks for us, and then to each and every node in the world which maintains a copy of the mined Block, and hence the task (as a fun fact, ether in mythology is the element that connect us to spirit, intuition, other realms and planes, and basically everything around us. It was thought to fill the space in the universe. ETH does just that in the Ethereum universe!)
@Web 3.0 Ethereum works by making use of smart contracts, which are code fragments which are publicly available on Ethereum, to ask the nodes to perform a certain task and put its results on the blockchain. How does a smart contract work?...well it can be thought of as a vending machine (here is Vitalik Buterin, the creator of Ethereum, explaining how: https://www.youtube.com/watch?v=r0S4qIMf4Pg) and I will leave it to Vitalik and the Ethreum webpage to further explain the other important terms about Ethereum, namely Smart Contracts, EVMs, accounts, Ethereum transactions to this webpage: https://ethereum.org/en/developers/docs/intro-to-ethereum/ . It is the official dev docs of Ethereum and a great learning resource about ETH, now and in the future, after this project is completed! For the time being, you just need to read this page, but as an aside you can read the links telling more on a given topic at then end of each section in the webpage. However, the brief intro provided in this page should suffice for the time being.

We now start with solidity. Solidity is an object-oriented, contract-oriented, high-level language for implementing smart contracts. It was influenced by C++, Python and JavaScript and is designed to work on Ethereum, specifically the Ethereum Virtual Machine (EVM). It looks and feels very similar to JS (indeed, it is an ECMA script) so if you are familiar with JS, it should be relatively easier to pick up.

Solidity is statically typed, supports inheritance, libraries and complex user-defined types among other features.

As you will see, it is possible to create contracts for voting, crowdfunding, blind auctions, multi-signature wallets and more using solidity and we aim to create and understand the implementations of such complex problems in the real world by the end of this project!

The best way to try out Solidity right now is using Remix. Remix is a web browser based IDE that allows you to write Solidity smart contracts, then deploy and run the smart contracts. I would suggest you all play around with remix and its features(it has a walkthrough of sorts), and try to get familiar with the environment. It has some demo codes which you can run and try to get familiar with how to run smart contracts, where to take input. Maybe try making small changes as well in the demo smart contracts and see what it does (if you are able to understand the syntax)!

I personally believe that if you already know one language and got to learn another, then instead of tutorials, reading already existing code is the best way to learn the new language. The code samples on Remix will do just that, and you can use your already existing experience with OOP languages to try and make sense of the code over there. Until then, just play around with [remix](https://remix.ethereum.org/)! Cheers!

Moving on to references and tutorials for solidity, [This](https://www.tutorialspoint.com/solidity/index.htm) is a very nice source for learning the basics of solidity. You can skip the Environment setup part and follow the remaining basic part for a quick review of the syntax of solidity, so that you can make quick comparisons with a language you are familiar with, note the differences, and commit that to memory for future use.

These 3 are the most important parts of the basic tutorial though:

[1](https://www.tutorialspoint.com/solidity/solidity_variables.htm) the different variable types in solidity

[2](https://www.tutorialspoint.com/solidity/solidity_variable_scope.htm) variable scope in solidity (this should have been obvious from previous OOP experience but seeing that most of you guys didn't make use of public private protected variables in your selection test, we are giving this as an important link)

[3](https://www.tutorialspoint.com/solidity/solidity_special_variables.htm) some predefined variables which are very important in solidity for various purposes (you might have seen a few of them in the remix samples)

Moving on to [functions](https://www.tutorialspoint.com/solidity/solidity_functions.htm) in solidity

Solidity has different kinds of functions, such as view functions which do not modify the state (any variable of the smartcontract outside the function) and pure functions that do not read AND modify state. These are mainly for security purposes and ensuring that unauthorized access to the state does not happen when it is not needed. You can read about these 

[Function modifiers](https://www.tutorialspoint.com/solidity/solidity_function_modifiers.htm) are something new in solidity which isn't there in any language that I am aware of. It basically uses the symbol _; to act as a placeholder for another function, and another function gets inserted into that placeholder when some condition is met.

In order to get familiar with the OOP concepts of solidity, read about Contracts (basically like classes), Inheritance and Constructors in solidity here: [Contracts](https://www.tutorialspoint.com/solidity/solidity_contracts.htm), [Inheritance](https://www.tutorialspoint.com/solidity/solidity_inheritance.htm), [Constructors](https://www.tutorialspoint.com/solidity/solidity_constructors.htm)

If you prefer to do a step by step tutorial and search away on google and docs whenever a new term pops up (I learn stuff this way), then follow this [tutorial](https://www.dappuniversity.com/articles/solidity-tutorial) . However, please have a look at the above pages after you are done with it!

And yes check the official solidity [documentations](https://docs.soliditylang.org/en/latest/) if you like to follow official docs.

Now, moving on with the project.

[Basics of HTML](https://www.w3schools.com/html/html_intro.asp) : 
Try this basic tutorial of HTML till the topic ‘HTML ComputerCode’.

[Basics of CSS](https://www.w3schools.com/css/default.asp) : 
Try this basic tutorial of HTML till the topic ‘CSS Combinators’.

For people who're done with above resources, you can start learning [JavaScript](https://www.w3schools.com/js/default.asp).
Use this to start off. It's pretty much similar to C/C++ architecture, atleast for the syntax part. Do this tutorial till JS break module. Once you're done with this part, you shall be ready to discover the brilliance of JS ES6 version. Check this out [here](https://www.w3schools.com/js/js_es6.asp)

Hoping that you guys are now good with the basics of Web development it’s time to know ReactJS.

ReactJS is a declarative, efficient, and flexible JavaScript library for building reusable UI components. It is an open-source, component-based front end library which is responsible only for the view layer of the application. It was initially developed and maintained by Facebook and later used in its products like WhatsApp & Instagram.

Following are some of the resources to get you started for ReactJS

1)[Official Documentation](https://reactjs.org/docs/getting-started.html)

2)[YT PLaylist](https://youtube.com/playlist?list=PL4cUxeGkcC9gZD-Tvwfod2gaISzfRiP9d) 

After learning about the blockchain, the nodes, the consensus, all the major components of this technology and then frontend development, you'll start to wonder, "What kind of applications can I develop using all this knowledge?"

The applications built on top of Blockchain are called Decentralized Applications, or DApps, and have : 
- A standard Front-end built using JavaScript or frameworks/libraries like React, Vue, etc.
- A Solidity/Rust backend, built on top of the blockchain.
Learn more about Decentralized Application from [here](https://youtu.be/F50OrwV6Uk8)

Check [this](https://dappradar.com/) to see real-world examples of Defi (Decentralized Finance) and other Blockchain-based applications

Now to understand how the front-end and the backend of a DApp work together: communicating and exchanging data, you need to learn about the basic principles of standard [backend development](https://youtu.be/TlB_eWDSMt4) and about [APIs](https://youtu.be/-MTSQjw5DrM).

Now moving to final part, as you guys know how to create Smart Contracts, you need a way to connect your DApp front-end with your local or remote Solidity backend, using anything from HTTP to Websockets. To do so you can choose between two JavaScript Libraries:
1) Web3.js - web3.js is a collection of libraries that allow you to connect with a local or remote Ethereum node using HTTP, Websockets, and other communication protocols directly from your JavaScript Based front-end.
2) Ethers.js - Ethers.js is a lightweight JavaScript library used as an alternative to Web3.js to connect JavaScript front-end with Smart Contacts.

Resources :

[1](https://www.youtube.com/watch?v=t3wM5903ty0)

[2](https://youtu.be/a0osIaAOFSE)