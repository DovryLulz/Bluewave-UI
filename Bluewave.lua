-- Bluewave UI Library, By Pixelated and DovryLulz
-- Made With TUFF AURA


local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Bluewave = {}

-- Theme Configuration
local Theme = {
	Background = Color3.fromRGB(15, 20, 35),
	Surface = Color3.fromRGB(20, 28, 45),
	Primary = Color3.fromRGB(45, 85, 165),
	Secondary = Color3.fromRGB(35, 65, 125),
	Accent = Color3.fromRGB(65, 125, 255),
	Text = Color3.fromRGB(220, 230, 240),
	TextSecondary = Color3.fromRGB(160, 180, 200),
	Border = Color3.fromRGB(40, 60, 95),
	Success = Color3.fromRGB(45, 175, 95),
	Warning = Color3.fromRGB(255, 165, 45),
	Error = Color3.fromRGB(255, 85, 85)
}

-- Utility Functions
local function CreateTween(object, properties, duration, easingStyle, easingDirection)
	duration = duration or 0.3
	easingStyle = easingStyle or Enum.EasingStyle.Quart
	easingDirection = easingDirection or Enum.EasingDirection.Out
	local tween = TweenService:Create(object, TweenInfo.new(duration, easingStyle, easingDirection), properties)
	tween:Play()
	return tween
end

local function CreateCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 8)
	corner.Parent = parent
	return corner
end

