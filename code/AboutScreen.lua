AboutScreen = {}

function AboutScreen:new()

	local screen = display.newGroup()
	screen.stage = display.getCurrentStage()


	function screen:initialize()
		local backButton = self:getButton("button_back.png")
		self:insert(backButton)
		self.backButton = backButton
		backButton.x = 8
		backButton.y = 8

		local stage = self.stage
		local aboutImage = display.newImage("screen_about.png")
		aboutImage:setReferencePoint(display.TopLeftReferencePoint)
		self:insert(aboutImage)
		self.aboutImage = aboutImage
		aboutImage.x = (stage.width / 2) - (aboutImage.width / 2)
		aboutImage.y = 140

	end

	function screen:getButton(image)
		local img = display.newImage(image)
		img:setReferencePoint(display.TopLeftReferencePoint)
		function img:touch(event)
			screen:onButtonTouch(event)
		end
		img:addEventListener("touch", img)
		return img
	end

	function screen:onButtonTouch(event)
		if event.target == self.backButton and event.phase == "began" then
			Runtime:dispatchEvent({name="aboutScreenBackButtonTouched", target=screen})
			return true
		end
	end

	function screen:cancelTween(obj)
		if obj.tween ~= nil then
			transition.cancel(obj.tween)
			obj.tween = nil
		end
	end

	function screen:show()



		local backButton = self.backButton
		self:cancelTween(backButton)
		backButton.x = 20
		backButton.alpha = 1
		backButton.tween = transition.to(backButton, {transition=easing.outExpo, delay = 1300, time = 500, x = 8, onComplete = function()
			screen:cancelTween(backButton)
			end
		})

		local aboutImage = self.aboutImage
		self:cancelTween(aboutImage)
		aboutImage.alpha = 0
		aboutImage.tween = transition.to(aboutImage, {time = 1000, alpha = 1, onComplete = function()
			screen:cancelTween(aboutImage)
			end
		})
	end

	function screen:hide()
		local backButton = self.backButton
		backButton.tween = transition.to(backButton, {transition=easing.outExpo, time = 300, alpha = 0, onComplete = function()
			screen:cancelTween(backButton)
			end
		})

		local aboutImage = self.aboutImage
		aboutImage.tween = transition.to(aboutImage, {delay=10, transition=easing.outExpo, time = 400, alpha = 0, onComplete = function()
			screen:cancelTween(aboutImage)
			Runtime:dispatchEvent({name="aboutScreenHidden", target=screen})
			end
		})
	end

	screen:initialize()

	return screen

end

return AboutScreen