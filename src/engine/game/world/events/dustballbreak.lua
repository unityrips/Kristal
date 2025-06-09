---@class DustBallBreak : Object
local DustBallBreak, super = Class(Object)

function DustBallBreak:init(x, y)
    super.init(self, x, y)

    self.sprite = Sprite("world/events/dustball_break")
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.timer = 0
end

function DustBallBreak:update()
    super.update(self)
    self.timer = self.timer + DT * 60

    if self.timer < 30 then
        self.sprite:setFrame((self.timer / 30) * 4)
    elseif self.timer < 40 then
        self.sprite:setFrame(3)
        self.sprite.alpha = self.sprite.alpha - 0.1
    else
        self:remove()
    end
end

return DustBallBreak
