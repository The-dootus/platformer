Box = Entity:extend()

function Box:new(x, y)
    Box.super.new(self, x, y, "box.png")
    self.weight = 0
end