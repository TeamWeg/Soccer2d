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
    p.radius = 19
    p.used = false
    p.color = {255, 0, 0}
    p.start_time = 0
    p.img = love.graphics.newImage("assets/media/powerup.png")
    p.img2 = love.graphics.newImage("assets/media/powerup_gray.png")

    return p
end

function Powerup:update(player1, player2)
    n = 1
    if self.used then
        self.color = {0, 0, 0}
        if (love.timer.getTime() - self.start_time) >= 5 then
            self.used = false
        end
    else
        self.color = {255, 0, 0}
        if func.check_collision_circle(self, player1) and player1.powerup_charges < 1 then
            n = math.random(4)
            player1.powerup_type = n
            player1.powerup_charges = player1.powerup_charges + 1
            self.used = true
            self.start_time = love.timer.getTime()
        end
        if func.check_collision_circle(self, player2) and player2.powerup_charges < 1 then
            n = math.random(4)
            player2.powerup_type = n
            player2.powerup_charges = player2.powerup_charges + 1
            self.used = true
            self.start_time = love.timer.getTime()
        end
    end
end

function Powerup:draw()
    if self.used then
        love.graphics.draw(self.img2, self.x - self.radius, self.y - self.radius)
    else
        love.graphics.draw(self.img, self.x - self.radius, self.y - self.radius)
    end
end

return Powerup