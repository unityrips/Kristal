---@class DustBall : Object
local DustBall, super = Class(Object)

function DustBall:init(x, y)
    super.init(self, x, y)

    self.sprite = Sprite("world/events/dustball")
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.timer = 0
end

function DustBall:update()
    super.update(self)
    self.timer = self.timer + DT

    local t = self.timer * 60
    self.sprite:setFrame(1 + ((t * 1.5) / 55))

    self.x = self.x + (math.sin(t / 5) * 0.4) + 1.6
    self.y = self.y + math.cos(t / 3.5) - 0.8

    if t >= 55 then
        self:remove()
    end
end

return DustBall
