Object = require 'libraries/classic/classic'
require 'objects/test'

function love.load()
    image = love.graphics.newImage("snubbe.png")
    dudePosX = 0;
    dudePosY = 0;

    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    circle = Circle(500,500, 50)
    hCircle = HyperCircle(400, 300, 50, 120, 10)
end

function love.update()
    dudePosX = dudePosX + 1
    dudePosY = dudePosY + 1
end

function love.draw()
    love.graphics.draw(image, dudePosX, dudePosY);
    circle:draw()
    hCircle:draw()
end

function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.getInfo(file) then
            table.insert(file_list, file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file, file_list)
        end
    end
end

function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end