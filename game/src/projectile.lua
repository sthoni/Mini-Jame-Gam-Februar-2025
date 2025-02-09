-- WeaponComponent des Spielers lässt Projectile spawnen
-- Projectile kriegt Position des Spielers und Blickrichtung
-- Projectile drawt sich
-- Projectile wird nach Kollision oder Zeit zerstört

local projectile_tilemap = love.graphics.newImage("assets/tiles.png")
local projectiles = {}

local function Projectile()
	return {
		new = function(damage, speed, positionX, positionY, angle, spriteX, spriteY, spriteWidth, spriteHeight)
			local quad = love.graphics.newQuad(spriteX, spriteY, spriteWidth, spriteHeight, projectile_tilemap)
			if quad then
				table.insert(projectiles, {
					quad = quad,
					x = positionX,
					y = positionY,
					width = spriteWidth,
					height = spriteHeight,
					angle = angle,
					damage = damage,
					speed = speed,
				})
			end
		end,
		update = function(self, dt)
			for key, projectile in pairs(projectiles) do
				local x_vel = projectile.speed * math.cos(projectile.angle - math.pi / 2) * dt
				local y_vel = projectile.speed * math.sin(projectile.angle - math.pi / 2) * dt
				projectile.x = projectile.x + x_vel
				projectile.y = projectile.y + y_vel
				if math.abs(player.x - projectile.x) > 400 then
					projectiles[key] = nil
				end
			end
		end,
		draw = function(self)
			for _, projectile in pairs(projectiles) do
				love.graphics.draw(projectile_tilemap, projectile.quad, projectile.x, projectile.y, projectile.angle)
			end
		end
	}
end

return Projectile
