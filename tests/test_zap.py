

def test_zap(user, beefy, yearn, zap):
    amount = 10**6
    beefy.approve(zap, amount, {"from": user})
    assert yearn.balanceOf(user) == 0
    zap.zap(beefy, yearn, {"from": user})
    assert yearn.balanceOf(user) != 0
