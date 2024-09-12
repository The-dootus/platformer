Wall = Entity:extend()

function Wall:new (x, y)
    Wall.super.new(self, x, y, "wall.png")
    self.strength = 100
    self.weight = 0
end