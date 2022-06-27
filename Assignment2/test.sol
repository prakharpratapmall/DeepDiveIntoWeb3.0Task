// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <0.9.0;

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin {
    mapping(address => uint256) balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor() public {
        balances[tx.origin] = 100000;
    }

    function sendCoin(
        address receiver,
        uint256 amount,
        address sender
    ) public returns (bool sufficient) {
        if (balances[sender] < amount) return false;
        balances[sender] -= amount;
        balances[receiver] += amount;
        emit Transfer(sender, receiver, amount);
        return true;
    }

    function getBalance(address addr) public view returns (uint256) {
        return balances[addr];
    }
}

// Try not to edit the contract definition above

contract Loan is MetaCoin {
    // You can edit this contract as much as you want. A template is provided here and you can change the function names and implement anything else you want, but the basic tasks mentioned here should be accomplished.
    mapping(address => uint256) private loans;

    event Request(
        address indexed _from,
        uint256 P,
        uint256 R,
        uint256 T,
        uint256 amt
    );

    address private Owner;

    address[] customers;

    modifier isOwner() {
        // Implement a modifier to allow only the owner of the contract to use specific functions
        require(msg.sender == Owner, "Unauthorised access");
        _;
    }

    constructor() public {
        // Make the creator of the contract the Owner.
        Owner = msg.sender;
        // You can take the help of 2_owner.sol contract in remix for this and the above function.
    }

    // Fill up the following function definitions and also try to justify why some functions are pure and some are view and some are none, in your README.md

    function fullMul(uint256 x, uint256 y)
        public
        pure
        returns (uint256 l, uint256 h)
    {
        uint256 mm = mulmod(x, y, uint256(-1));
        l = x * y;
        h = mm - l;
        if (mm < l) h -= 1;
    }

    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 z
    ) public pure returns (uint256) {
        (uint256 l, uint256 h) = fullMul(x, y);
        require(h < z);
        uint256 mm = mulmod(x, y, z);
        if (mm > l) h -= 1;
        l -= mm;
        uint256 pow2 = z & -z;
        z /= pow2;
        l /= pow2;
        l += h * ((-pow2) / pow2 + 1);
        uint256 r = 1;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;
        r *= 2 - z * r;
        return l * r;
    }

    function getCompoundInterest(
        uint256 principle,
        uint256 rate,
        uint256 time
    ) public pure returns (uint256) {
        // Anyone should be able to use this function to calculate the amount of Compound interest for given P, R, T
        // Solidity does not have a good support for fixed point numbers so we input the rate as a uint
        // A common way to perform division to calculate such percentages is mentioned here:
        // https://medium.com/coinmonks/math-in-solidity-part-4-compound-interest-512d9e13041b just read the periodic compounding part and
        // https://medium.com/coinmonks/math-in-solidity-part-3-percents-and-proportions-4db014e080b1 just read the towards full proportion part.
        // A good way to prevent overflows will be to typecast principle, rate and the big number divider suggested in the above blogs as uint256 variables, just use uint256 R = rate;
        uint256 amt = principle * 1e18;
        while (time != 0) {
            amt = amt + mulDiv(amt, rate, 100);
            time--;
        }
        return amt / 1e18;
    }

    function reqLoan(
        uint256 principle,
        uint256 rate,
        uint256 time
    ) public returns (bool correct) {
        uint256 toPay = getCompoundInterest(principle, rate, time);
        if (toPay >= principle) {
            loans[msg.sender] += toPay;
            customers.push(msg.sender);
            emit Request(msg.sender, principle, rate, time, toPay);
            return true;
        } else return false;
        // A creditor uses this function to request the Owner to settle his loan, and the amount to settle is calculated using the inputs.
        // Add appropriate definition below to store the loan request of a contract in the loans mapping,
        // Also emit the Request event after succesfully adding to the mapping, and return true. Return false if adding to the mapping failed (maybe the user entered a float rate, there were overflows and toPay comes to be lesser than principle, etc.
    }

    function getOwnerBalance() public view returns (uint256) {
        // use the getBalance function of MetaCoin contract to view the Balance of the contract Owner.
        // hint: how do you access the functions / variables of the parent class in your favorite programming language? It is similar to that in solidity as well!
        return super.getBalance(Owner);
    }

    // implement viewDues and settleDues which allow *ONLY* the owner to *view* and *settle* his loans respectively. They take in the address of a creditor as arguments. viewDues returns a uint256 corresponding to the due amount, and does not modify any state variables. settleDues returns a bool, true if the dues were settled and false otherwise. Remember to set the the pending loan to 0 after settling the dues.
    // use sendCoin function of MetaCoin contract to send the coins required for settling the dues.
    function viewDues(address customer) public view isOwner returns (uint256) {
        return loans[customer];
    }

    function settleDues(address customer) public isOwner returns (bool) {
        if (super.sendCoin(customer, loans[customer], Owner)) {
            loans[customer] = 0;
            return true;
        } else {
            return false;
        }
    }
}
