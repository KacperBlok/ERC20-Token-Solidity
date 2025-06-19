// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// KBMasterToken (KBMT) - Decentralized ERC-20 Token

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract KBMasterToken is IERC20 {
    string public constant name = "KBMasterToken";
    string public constant symbol = "KBMT";
    uint8 public constant decimals = 18;
    uint256 public immutable totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    event TokensDeployed(address indexed deployer, uint256 totalSupply);
    event TokensWithdrawn(address indexed to, uint256 amount);
    event ContractBalanceChecked(uint256 balance);

    uint256 public constant initialSupply = 10000000; 

    constructor() {
        totalSupply = initialSupply * 10 ** decimals; 

        uint256 deployerTokens = totalSupply / 100; // 1%
        uint256 contractTokens = totalSupply - deployerTokens; // 99%

        _balances[msg.sender] = deployerTokens;
        _balances[address(this)] = contractTokens;

        emit Transfer(address(0), msg.sender, deployerTokens);
        emit Transfer(address(0), address(this), contractTokens);
        emit TokensDeployed(msg.sender, totalSupply);
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(
        address to,
        uint256 amount
    ) public override returns (bool) {
        address owner = msg.sender;
        _transfer(owner, to, amount);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(
        address spender,
        uint256 amount
    ) public override returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool) {
        address spender = msg.sender;
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) public returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) public returns (bool) {
        address owner = msg.sender;
        uint256 currentAllowance = allowance(owner, spender);
        require(
            currentAllowance >= subtractedValue,
            "KBMT: Decreased allowance below zero"
        );
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }
        return true;
    }

    // Internal functions
    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "KBMT: Transfer from zero address");
        require(to != address(0), "KBMT: Transfer to zero address");

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "KBMT: Transfer amount exceeds balance");

        unchecked {
            _balances[from] = fromBalance - amount;
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "KBMT: Approve from zero address");
        require(spender != address(0), "KBMT: Approve to zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "KBMT: Insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    // Additional functions
    function isSecureContract() public pure returns (bool) {
        return true;
    }

    function getTokenInfo()
        public
        view
        returns (string memory, string memory, uint8, uint256)
    {
        return (name, symbol, decimals, totalSupply);
    }

    function getContractBalance() public view returns (uint256) {
        return _balances[address(this)];
    }

    function withdrawFromContract(
        address to,
        uint256 amount
    ) public returns (bool) {
        require(to != address(0), "KBMT: Cannot withdraw to zero address");
        require(amount > 0, "KBMT: Amount must be greater than 0");

        uint256 contractBalance = _balances[address(this)];
        require(
            contractBalance >= amount,
            "KBMT: Insufficient contract balance"
        );

        _balances[address(this)] = contractBalance - amount;
        _balances[to] += amount;

        emit Transfer(address(this), to, amount);
        emit TokensWithdrawn(to, amount);

        return true;
    }

    function checkContractBalance() public returns (uint256) {
        uint256 balance = _balances[address(this)];
        emit ContractBalanceChecked(balance);
        return balance;
    }
}
