local Gui = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

function Gui.Init()
	Gui.Screen = Instance.new("ScreenGui", player.PlayerGui)
	Gui.Screen.ResetOnSpawn = false

	local frame = Instance.new("Frame", Gui.Screen)
	frame.Size = UDim2.new(0,420,0,200)
	frame.Position = UDim2.new(0.5,-210,0.5,-100)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Instance.new("UICorner", frame)

	-- Drag
	local dragging, dragInput, dragStart, startPos = false
	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
								   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then update(input) end
	end)

	local box = Instance.new("TextBox", frame)
	box.Size = UDim2.new(1,-40,0,40)
	box.Position = UDim2.new(0,20,0,50)
	box.PlaceholderText = "Enter server link here"
	box.BackgroundColor3 = Color3.fromRGB(35,35,35)
	box.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", box)
	Gui.Box = box

	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1,-40,0,40)
	btn.Position = UDim2.new(0,20,0,105)
	btn.Text = "Submit"
	btn.BackgroundColor3 = Color3.fromRGB(0,170,255)
	btn.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", btn)

	local status = Instance.new("TextLabel", frame)
	status.Size = UDim2.new(1,-40,0,25)
	status.Position = UDim2.new(0,20,0,155)
	status.BackgroundTransparency = 1
	status.Text = ""
	status.TextColor3 = Color3.new(1,1,1)
	Gui.Status = status

	btn.MouseButton1Click:Connect(function()
		if Gui.IsValid(box.Text) then
			Gui.OnValidLink(box.Text)
		else
			status.Text = "Link is not valid"
			status.TextColor3 = Color3.fromRGB(255,60,60)
		end
	end)
end

function Gui.IsValid(link)
	return type(link)=="string"
	   and link:find("roblox.com/share%-links")
	   and link:find("code=")
	   and link:find("type=Server")
end

function Gui.ShowLoading()
	Gui.Screen:ClearAllChildren()
	local bg = Instance.new("Frame", Gui.Screen)
	bg.Size = UDim2.new(1,0,1,0)
	bg.BackgroundColor3 = Color3.fromRGB(15,15,15)

	local spinner = Instance.new("ImageLabel", bg)
	spinner.Size = UDim2.new(0,80,0,80)
	spinner.Position = UDim2.new(0.5,-40,0.5,-60)
	spinner.BackgroundTransparency = 1
	spinner.Image = "rbxassetid://8223951786"

	local text = Instance.new("TextLabel", bg)
	text.Size = UDim2.new(1,0,0,30)
	text.Position = UDim2.new(0,0,0.5,30)
	text.BackgroundTransparency = 1
	text.Text = "Validating server link..."
	text.TextColor3 = Color3.new(1,1,1)

	TweenService:Create(
		spinner,
		TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1),
		{Rotation = 360}
	):Play()
end

function Gui.Blackout()
	local black = Instance.new("Frame", Gui.Screen)
	black.Size = UDim2.new(1,0,1,0)
	black.BackgroundColor3 = Color3.new(0,0,0)
	black.ZIndex = 999
end

return Gui