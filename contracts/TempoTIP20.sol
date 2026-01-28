// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TempoTIP20 {
    string public name;
    string public symbol;
    uint8 public decimals = 6;

    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event TransferWithMemo(
        address indexed from,
        address indexed to,
        uint256 value,
        bytes32 memo
    );
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        _mint(msg.sender, _initialSupply);
    }

    function _mint(address to, uint256 amount) internal {
        balanceOf[to] += amount;
        totalSupply += amount;
        emit Transfer(address(0), to, amount);
    }

    // --- BASIC TRANSFER ---
    function transfer(address to, uint256 amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "balance too low");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    // --- TRANSFER WITH MEMO (KEY FEATURE) ---
    function transferWithMemo(
        address to,
        uint256 amount,
        bytes32 memo
    ) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "balance too low");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit TransferWithMemo(msg.sender, to, amount, memo);
        return true;
    }

    // --- APPROVE ---
    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // --- TRANSFER FROM ---
    function transferFrom(
        address from,
        address to,
        uint256 amount,
        bytes32 memo
    ) external returns (bool) {
        require(balanceOf[from] >= amount, "balance too low");
        require(allowance[from][msg.sender] >= amount, "allowance too low");

        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        emit TransferWithMemo(from, to, amount, memo);
        return true;
    }
}
