---@class DustPile : Event
---@field sprite Sprite
---@field siner number
---@field busted boolean
---@field bust_timer Timer
local DustPile, super = Class(Event, "dustpile")

function DustPile:init(x, y, properties)
    super.init(self, x, y)

    self:setOrigin(0.5, 1)
    self:setScale(2)

    self.sprite = Sprite("world/events/dustpile")
    self:addChild(self.sprite)

    self:setSize(self.sprite:getSize())
    self:setHitbox(0, 0, self.width, self.height)

    self.siner = 0
    self.busted = false
end

function DustPile:onAdd(parent)
    super.onAdd(self, parent)
    self.world.timer:after(0.2, function()
        self:spawnDustball()
    end)
end

function DustPile:spawnDustball()
    if not self.busted then
        local dustball = DustBall(60, 20)
        self:addChild(dustball)
    end
end

function DustPile:update()
    super.update(self)
    self.siner = self.siner + 1 * DT

    -- shake & play sound & break effect
    if not self.busted and Game.interact then
        Game.world:spawnObject(ShakeEffect())
        Assets.playSound("cough")
        self.busted = true

        for i = 0, 11 do
            local x_off = 20 + (i * 6)
            local y_off = 20 + Utils.random(25)
            local piece = DustBallBreak(x_off, y_off)
            self:addChild(piece)
        end
    end
end

function DustPile:draw()
    super.draw(self)

    Draw.setColor(1, 1, 1, self.sprite.alpha)
    Draw.drawSprite("world/events/dustpile_parts", 3, self.x, self.y, 2, 2)

    if not self.busted then
        local s = self.siner
        Draw.drawSprite("world/events/dustpile_parts", 2, self.x - math.sin(s/5), self.y + math.sin(s/5), 2, 2)
        Draw.drawSprite("world/events/dustpile_parts", 1, self.x + math.cos(s/5), self.y + math.sin(s/5) + 1, 2, 2)
        Draw.drawSprite("world/events/dustpile_parts", 0, self.x + math.sin(s/5), self.y + math.sin(s/5), 2, 2)
    end
end

return DustPile
