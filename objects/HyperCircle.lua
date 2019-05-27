HyperCircle = Circle:extend()

function HyperCircle:new(x, y, radius, outer_radius ,linewidth)
    HyperCircle.super.new(self, x, y, radius)
    creation_time = love.timer.getTime()
    self.linewidth = linewidth or 0
    self.outer_radius = outer_radius or 0
end

function HyperCircle:draw()
    love.graphics.setColor(0, 1, 1)
    love.graphics.circle("fill", self.x, self.y,self.radius)
    love.graphics.setLineWidth(self.linewidth)
    love.graphics.circle("line", self.x, self.y,self.outer_radius)
    
end