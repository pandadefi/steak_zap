import pytest

from brownie import Contract, Zap

# optimism USDC
@pytest.fixture
def beefy():
    yield Contract("0x920ABfa9d1c99BE993e5399634C6D5e1bE55A3f4")


@pytest.fixture
def yearn():
    yield Contract("0x4C8b1958B09B3bde714f68864Bcc3a74Eaf1A23D")

@pytest.fixture
def zap(accounts):
    yield accounts[0].deploy(Zap)

@pytest.fixture
def user():
    yield "0x51262fe9f166a80aae0207c230a6639a256d556f" # Beefy vault holder

@pytest.fixture(scope="function", autouse=True)
def shared_setup(fn_isolation):
    pass
