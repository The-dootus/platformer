Coin = Entity:extend()

function Coin:new (x, y)
    Coin.super.new(self, x, y, "dollar.png")
    self.weight = 0
    self.isCoin = true
end