local function CreateStroke(parent, color, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or Theme.Border
	stroke.Thickness = thickness or 1
	stroke.Parent = parent
	return stroke
end

local function CreateGradient(parent, colors, rotation)
	local gradient = Instance.new("UIGradient")
	gradient.Color = colors or ColorSequence.new {
		ColorSequenceKeypoint.new(0, Theme.Primary),
		ColorSequenceKeypoint.new(1, Theme.Secondary)
	}
	gradient.Rotation = rotation or 45
	gradient.Parent = parent
	return gradient
end

-- Main Window Creation
function Bluewave:CreateWindow(config)
	config = config or {}
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = config.Name or "BluewaveUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = PlayerGui

	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.new(0, 600, 0, 400)
	mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
	mainFrame.BackgroundColor3 = Theme.Background
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui

	CreateCorner(mainFrame, 12)
	CreateStroke(mainFrame, Theme.Border, 2)

	local titleBar = Instance.new("Frame")
	titleBar.Name = "TitleBar"
	titleBar.Size = UDim2.new(1, 0, 0, 50)
	titleBar.Position = UDim2.new(0, 0, 0, 0)
	titleBar.BackgroundColor3 = Theme.Surface
	titleBar.BorderSizePixel = 0
	titleBar.Parent = mainFrame

	CreateCorner(titleBar, 12)
	CreateGradient(titleBar)

	local titleText = Instance.new("TextLabel")
	titleText.Name = "TitleText"
	titleText.Size = UDim2.new(1, -100, 1, 0)
	titleText.Position = UDim2.new(0, 15, 0, 0)
	titleText.BackgroundTransparency = 1
	titleText.Text = config.Title or "Bluewave UI"
	titleText.TextColor3 = Theme.Text
	titleText.TextSize = 18
	titleText.TextXAlignment = Enum.TextXAlignment.Left
	titleText.Font = Enum.Font.GothamBold
	titleText.Parent = titleBar

	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0, 30, 0, 30)
	closeButton.Position = UDim2.new(1, -40, 0, 10)
	closeButton.BackgroundColor3 = Theme.Error
	closeButton.Text = "×"
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.TextSize = 20
	closeButton.Font = Enum.Font.GothamBold
	closeButton.BorderSizePixel = 0
	closeButton.Parent = titleBar

	CreateCorner(closeButton, 6)

	local minimizeButton = Instance.new("TextButton")
	minimizeButton.Name = "MinimizeButton"
	minimizeButton.Size = UDim2.new(0, 30, 0, 30)
	minimizeButton.Position = UDim2.new(1, -75, 0, 10)
	minimizeButton.BackgroundColor3 = Theme.Warning
	minimizeButton.Text = "−"
	minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	minimizeButton.TextSize = 20
	minimizeButton.Font = Enum.Font.GothamBold
	minimizeButton.BorderSizePixel = 0
	minimizeButton.Parent = titleBar

	CreateCorner(minimizeButton, 6)

	local navContainer = Instance.new("Frame")
	navContainer.Name = "Navigation"
	navContainer.Size = UDim2.new(0, 180, 1, -50)
	navContainer.Position = UDim2.new(0, 0, 0, 50)
	navContainer.BackgroundColor3 = Theme.Surface
	navContainer.BorderSizePixel = 0
	navContainer.Parent = mainFrame

	CreateCorner(navContainer, 8)
	CreateStroke(navContainer, Theme.Border)

	local contentContainer = Instance.new("Frame")
	contentContainer.Name = "Content"
	contentContainer.Size = UDim2.new(1, -190, 1, -60)
	contentContainer.Position = UDim2.new(0, 190, 0, 60)
	contentContainer.BackgroundTransparency = 1
	contentContainer.BorderSizePixel = 0
	contentContainer.Parent = mainFrame

	local navList = Instance.new("ScrollingFrame")
	navList.Name = "NavList"
	navList.Size = UDim2.new(1, -10, 1, -10)
	navList.Position = UDim2.new(0, 5, 0, 5)
	navList.BackgroundTransparency = 1
	navList.BorderSizePixel = 0
	navList.ScrollBarThickness = 4
	navList.ScrollBarImageColor3 = Theme.Accent
	navList.CanvasSize = UDim2.new(0, 0, 0, 0)
	navList.Parent = navContainer

	local navLayout = Instance.new("UIListLayout")
	navLayout.SortOrder = Enum.SortOrder.LayoutOrder
	navLayout.Padding = UDim.new(0, 5)
	navLayout.Parent = navList

	local Window = {
		ScreenGui = screenGui,
		MainFrame = mainFrame,
		TitleBar = titleBar,
		Navigation = navContainer,
		Content = contentContainer,
		NavList = navList,
		Tabs = {},
		CurrentTab = nil,
		Visible = true
	}

	-- Dragging functionality with bounds checking
	local dragging, dragStart, startPos
	local viewportSize = workspace.CurrentCamera.ViewportSize

	titleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = mainFrame.Position
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			local newX = math.clamp(startPos.X.Offset + delta.X, -startPos.X.Offset, viewportSize.X - mainFrame.Size.X.Offset)
			local newY = math.clamp(startPos.Y.Offset + delta.Y, -startPos.Y.Offset, viewportSize.Y - mainFrame.Size.Y.Offset)
			mainFrame.Position = UDim2.new(0, newX, 0, newY)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	-- Close button
	closeButton.MouseButton1Click:Connect(function()
		CreateTween(mainFrame, { Size = UDim2.new(0, 0, 0, 0) }, 0.3)
		task.wait(0.3)
		screenGui:Destroy()
	end)

	-- Minimize functionality
	local minimized = false
	minimizeButton.MouseButton1Click:Connect(function()
		if minimized then
			CreateTween(mainFrame, { Size = UDim2.new(0, 600, 0, 400) }, 0.3)
			minimizeButton.Text = "−"
			navContainer.Visible = true
			contentContainer.Visible = true
			minimized = false
		else
			CreateTween(mainFrame, { Size = UDim2.new(0, 600, 0, 50) }, 0.3)
			minimizeButton.Text = "+"
			navContainer.Visible = false
			contentContainer.Visible = false
			minimized = true
		end
	end)

	-- Button hover effects
	for _, button in pairs({ closeButton, minimizeButton }) do
		button.MouseEnter:Connect(function()
			CreateTween(button, { Size = UDim2.new(0, 35, 0, 35) }, 0.2)
		end)
		button.MouseLeave:Connect(function()
			CreateTween(button, { Size = UDim2.new(0, 30, 0, 30) }, 0.2)
		end)
	end

	-- Update canvas size
	navLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		navList.CanvasSize = UDim2.new(0, 0, 0, navLayout.AbsoluteContentSize.Y + 10)
	end)

	-- Keybind to toggle UI visibility
	if config.Keybind then
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.KeyCode == config.Keybind then
				Window.Visible = not Window.Visible
				mainFrame.Visible = Window.Visible
			end
		end)
	end

	return Window
end

