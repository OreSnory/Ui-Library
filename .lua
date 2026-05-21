local Library = {}

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

		TweenService:Create(
			Frame,
			TweenInfo.new(0.1),
			{
				Position = UDim2.new(
					StartPos.X.Scale,
					StartPos.X.Offset + delta.X,
					StartPos.Y.Scale,
					StartPos.Y.Offset + delta.Y
				)
			}
		):Play()
	end)
end

function Library.Window(Config)
	local Window = {}
	
	local UiLibrary = Instance.new("ScreenGui")
	UiLibrary.Name = "UiLibrary"
	UiLibrary.IgnoreGuiInset = true
	UiLibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	UiLibrary.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	
	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 650, 0, 400)
	Main.BackgroundColor3 = Color3.new(0.105882, 0.105882, 0.105882)
	Main.BorderSizePixel = 0
	Main.BorderColor3 = Color3.new(0, 0, 0)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Parent = UiLibrary

	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Size = UDim2.new(1, 0, 0, 35)
	TopBar.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
	TopBar.BorderSizePixel = 0
	TopBar.BorderColor3 = Color3.new(0, 0, 0)
	TopBar.Parent = Main
	
	MakeDraggable(TopBar, Main)

	local UICorner = Instance.new("UICorner")
	UICorner.Name = "UICorner"
	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = TopBar

	local Extension = Instance.new("Frame")
	Extension.Name = "Extension"
	Extension.Position = UDim2.new(0, 0, 1, 0)
	Extension.Size = UDim2.new(1, 0, 0.3, 0)
	Extension.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
	Extension.BorderSizePixel = 0
	Extension.BorderColor3 = Color3.new(0, 0, 0)
	Extension.AnchorPoint = Vector2.new(0, 1)
	Extension.Parent = TopBar

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Position = UDim2.new(0, 15, 0, 0)
	Title.Size = UDim2.new(1, -15, 1, 0)
	Title.BackgroundColor3 = Color3.new(1, 1, 1)
	Title.BackgroundTransparency = 1
	Title.BorderSizePixel = 0
	Title.BorderColor3 = Color3.new(0, 0, 0)
	Title.Text = Config.Title or "Title Example"
	Title.TextColor3 = Color3.new(0.509804, 0.705882, 1)
	Title.TextSize = 18
	Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = TopBar

	local UICorner2 = Instance.new("UICorner")
	UICorner2.Name = "UICorner"
	UICorner2.CornerRadius = UDim.new(0, 5)
	UICorner2.Parent = Main

	local SideBar = Instance.new("Frame")
	SideBar.Name = "SideBar"
	SideBar.Position = UDim2.new(0, 7, 0, 42)
	SideBar.Size = UDim2.new(0, 175, 1, -49)
	SideBar.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
	SideBar.BorderSizePixel = 0
	SideBar.BorderColor3 = Color3.new(0, 0, 0)
	SideBar.Parent = Main

	local UICorner3 = Instance.new("UICorner")
	UICorner3.Name = "UICorner"
	UICorner3.CornerRadius = UDim.new(0, 5)
	UICorner3.Parent = SideBar

	local GameName = Instance.new("TextLabel")
	GameName.Name = "GameName"
	GameName.Position = UDim2.new(0, 8, 0, 0)
	GameName.Size = UDim2.new(1, -8, 0, 30)
	GameName.BackgroundColor3 = Color3.new(1, 1, 1)
	GameName.BackgroundTransparency = 1
	GameName.BorderSizePixel = 0
	GameName.BorderColor3 = Color3.new(0, 0, 0)
	GameName.Text = Config.GameName or "Game Name Example"
	GameName.TextColor3 = Color3.new(1, 1, 1)
	GameName.TextSize = 15
	GameName.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	GameName.TextXAlignment = Enum.TextXAlignment.Left
	GameName.Parent = SideBar
	
	local Tabs = Instance.new("Frame")
	Tabs.Name = "Tabs"
	Tabs.Position = UDim2.new(0, 7, 0, 37)
	Tabs.Size = UDim2.new(1, -14, 1, -44)
	Tabs.BackgroundColor3 = Color3.new(1, 1, 1)
	Tabs.BackgroundTransparency = 1
	Tabs.BorderSizePixel = 0
	Tabs.BorderColor3 = Color3.new(0, 0, 0)
	Tabs.Transparency = 1
	Tabs.Parent = SideBar

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Name = "UIListLayout"
	UIListLayout.Padding = UDim.new(0, 5)
	UIListLayout.Parent = Tabs
	
	local CurrentTab

	local function SelectTab(TabButton)
		if CurrentTab then
			CurrentTab.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
		end

		CurrentTab = TabButton
		CurrentTab.BackgroundColor3 = Color3.new(0.509804, 0.705882, 1)
	end
	
	function Window.CreateTab(Config)
		local Tab = {}
		
		local TabButton = Instance.new("TextButton")
		TabButton.Name = "HomeTab"
		TabButton.Size = UDim2.new(1, 0, 0, 25)
		TabButton.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
		TabButton.BorderSizePixel = 0
		TabButton.BorderColor3 = Color3.new(0, 0, 0)
		TabButton.Text = Config.Name or "Home"
		TabButton.TextColor3 = Color3.new(1, 1, 1)
		TabButton.TextSize = 15
		TabButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		TabButton.AutoButtonColor = false
		TabButton.Parent = Tabs
		
		local UICorner4 = Instance.new("UICorner")
		UICorner4.Name = "UICorner"
		UICorner4.CornerRadius = UDim.new(0, 5)
		UICorner4.Parent = TabButton
		
		TabButton.MouseButton1Click:Connect(function()
			SelectTab(TabButton)
		end)
		
		if not CurrentTab then
			SelectTab(TabButton)
		end
		
		return Tab
	end
	
	return Window
end

return Library
