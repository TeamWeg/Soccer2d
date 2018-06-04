local Powerup = {
    x = 0,
    y = 0,
    radius = 0,
    used = false,
    color = {0, 0, 0},
    start_time = 0
}
Powerup.__index = Powerup

-- Powerups: boost, hook player to you, block goals, reverse controls, immovable ball, 

function Powerup:new(x, y)
    local p = {}
    setmetatable(p, Powerup)

    p.x = x
    p.y = y
    p.radius = 10
    p.used = false
    p.color = {255, 0, 0}
    p.start_time = 0

    return p
end

function Powerup:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Powerup:use(player1, player2)
    n = math.random(4)
    if n == 1 then
        --hook.update()
    elseif n == 2 then
        --block.update()
    elseif n == 3 then
        --reverse.update()
    else
        immovable.update(player1, player2)
    end
end

function Powerup:update(player1, player2)
    if self.used then
        self.color = {0, 0, 0}
        if (love.timer.getTime() - self.start_time) >= 5 then
            self.used = false
        end
    else
        self.color = {255, 0, 0}
        if func.check_collision_circle(self, player1) then
            player1.powerup_charges = player1.powerup_charges + 1
            self.used = true
            self.start_time = love.timer.getTime()
        end
        if func.check_collision_circle(self, player2) then
            player2.powerup_charges = player2.powerup_charges + 1
            self.used = true
            self.start_time = love.timer.getTime()
        end
    end
end

return Powerup