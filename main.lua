Object = require 'libraries/classic/classic'
require 'objects/test'
Timer = require 'libraries/hump/timer'
Moses = require 'libraries/moses/moses'
function love.load()
    image = love.graphics.newImage("snubbe.png")
    dudePosX = 0;
    dudePosY = 0;
    
    timer = Timer()

    Lynput = require("libraries/Lynput/Lynput") -- Load Lynput
    Lynput.load_key_callbacks() -- Load keyboard callbacks
    Lynput.load_mouse_callbacks()
    control = Lynput() -- Create a Lynput object
    
    control:bind("action", "press d")
    control:bind("obey", "release f")
    control:bind("click", "press LMB")
    control:bind("clickHold", "hold LMB")
    control:bind("clickRelease", "release LMB")
    control:bind("expand", "press e")
    control:bind("shrink", "press s")


    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    circle = Circle(50,50, 24)
    hCircle = HyperCircle(500, 500, 50, 50, 10)

    rect_1 = {x = 400, y = 300, w = 200, h = 50}
    rect_2 = {x = 400, y = 300, w = 200, h = 50}

    --timer:after(1, function(f)
    --    timer:tween(1, hCircle, {outer_radius = 100}, 'in-out-cubic', function()
    --        timer:tween(1, hCircle, {outer_radius=50}, 'in-out-cubic')
    --     end)
    --    timer:after(1,f)
    --end)

end

function love.update(dt)
    timer:update(dt)
    dudePosX = dudePosX + 1
    dudePosY = dudePosY + 1

    if control.action       then triggerAction()        end
    if control.obey         then obey()                 end
    if control.click        then print('LMB pressed')   end
    if control.clickHold    then print('LMB held')      end
    if control.expand       then expand()               end
    if control.shrink       then shrink()               end
    Lynput.update_(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(0.8,0.8,0.8)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(image, dudePosX, dudePosY);
    circle:draw()
    hCircle:draw()

    love.graphics.setColor(1,0.5,0.5)
    love.graphics.rectangle('fill', rect_1.x, rect_1.y, rect_1.w, rect_1.h)
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle('fill', rect_2.x, rect_2.y, rect_2.w, rect_2.h)
    

end

function expand()
    if(handle_shr)
    then
        timer:cancel(handle_shr)
    end
    handle_exp = timer:tween(1, hCircle, {outer_radius = 100}, 'in-out-cubic')
end

function shrink()
    if(handle_exp)
    then
        timer:cancel(handle_exp)
    end
    handle_shr = timer:tween(1, hCircle, {outer_radius = 50}, 'in-out-cubic')
end


function triggerAction()
    print(rect_2.w)
    if(rect_2.w -200*0.25 > 0 and rect_1.w -200*0.25)
    then
    timer:tween(0.5, rect_2, {w= rect_2.w -200*0.25}, 'in-out-cubic')
    timer:tween(1, rect_1, {w= rect_1.w -200*0.25}, 'in-out-cubic')
    end
end

function obey()
    print('key released')
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