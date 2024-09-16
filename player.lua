Player = Entity:extend()
function Player:new (x, y)
    Player.super.new(self, x, y, "player.png")
    self.strength = 10
    self.canJump = true
    self.health = 100
end

function Player:update(dt)
    Player.super.update(self, dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - 200 * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + 200 * dt
    end
    if self.health <= 0 then
        
    end
    if self.y > love.graphics.getHeight() then
        love.load()
    end
end
    function Player:jump()
        if self.canJump then
        self.gravity = -300
        self.canJump = false
        end
    end

    function Player:collide(e, direction)
        Player.super.collide(self, e, direction)
        if direction == "bottom" then
            self.canJump = true
        end
        end

        function Player:checkResolve(e, direction)
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
        function checkCollision(a, b)
            return a.x < b.x + b.width and
                   a.x + a.width > b.x and
                   a.y < b.y + b.height and
                   a.y + a.height > b.y
        end
        
        function Player:collidesWith(other)
            return checkCollision(self, other)
        end
        function Player:takeDamage()
            if Player:collidesWith(enemy) then
            self.health = self.health - 50
        end
    end