-- Tab Creation
function Bluewave:CreateTab(window, config)
	config = config or {}
	local tabButton = Instance.new("TextButton")
	tabButton.Name = config.Name or "Tab"
	tabButton.Size = UDim2.new(1, -10, 0, 40)
	tabButton.BackgroundColor3 = Theme.Primary
	tabButton.Text = config.Name or "Tab"
	tabButton.TextColor3 = Theme.Text
	tabButton.TextSize = 14
	tabButton.Font = Enum.Font.Gotham
	tabButton.BorderSizePixel = 0
	tabButton.Parent = window.NavList

	CreateCorner(tabButton, 6)

	local tabContent = Instance.new("ScrollingFrame")
	tabContent.Name = config.Name or "Tab"
	tabContent.Size = UDim2.new(1, -10, 1, -10)
	tabContent.Position = UDim2.new(0, 5, 0, 5)
	tabContent.BackgroundTransparency = 1
	tabContent.BorderSizePixel = 0
	tabContent.ScrollBarThickness = 4
	tabContent.ScrollBarImageColor3 = Theme.Accent
	tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
	tabContent.Visible = false
	tabContent.Parent = window.Content

	local contentLayout = Instance.new("UIListLayout")
	contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
	contentLayout.Padding = UDim.new(0, 10)
	contentLayout.Parent = tabContent

	local contentPadding = Instance.new("UIPadding")
	contentPadding.PaddingTop = UDim.new(0, 10)
	contentPadding.PaddingBottom = UDim.new(0, 10)
	contentPadding.PaddingLeft = UDim.new(0, 10)
	contentPadding.PaddingRight = UDim.new(0, 10)
	contentPadding.Parent = tabContent

	local Tab = {
		Button = tabButton,
		Content = tabContent,
		Layout = contentLayout,
		Window = window
	}

	-- Tab switching
	tabButton.MouseButton1Click:Connect(function()
		for _, tab in pairs(window.Tabs) do
			tab.Content.Visible = false
			tab.Button.BackgroundColor3 = Theme.Primary
		end
		tabContent.Visible = true
		tabButton.BackgroundColor3 = Theme.Accent
		window.CurrentTab = Tab
	end)

	-- Hover effects
	tabButton.MouseEnter:Connect(function()
		if window.CurrentTab ~= Tab then
			CreateTween(tabButton, { BackgroundColor3 = Theme.Secondary }, 0.2)
		end
	end)

	tabButton.MouseLeave:Connect(function()
		if window.CurrentTab ~= Tab then
			CreateTween(tabButton, { BackgroundColor3 = Theme.Primary }, 0.2)
		end
	end)

	-- Auto-select first tab
	if #window.Tabs == 0 then
		tabContent.Visible = true
		tabButton.BackgroundColor3 = Theme.Accent
		window.CurrentTab = Tab
	end

	table.insert(window.Tabs, Tab)

	-- Update canvas size
	contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
	end)

	return Tab
end

-- Button Creation
function Bluewave:CreateButton(tab, config)
	config = config or {}
	local button = Instance.new("TextButton")
	button.Name = config.Name or "Button"
	button.Size = UDim2.new(1, 0, 0, 40)
	button.BackgroundColor3 = Theme.Surface
	button.Text = config.Text or "Button"
	button.TextColor3 = Theme.Text
	button.TextSize = 14
	button.Font = Enum.Font.Gotham
	button.BorderSizePixel = 0
	button.Parent = tab.Content

	CreateCorner(button, 8)
	CreateStroke(button, Theme.Border)

	-- Click animation and callback
	button.MouseButton1Click:Connect(function()
		CreateTween(button, { Size = UDim2.new(1, 0, 0, 35) }, 0.1)
		task.wait(0.1)
		CreateTween(button, { Size = UDim2.new(1, 0, 0, 40) }, 0.1)
		if config.Callback then
			config.Callback()
		end
	end)

	-- Hover effects
	button.MouseEnter:Connect(function()
		CreateTween(button, { BackgroundColor3 = Theme.Primary }, 0.2)
	end)

	button.MouseLeave:Connect(function()
		CreateTween(button, { BackgroundColor3 = Theme.Surface }, 0.2)
	end)

	return button
end

