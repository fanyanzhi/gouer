// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract HelloWorld {
    string public greet = "Hello World!";
}

contract Counter {
    uint256 public count;

    function get() public view returns(uint) {
        return count;
    }

    function inc() public {
        count += 1;
    }

    function dec() public {
        count -= 1;
    }
}

contract Primitives {
    bool public boo = true;

    uint8 public u8 = 1;
    uint256 public u256 = 456;
    uint256 public u = 123;

    int8 public i8 = -1;
    int256 public i256 = 456;
    int256 public i = -123;

    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    bytes1 a = 0xb5;
    bytes1 b = 0x56;

    bool public defaultBoo;
    uint256 public defaultUint;
    int256 public defaultInt;
    address public defaultAddr;
}

contract Variables {
    string public text = "Hello";
    uint256 public num = 123;

    function doSomething() public view {
        uint256 i = 456; i;

        uint256 timestamp = block.timestamp; timestamp;
        address sender = msg.sender; sender;
    }
}

contract Constants {
    address public constant My_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;

    uint256 public constant MY_UINT = 123;
}

contract Immutable {
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;

    constructor(uint256 _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}

contract SimpleStorage {
    uint256 public num;

    function set(uint256 _num) public {
        num = _num;
    }

    function get() public view returns(uint256) {
        return num;
    }
}

//1gwei = 10**9 wei
contract EtherUnits {
    uint256 public oneWei = 1 wei;
    bool public isOneWei = (oneWei == 1);

    uint public oneGwei = 1 gwei;
    bool public isOneGwei = (oneGwei == 1e9);

    uint public oneEther = 1 ether;
    bool public isOneEther = (oneEther == 1e18);
}

contract NestedMapping {
    mapping(address => mapping(uint256 => bool)) public nested;

    function get(address _addr1, uint _i) public view returns(bool) {
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint _i, bool _boo) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint _i) public {
        delete nested[_addr1][_i];
    }
}

contract Array {
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3];

    uint[10] public myFixedSizedArr;

    function get(uint256 i) public view returns(uint) {
        return arr[i];
    }

    function getArr() public view returns(uint[] memory) {
        return arr;
    }

    function push(uint256 i) public {
        arr.push(i);
    }

    function examples() external pure{
        uint256[] memory a = new uint256[](5); a;
    }
}

contract Error {
    function testRequire(uint256 _i) public pure {
        require(_i > 10, "Input must be greater than 10");
    }

    function testRevert(uint256 _i) public pure {
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint256 public num;

    function testAssert() public view {
		assert(num == 0);
    }

    
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function testCustomError(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }
}



contract FunctionModifier {
    // We will use these variables to demonstrate how to use
    // modifiers.
    address public owner;
    uint256 public x = 10;
    bool public locked;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    function changeOwner(address _newOwner)
        public
        onlyOwner
        validAddress(_newOwner)
    {
        owner = _newOwner;
    }

    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}


contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}


contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}


contract B is X("Input to X"), Y("Input to Y") {}

contract C is X, Y {
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}


contract D is X, Y {
    constructor() X("X was called") Y("Y was called") {}
}


contract E is X, Y {
    constructor() Y("Y was called") X("X was called") {}
}