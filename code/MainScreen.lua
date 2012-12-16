MainScreen = {}

function MainScreen:new()

	local screen = display.newGroup()
	screen.stage = display.getCurrentStage()

	function screen:initalize()
		local continueButton = self:getButton("button_continue.png")
		self.continueButton  = continueButton
		
		local newButton      = self:getButton("button_new.png")
		self.newButton       = newButton
		
		local aboutButton    = self:getButton("button_about.png")
		self.aboutButton     = aboutButton

	end

	function screen:getButton(image)
		local img = display.newImage(image)
		img:setReferencePoint(display.TopLeftReferencePoint)
		self:insert(img)
		function img:touch(event)
			screen:onButtonTouch(event)
		end
		img:addEventListener("touch", img)
		return img
	end

	function screen:onButtonTouch(event)
		local phase = event.phase
		local target = event.target
		if phase == "began" then
			if target == self.continueButton then
				Runtime:dispatchEvent({name="continueButtonTouched", target=screen})
			elseif target == self.newButton then
				Runtime:dispatchEvent({name="newButtonTouched", target=screen})
			elseif target == self.aboutButton then
				Runtime:dispatchEvent({name="aboutButtonTouched", target=screen})
			end
			return true
		end
	end

	function screen:show()
		local continueButton = self.continueButton
		local newButton      = self.newButton
		local aboutButton    = self.aboutButton
		local stage          = self.stage

		local stageMiddle 	= stage.width / 2
		continueButton.x 		= stageMiddle - (continueButton.width / 2)
		newButton.x				= stageMiddle - (newButton.width / 2)
		aboutButton.x			= stageMiddle - (aboutButton.width / 2)

		self:cancelTween(continueButton)
		self:cancelTween(newButton)
		self:cancelTween(aboutButton)

		continueButton.alpha = 0
		newButton.alpha = 0
		aboutButton.alpha = 0

		local TRANSITION_IN_TIME = 600
		local startY             = 40
		local delay              = 300

		continueButton.tween = transition.to(continueButton, {transition=easing.outExpo, y = startY, time = TRANSITION_IN_TIME, alpha = 1, onComplete = function()
			screen:cancelTween(continueButton)
		end
		})

		startY = startY + continueButton.height + 40

		newButton.tween = transition.to(newButton, {transition=easing.outExpo, delay = delay, y = startY, time = TRANSITION_IN_TIME, alpha = 1, onComplete = function()
			screen:cancelTween(newButton)
		end
		})

		startY = startY + continueButton.height + 40
		delay = delay + 300

		aboutButton.tween = transition.to(aboutButton, {transition=easing.outExpo, delay = delay, y = startY, time = TRANSITION_IN_TIME, alpha = 1, onComplete = function()
			screen:cancelTween(aboutButton)
		end
		})
	end

	function screen:cancelTween(obj)
		if obj.tween ~= nil then
			transition.cancel(obj.tween)
			obj.tween = nil
		end
	end


	function screen:hide()
		local continueButton = self.continueButton
		local newButton      = self.newButton
		local aboutButton    = self.aboutButton
		local stage          = self.stage

		local endY 			 = stage.height + 40
		local TRANSITION_OUT_TIME = 300
		local delay              = 100

		self:cancelTween(continueButton)
		self:cancelTween(newButton)
		self:cancelTween(aboutButton)

		continueButton.tween = transition.to(continueButton, {transition=easing.outExpo, y = endY, time = TRANSITION_OUT_TIME, alpha = 0, onComplete = function()
			screen:cancelTween(continueButton)
		end
		})

		newButton.tween = transition.to(newButton, {transition=easing.outExpo, delay = delay, y = endY, time = TRANSITION_OUT_TIME, alpha = 0, onComplete = function()
			screen:cancelTween(newButton)
		end
		})

		delay = delay + 100

		aboutButton.tween = transition.to(aboutButton, {transition=easing.outExpo, delay = delay, y = endY, time = TRANSITION_OUT_TIME, alpha = 0, onComplete = function()
			screen:cancelTween(aboutButton)
			Runtime:dispatchEvent({name="mainScreenHidden", target=screen})
		end
		})

	end

	screen:initalize()

	return screen
end


return MainScreen