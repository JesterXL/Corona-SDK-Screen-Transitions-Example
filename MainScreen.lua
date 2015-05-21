local MainScreen = {}

function MainScreen:new()

	local screen = {}
	local statebutton
	local monthbutton

	function screen:initialize()
		--local background = display.newImage("blue.jpg")
		--local logo = display.newImage("black.png")
		statebutton = self:getButton("statebutton.png")
		self.statebutton = statebutton
		--local xor = display.newImage("or.png")
		monthbutton = self:getButton("monthbutton.png")
		self.monthbutton = monthbutton

		statebutton.x = 100
		statebutton.y = 100

		monthbutton.x = 100
		monthbutton.y = 200

	end 

	function screen:getButton(image)
		local img = display.newImage(image)
		function img:touch(event)
			-- only tell us when the button was let go
			if event.phase == 'ended' then
				-- pass the image we clicked on
				screen:onButtonTouch(img)
			end
		end
		img:addEventListener("touch", img)
		return img
	end

	function screen:onButtonTouch(button)
		-- identify which button was touched
		if button == statebutton then
			print "state button"
		elseif button == monthbutton then
			print "month button"
		end
	end

	function screen:show()

	end

	function screen:hide()

	end

	screen:initialize()

	return screen
end


return MainScreen