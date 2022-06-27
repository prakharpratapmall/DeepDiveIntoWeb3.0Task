## Assignment 2

## Running the contract
 - Use [Remix IDE](www.remix.ethereum.org)
 - Compile the test.sol file using mentioned compiler version (anything above 0.4.25 works)
 - Under the Deploy and Run tab choose an enviorment (JavaScript VM works best)
 - Choose any account that you want to be the deployer/owner of the contract
 - Click on Deploy
 - Different functionalities of the contract would be accessible under the Deployed Contracts tab

## Functions and their uses cases
### reqLoan
A creditor uses this function to request the Owner to settle his loan
Takes the following input.
- principle : uint, the amount you are requesting, cant be a fraction for now
  - Example : 10000
- rate : uint, cant be a fraction for now
  - Example : 2
- time : uint, cant be a fraction for now
  - Example : 5

### sendCoin
A function implemented in the base contract to send coins from one address to another.Takes the following input.
- reciever : address, the address of the person recieving the money
  - Example : 0x617F2E2fD72FD9D5503197092aC168c91465E7f2
- amount : uint, the amount you are requesting, cant be a fraction for now
  - Example : 10000
- sender : address, the address of the person sending the money
  - Example : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
### settleDues
Settles all dues between owner and creditor by making owner send money to creditor. Takes the following input:
- customer : address, address of the creditor whoes dues is to be settled
  - Example : 0x617F2E2fD72FD9D5503197092aC168c91465E7f2
### getBalance
Return the amount the owner currently owns to the creditor passed in the parameter. Takes the following input:
- addr : address, address of the creditor whoes dues is to be found
  - Example : 0x617F2E2fD72FD9D5503197092aC168c91465E7f2

### getCompoundInterest
Use this function to calculate the amount of Compound interest for given P, R, T. Takes the following input:
- principle : uint, the amount you are requesting, cant be a fraction for now
  - Example : 10000
- rate : uint, cant be a fraction for now
  - Example : 2
- time : uint, cant be a fraction for now
  - Example : 5
### getOwnerBalance
Return the current balance of the owner. No inputs.

