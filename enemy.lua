Enemy = Entity:extend()

function Enemy:new(x, y)
    Enemy.super.new(self, x, y, "enemy.png")
    self.strength = 10
end
function Enemy:checkResolve(e, direction)
    if e:is(Box) then
        if direction == "bottom" then
            return true
        elseif direction == "top" then
            return false
        else
            return false
        end
    end
    return true
end