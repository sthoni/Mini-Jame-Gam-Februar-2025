local CollisionObject = Object:extend()

function CollisionObject:new(x, y)
	self.collisionshape = Collider:circle(x, y, 6)
end

function CollisionObject:update(dt, x, y)
	self.collisionshape:moveTo(x, y)
	-- for shape, delta in pairs(Collider:collisions(self.collisionshape)) do
    -- 	print(shape)
	-- 	print(shape._center.x)
		
		-- player.collision_move(delta.x, delta.y)
	-- end
end

function CollisionObject:draw()
	love.graphics.setColor(255,255,255)
	self.collisionshape:draw('fill')
end

return CollisionObject
