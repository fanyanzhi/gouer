// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Owner {
    struct Identity {
        address addr;
        string name;
    }

    enum State {
        HasOwner,
        NoOwner
    }

    event OwnerSet(address indexed oldOwnerAddr, address indexed newOwnerAddr);
    event OwnerRemoved(address indexed oldOwnerAddr);

    modifier isOwner() {
        require(msg.sender == owner.addr, "Caller is not owner");
        _;
    }

    Identity private owner;
    State private state;

    constructor(string memory name) {
        owner.addr = msg.sender;
        owner.name = name;
        state = State.HasOwner;
        emit OwnerSet(address(0), msg.sender);
    }

    function changeOwner(address addr, string calldata name) public isOwner {
        emit OwnerSet(owner.addr, addr);
        owner.addr = addr;
        owner.name = name;
    }

    function removeOwner() public isOwner {
        delete owner;
        state = State.NoOwner;
        emit OwnerRemoved(msg.sender);
    }

    function getOwner() external view returns(address, string memory) {
        return (owner.addr, owner.name);
    }

    function getState() external view returns(State) {
        return state;
    }
}