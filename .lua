local UserInputService = game:GetService("UserInputService")

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

function UiLibrary:CreateWindow(Config)
	local Window = {}

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
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Parent = Ui_Library

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = Main

	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Size = UDim2.new(1, 0, 0, 35)
	TopBar.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
	TopBar.BorderSizePixel = 0
	TopBar.Parent = Main

	local UICorner2 = Instance.new("UICorner")
	UICorner2.CornerRadius = UDim.new(0, 5)
	UICorner2.Parent = TopBar

	local Extension = Instance.new("Frame")
	Extension.Name = "Extension"
	Extension.Position = UDim2.new(0, 0, 1, 0)
	Extension.Size = UDim2.new(1, 0, 0.5, 0)
	Extension.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
	Extension.BorderSizePixel = 0
	Extension.AnchorPoint = Vector2.new(0, 1)
	Extension.Parent = TopBar

	local TextLabel = Instance.new("TextLabel")
	TextLabel.Name = "Title"
	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = Config.Name or "Window"
	TextLabel.TextColor3 = Color3.new(0.509804, 0.705882, 1)
	TextLabel.TextSize = 20
	TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = TopBar

	local UIPadding = Instance.new("UIPadding")
	UIPadding.PaddingLeft = UDim.new(0, 10)
	UIPadding.Parent = TextLabel

	MakeDraggable(TopBar, Main)

	Window.Instance = Ui_Library
	Window.Main = Main
	Window.TopBar = TopBar
	Window.Title = TextLabel

	function Window:SetTitle(Text)
		self.Title.Text = Text
	end

	function Window:Destroy()
		self.Instance:Destroy()
	end

	return Window
end

return UiLibrary