-- Toggle Creation
function Bluewave:CreateToggle(tab, config)
	config = config or {}
	local toggleFrame = Instance.new("Frame")
	toggleFrame.Name = config.Name or "Toggle"
	toggleFrame.Size = UDim2.new(1, 0, 0, 50)
	toggleFrame.BackgroundColor3 = Theme.Surface
	toggleFrame.BorderSizePixel = 0
	toggleFrame.Parent = tab.Content

	CreateCorner(toggleFrame, 8)
	CreateStroke(toggleFrame, Theme.Border)

	local toggleLabel = Instance.new("TextLabel")
	toggleLabel.Size = UDim2.new(1, -70, 1, 0)
	toggleLabel.Position = UDim2.new(0, 15, 0, 0)
	toggleLabel.BackgroundTransparency = 1
	toggleLabel.Text = config.Text or "Toggle"
	toggleLabel.TextColor3 = Theme.Text
	toggleLabel.TextSize = 14
	toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
	toggleLabel.Font = Enum.Font.Gotham
	toggleLabel.Parent = toggleFrame

	local toggleButton = Instance.new("TextButton")
	toggleButton.Size = UDim2.new(0, 50, 0, 30)
	toggleButton.Position = UDim2.new(1, -60, 0, 10)
	toggleButton.BackgroundColor3 = Theme.Primary
	toggleButton.Text = ""
	toggleButton.BorderSizePixel = 0
	toggleButton.Parent = toggleFrame

	CreateCorner(toggleButton, 15)

	local toggleIndicator = Instance.new("Frame")
	toggleIndicator.Size = UDim2.new(0, 22, 0, 22)
	toggleIndicator.Position = UDim2.new(0, 4, 0, 4)
	toggleIndicator.BackgroundColor3 = Theme.Text
	toggleIndicator.BorderSizePixel = 0
	toggleIndicator.Parent = toggleButton

	CreateCorner(toggleIndicator, 11)

	local enabled = config.Default or false

	local function updateToggle()
		if enabled then
			CreateTween(toggleButton, { BackgroundColor3 = Theme.Success }, 0.3)
			CreateTween(toggleIndicator, { Position = UDim2.new(0, 24, 0, 4) }, 0.3)
		else
			CreateTween(toggleButton, { BackgroundColor3 = Theme.Primary }, 0.3)
			CreateTween(toggleIndicator, { Position = UDim2.new(0, 4, 0, 4) }, 0.3)
		end
		if config.Callback then
			config.Callback(enabled)
		end
	end

	toggleButton.MouseButton1Click:Connect(function()
		enabled = not enabled
		updateToggle()
	end)

	updateToggle()

	return {
		Frame = toggleFrame,
		SetValue = function(value)
			enabled = value
			updateToggle()
		end,
		GetValue = function()
			return enabled
		end
	}
end

-- Slider Creation
function Bluewave:CreateSlider(tab, config)
	config = config or {}
	local sliderFrame = Instance.new("Frame")
	sliderFrame.Name = config.Name or "Slider"
	sliderFrame.Size = UDim2.new(1, 0, 0, 70)
	sliderFrame.BackgroundColor3 = Theme.Surface
	sliderFrame.BorderSizePixel = 0
	sliderFrame.Parent = tab.Content

	CreateCorner(sliderFrame, 8)
	CreateStroke(sliderFrame, Theme.Border)

	local sliderLabel = Instance.new("TextLabel")
	sliderLabel.Size = UDim2.new(1, -15, 0, 25)
	sliderLabel.Position = UDim2.new(0, 15, 0, 5)
	sliderLabel.BackgroundTransparency = 1
	sliderLabel.Text = config.Text or "Slider"
	sliderLabel.TextColor3 = Theme.Text
	sliderLabel.TextSize = 14
	sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
	sliderLabel.Font = Enum.Font.Gotham
	sliderLabel.Parent = sliderFrame

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(0, 60, 0, 25)
	valueLabel.Position = UDim2.new(1, -75, 0, 5)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(config.Default or config.Min or 0)
	valueLabel.TextColor3 = Theme.Accent
	valueLabel.TextSize = 14
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.Parent = sliderFrame

	local sliderTrack = Instance.new("Frame")
	sliderTrack.Size = UDim2.new(1, -30, 0, 6)
	sliderTrack.Position = UDim2.new(0, 15, 0, 40)
	sliderTrack.BackgroundColor3 = Theme.Primary
	sliderTrack.BorderSizePixel = 0
	sliderTrack.Parent = sliderFrame

	CreateCorner(sliderTrack, 3)

	local sliderFill = Instance.new("Frame")
	sliderFill.Size = UDim2.new(0, 0, 1, 0)
	sliderFill.Position = UDim2.new(0, 0, 0, 0)
	sliderFill.BackgroundColor3 = Theme.Accent
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderTrack

	CreateCorner(sliderFill, 3)

	local sliderButton = Instance.new("TextButton")
	sliderButton.Size = UDim2.new(0, 16, 0, 16)
	sliderButton.Position = UDim2.new(0, -8, 0, -5)
	sliderButton.BackgroundColor3 = Theme.Text
	sliderButton.Text = ""
	sliderButton.BorderSizePixel = 0
	sliderButton.Parent = sliderTrack

	CreateCorner(sliderButton, 8)

	local minValue = config.Min or 0
	local maxValue = config.Max or 100
	local currentValue = math.clamp(config.Default or minValue, minValue, maxValue)

	local function updateSlider(value)
		currentValue = math.clamp(value, minValue, maxValue)
		local percentage = (currentValue - minValue) / (maxValue - minValue)
		CreateTween(sliderFill, { Size = UDim2.new(percentage, 0, 1, 0) }, 0.1)
		CreateTween(sliderButton, { Position = UDim2.new(percentage, -8, 0, -5) }, 0.1)
		valueLabel.Text = tostring(math.floor(currentValue))
		if config.Callback then
			config.Callback(currentValue)
		end
	end

	local dragging = false
	sliderButton.MouseButton1Down:Connect(function()
		dragging = true
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local mousePos = UserInputService:GetMouseLocation()
			local trackPos = sliderTrack.AbsolutePosition.X
			local trackSize = sliderTrack.AbsoluteSize.X
			local percentage = math.clamp((mousePos.X - trackPos) / trackSize, 0, 1)
			local newValue = minValue + (percentage * (maxValue - minValue))
			updateSlider(newValue)
		end
	end)

	updateSlider(currentValue)

	return {
		Frame = sliderFrame,
		SetValue = function(value)
			updateSlider(value)
		end,
		GetValue = function()
			return currentValue
		end
	}
