function love.load()
    Object = require "classic"
    require "entity"
    require "player"
    require "wall"
    require "box"
    require "coin"
    require "enemy"
    player = Player(100, 100)
    wall = Wall(200, 100)
    box = Box(400, 150)
    coin = Coin(400, 150)
    enemy = Enemy(200, 100)
    objects = {}
    Coinscollected = 0
    table.insert(objects, player)
    table.insert(objects, enemy)

    walls = {}
    map = {
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,0,0,0,0,2,2,2,0,0,0,0,0,0,0,0,0,2,0,0,0,0,3,3,3,0,0,0,0,0,0,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,3,0,0,0,0,3,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,0,0,0,0,0,0,0,0,2,0,0,0,0,0,4,0,0,0,0,3,0,0,0,0,0,3,0,0,3,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,2,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0},
        {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    }
    for i,v in ipairs(map) do
        for j,w in ipairs(v) do
            if w == 1 then
                table.insert(objects, Wall((j-1)*50, (i-1)*50))
            end
            if w == 2 then
                table.insert(objects, Box((j-1)*50, (i-1)*50))
            end
            if w == 3 then
                table.insert(objects, Coin((j-1)*50, (i-1)*50))
            end
            if w == 4 then
                table.insert(objects, Enemy((j-1)*50, (i-1)*50))
                end
            end
        end
    end
function love.update(dt)
    for i,v in ipairs(objects) do
        v:update(dt)
        for i,v in ipairs(walls) do
            v:update(dt)
        end
    end
    for i = #objects, 1, -1 do
        local obj = objects[i]
        if obj ~= player and player:collidesWith(obj) then
            if obj.isCoin then
                table.remove(objects, i)
                Coinscollected = Coinscollected + 1
            end
        end
    end

    local loop = true
    local limit = 0

    while loop do
        -- Set loop to false, if no collision happened it will stay false
        loop = false

        limit = limit + 1
        if limit > 100 then
            -- Still not done at loop 100
            -- Break it because we're probably stuck in an endless loop.
            break
        end

        for i=1,#objects-1 do
            for j=i+1,#objects do
                local collision = objects[i]:resolveCollision(objects[j])
                if collision then
                    loop = true
                end
            end
        end
        for i,wall in ipairs(walls) do
            for j,object in ipairs(objects) do
                local collision = object:resolveCollision(wall)
                if collision then
                    loop = true
            end
        end
    end
end
end --sssssss
function love.draw()
    love.graphics.push()
    love.graphics.translate(-player.x + 400, -player.y + 300)
    -- Draw all the objects
    for i,v in ipairs(objects) do
        v:draw()
    end
    for i,v in ipairs(walls) do
        v:draw()
    end
    love.graphics.pop()
    love.graphics.print("Coins: " .. Coinscollected, 10, 10)
    love.graphics.print("Health: " .. player.health, 10, 20)
end

function love.keypressed(key)
    if key == "up" then
        player:jump()
    end
end