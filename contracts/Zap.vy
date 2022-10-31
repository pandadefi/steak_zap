# @version 0.3.7

from vyper.interfaces import ERC20

interface BeefyVault:
    def want() -> address: view
    def balanceOf(owner: address) -> uint256: view
    def allowance(owner: address, spender: address) -> uint256: view
    def transferFrom(owner: address, recipient: address, amount: uint256): nonpayable
    def withdrawAll() : nonpayable

interface Vault:
    def token() -> address: view
    def deposit(amount: uint256, beneficiary: address) -> uint256: nonpayable

@external
def zap(_from: address, _to: address, _amount: uint256 = MAX_UINT256) -> uint256:
    token: address = Vault(_to).token()
    assert BeefyVault(_from).want() == token

    amount: uint256 = _amount
    if amount == MAX_UINT256:
        amount = min(BeefyVault(_from).balanceOf(msg.sender), BeefyVault(_from).allowance(msg.sender, self))
    BeefyVault(_from).transferFrom(msg.sender, self, amount)
    BeefyVault(_from).withdrawAll()
    bal: uint256 = ERC20(token).balanceOf(self)
    ERC20(token).approve(_to, amount)
    return Vault(_to).deposit(amount, msg.sender)