end

-- Label Creation
function Bluewave:CreateLabel(tab, config)
	config = config or {}
	local label = Instance.new("TextLabel")
	label.Name = config.Name or "Label"
	label.Size = UDim2.new(1, 0, 0, 30)
	label.BackgroundTransparency = 1
	label.Text = config.Text or "Label"
	label.TextColor3 = config.Color or Theme.TextSecondary
	label.TextSize = config.Size or 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Font = Enum.Font.Gotham
	label.Parent = tab.Content

	return label
end

-- Notification System
function Bluewave:Notify(config)
	config = config or {}
	local notifGui = Instance.new("ScreenGui")
	notifGui.Name = "BluewaveNotification"
	notifGui.Parent = PlayerGui

	-- Stack notifications
	local offsetY = 20
	for _, gui in pairs(PlayerGui:GetChildren()) do
		if gui.Name == "BluewaveNotification" then
			offsetY = offsetY + 90
		end
	end

	local notification = Instance.new("Frame")
	notification.Size = UDim2.new(0, 300, 0, 80)
	notification.Position = UDim2.new(1, 320, 0, offsetY)
	notification.BackgroundColor3 = Theme.Surface
	notification.BorderSizePixel = 0
	notification.Parent = notifGui

	CreateCorner(notification, 8)
	CreateStroke(notification, Theme.Border)

	local notifTitle = Instance.new("TextLabel")
	notifTitle.Size = UDim2.new(1, -15, 0, 25)
	notifTitle.Position = UDim2.new(0, 15, 0, 10)
	notifTitle.BackgroundTransparency = 1
	notifTitle.Text = config.Title or "Notification"
	notifTitle.TextColor3 = Theme.Text
	notifTitle.TextSize = 16
	notifTitle.TextXAlignment = Enum.TextXAlignment.Left
	notifTitle.Font = Enum.Font.GothamBold
	notifTitle.Parent = notification

	local notifContent = Instance.new("TextLabel")
	notifContent.Size = UDim2.new(1, -15, 0, 35)
	notifContent.Position = UDim2.new(0, 15, 0, 35)
	notifContent.BackgroundTransparency = 1
	notifContent.Text = config.Content or "This is a notification"
	notifContent.TextColor3 = Theme.TextSecondary
	notifContent.TextSize = 12
	notifContent.TextXAlignment = Enum.TextXAlignment.Left
	notifContent.Font = Enum.Font.Gotham
	notifContent.TextWrapped = true
	notifContent.Parent = notification

	-- Animate in
	CreateTween(notification, { Position = UDim2.new(1, -320, 0, offsetY) }, 0.5, Enum.EasingStyle.Back)

	-- Auto close
	task.wait(config.Duration or 3)
	CreateTween(notification, { Position = UDim2.new(1, 320, 0, offsetY) }, 0.5)
	task.wait(0.5)
	notifGui:Destroy()
end

return Bluewave