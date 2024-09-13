Coin = Entity:extend()

function Coin:new (x, y)
    Coin.super.new(self, x, y, "dollar.png")
    self.strength = 100
    self.weight = 0
end