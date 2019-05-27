function love.load()
    image = love.graphics.newImage("snubbe.png")
    dudePosX = 0;
    dudePosY = 0;
end

function love.update()
    dudePosX = dudePosX + 1
    dudePosY = dudePosY + 1
end

function love.draw()
    love.graphics.draw(image, dudePosX, dudePosY);
end
