require("player")

function love.load()
    background = love.graphics.newImage("assets/background.png")
    Player:load()
end

function love.update(dt)
    Player:update(dt)

end

function love.draw()
    love.graphics.draw(background,0,0)
    Player:draw()
end
