// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract FunctionSelectorExample {
    //状态变量，用于存储函数选择器
    bytes4 public storedSelector;

    function square(uint x) public pure returns(uint) {
        return x * x;
    }

    function double(uint x) public pure returns(uint) {
        return 2 * x;
    }

    //根据传入的选择器，动态调用此合约的square double函数
    function executeFunction(bytes4 selector, uint x) public returns(uint) {
        bool success;
        bytes memory data;
        (success, data) = address(this).call(abi.encodeWithSelector(selector, x));
        require(success, "Function call failed");
        return abi.decode(data, (uint));
    }

    //函数，存储选择器到状态变量
    function storeSelector(bytes4 selector) public {
        storedSelector = selector;
    }


    //函数：调用存储在 storedSelector 中的函数，并返回结果
    function executeStoredFunction(uint x) public returns(uint) {
        require(storedSelector != bytes4(0), "Selector not set");
        bool success;
        bytes memory data;
        (success, data) = address(this).call(abi.encodeWithSelector(storedSelector, x));
        require(success, "Function call failed");
        return abi.decode(data, (uint));
    }

    function getSquareSelector() external pure returns(bytes4) {
        return this.square.selector;
    }

    function getDoubleSelector() external pure returns(bytes4) {
        return this.double.selector;
    }


}