
local function testMainScreen()
	require "MainScreen"
	local mainScreen = MainScreen:new()
	mainScreen:show()
	local touchHandler = function(e)
		print("name: ", e.name)
	end

	Runtime:addEventListener("continueButtonTouched", touchHandler)
	Runtime:addEventListener("aboutButtonTouched", touchHandler)
	Runtime:addEventListener("newButtonTouched", touchHandler)

	--local t = {}
	--function t:timer(event)
	--	mainScreen:hide()
	--end
	--timer.performWithDelay(2 * 1000, t)
end

local function testAboutScreen()
	require "AboutScreen"
	local screen = AboutScreen:new()
	screen:show()
	--Runtime:addEventListener("aboutScreenBackButtonTouched", function()
	--	print("dude, you touched the back button")
	--	end
	--)

	--local t = {}
	--function t:timer(event)
	--	screen:hide()
	--end
	--timer.performWithDelay(2 * 1000, t)
end

local function test2ScreenTransition()
	require "MainScreen"
	require "AboutScreen"

	local mainScreen = MainScreen:new()
	local aboutScreen = AboutScreen:new()
	aboutScreen.isVisible = false
	aboutScreen.x = -999
	aboutScreen.y = -999

	mainScreen:show()

	Runtime:addEventListener("aboutButtonTouched", function(e)
		mainScreen.tween = transition.to(mainScreen, {time = 500, x = 300, alpha = 0})
		mainScreen:hide()
	end)

	Runtime:addEventListener("mainScreenHidden", function(e)
		aboutScreen.x = 0
		aboutScreen.y = 0
		aboutScreen.isVisible = true
		aboutScreen.alpha = 1
		aboutScreen:show()
	end)

	Runtime:addEventListener("aboutScreenBackButtonTouched", function(e)
		aboutScreen.tween = transition.to(aboutScreen, {time = 500, x = 300, alpha = 0})
		aboutScreen:hide()
	end)

	Runtime:addEventListener("aboutScreenHidden", function(e)
		mainScreen.x = 0
		mainScreen.y = 0
		mainScreen.alpha = 1
		mainScreen:show()
	end)


end


--testMainScreen()
--testAboutScreen()
test2ScreenTransition()