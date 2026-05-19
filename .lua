local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local function MakeDraggable(TopBar, Frame)
	local Dragging = false
	local DragStart
	local StartPos

	TopBar.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			DragStart = Input.Position
			StartPos = Frame.Position
		end
	end)

	TopBar.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if not Dragging then return end
		if Input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

		local delta = Input.Position - DragStart

		Frame.Position = UDim2.new(
			StartPos.X.Scale,
			StartPos.X.Offset + delta.X,
			StartPos.Y.Scale,
			StartPos.Y.Offset + delta.Y
		)
	end)
end

local UiLibrary = {}

function UiLibrary:Window(Config)
	local Window = {}

	-- Main Ui
	local Ui_Library = Instance.new("ScreenGui")
	Ui_Library.Name = "Ui Library"
	Ui_Library.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Ui_Library.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = Config.Size or UDim2.new(0, 650, 0, 400)
	Main.BackgroundColor3 = Color3.new(0.105882, 0.105882, 0.105882)
	Main.BorderSizePixel = 0
	Main.BorderColor3 = Color3.new(0, 0, 0)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Parent = Ui_Library

	local UICorner = Instance.new("UICorner")
	UICorner.Name = "UICorner"
	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = Main

	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Size = UDim2.new(1, 0, 0, 35)
	TopBar.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
	TopBar.BorderSizePixel = 0
	TopBar.BorderColor3 = Color3.new(0, 0, 0)
	TopBar.Parent = Main

	local UICorner2 = Instance.new("UICorner")
	UICorner2.Name = "UICorner"
	UICorner2.CornerRadius = UDim.new(0, 5)
	UICorner2.Parent = TopBar

	local Extension = Instance.new("Frame")
	Extension.Name = "Extension"
	Extension.Position = UDim2.new(0, 0, 1, 0)
	Extension.Size = UDim2.new(1, 0, 0.5, 0)
	Extension.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
	Extension.BorderSizePixel = 0
	Extension.BorderColor3 = Color3.new(0, 0, 0)
	Extension.AnchorPoint = Vector2.new(0, 1)
	Extension.Parent = TopBar

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Size = UDim2.new(1, 0, 1, 0)
	Title.BackgroundColor3 = Color3.new(1, 1, 1)
	Title.BackgroundTransparency = 1
	Title.BorderSizePixel = 0
	Title.BorderColor3 = Color3.new(0, 0, 0)
	Title.Text = Config.Name or "Title"
	Title.TextColor3 = Color3.new(0.509804, 0.705882, 1)
	Title.TextSize = 20
	Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = TopBar

	local UIPadding = Instance.new("UIPadding")
	UIPadding.Name = "UIPadding"
	UIPadding.PaddingLeft = UDim.new(0, 10)
	UIPadding.Parent = Title
	
	local TabHolder = Instance.new("Frame")
	TabHolder.Name = "TabHolder"
	TabHolder.Position = UDim2.new(0, 7, 0, 42)
	TabHolder.Size = UDim2.new(0, 200, 1, -49)
	TabHolder.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
	TabHolder.BorderSizePixel = 0
	TabHolder.BorderColor3 = Color3.new(0, 0, 0)
	TabHolder.Parent = Main

	local UICorner3 = Instance.new("UICorner")
	UICorner3.Name = "UICorner"
	UICorner3.CornerRadius = UDim.new(0, 4)
	UICorner3.Parent = TabHolder

	local Tabs = Instance.new("Frame")
	Tabs.Name = "Tabs"
	Tabs.Position = UDim2.new(0, 10, 0, 35)
	Tabs.Size = UDim2.new(1, -20, 1, -45)
	Tabs.BackgroundColor3 = Color3.new(1, 1, 1)
	Tabs.BackgroundTransparency = 1
	Tabs.BorderSizePixel = 0
	Tabs.BorderColor3 = Color3.new(0, 0, 0)
	Tabs.Parent = TabHolder

	local GameName = Instance.new("TextLabel")
	GameName.Name = "GameName"
	GameName.Size = UDim2.new(1, 0, 0, 25)
	GameName.BackgroundColor3 = Color3.new(1, 1, 1)
	GameName.BackgroundTransparency = 1
	GameName.BorderSizePixel = 0
	GameName.BorderColor3 = Color3.new(0, 0, 0)
	GameName.Text = Config.GameName or "Game Name"
	GameName.TextColor3 = Color3.new(1, 1, 1)
	GameName.TextSize = 15
	GameName.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	GameName.TextXAlignment = Enum.TextXAlignment.Left
	GameName.Parent = TabHolder

	local UIPadding2 = Instance.new("UIPadding")
	UIPadding2.Name = "UIPadding"
	UIPadding2.PaddingLeft = UDim.new(0, 10)
	UIPadding2.Parent = GameName
	
	Main.Size = UDim2.new(0, 220, 0, 133)
	TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = Config.Size or UDim2.new(0, 650, 0, 400),
	}):Play()
	
	MakeDraggable(TopBar, Main)

	-- Tabs
	local CurrentTab

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Name = "UIListLayout"
	UIListLayout.Parent = Tabs

	function Window:Tab(Config)
		
		local Tab = Instance.new("TextButton")
		Tab.Name = "Tab"
		Tab.Size = UDim2.new(1, 0, 0, 25)
		Tab.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
		Tab.BorderSizePixel = 0
		Tab.BorderColor3 = Color3.new(0, 0, 0)
		Tab.Text = Config.Name or "Tab"
		Tab.TextColor3 = Color3.new(1, 1, 1)
		Tab.TextSize = 15
		Tab.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Tab.AutoButtonColor = false
		Tab.Parent = Tabs

		local UICorner5 = Instance.new("UICorner")
		UICorner5.Name = "UICorner"
		UICorner5.CornerRadius = UDim.new(0, 4)
		UICorner5.Parent = Tab

		Tab.MouseButton1Click:Connect(function()
			if CurrentTab then
				CurrentTab.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
			end

			Tab.BackgroundColor3 = Color3.new(0.509804, 0.705882, 1)
			CurrentTab = Tab
		end)

		if not CurrentTab then
			Tab.BackgroundColor3 = Color3.new(0.509804, 0.705882, 1)
			CurrentTab = Tab
		end

	end

	Window.Main = Main
	Window.Title = Title
	Window.GameName = GameName

	return Window
end

return UiLibrary
