-- Gui to Lua
-- Version: 3.2

--[[
  Script made by YAYAYGPPR
]]

-- Instances:

local TeleportGUI = Instance.new("ScreenGui")
local Frame = Instance.new("ImageLabel")
local DropShadow = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local TextButton = Instance.new("TextButton")
local close = Instance.new("ImageButton")

--Properties:

TeleportGUI.Name = "Teleport GUI"
TeleportGUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
TeleportGUI.ResetOnSpawn = false

Frame.Name = "Frame"
Frame.Parent = TeleportGUI
Frame.AnchorPoint = Vector2.new(0, 1)
Frame.BackgroundColor3 = Color3.fromRGB(160, 255, 235)
Frame.BackgroundTransparency = 1.000
Frame.Position = UDim2.new(0.0117211593, 0, 0.971779168, 0)
Frame.Size = UDim2.new(0, 161, 0, 202)
Frame.ZIndex = 2
Frame.Image = "rbxassetid://3570695787"
Frame.ImageColor3 = Color3.fromRGB(35, 35, 35)
Frame.ScaleType = Enum.ScaleType.Slice
Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Frame.SliceScale = 0.250

DropShadow.Name = "DropShadow"
DropShadow.Parent = Frame
DropShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.BackgroundTransparency = 1.000
DropShadow.BorderSizePixel = 0
DropShadow.Position = UDim2.new(0, 7, 0, 7)
DropShadow.Size = UDim2.new(1, 0, 1, 0)
DropShadow.Image = "rbxassetid://3570695787"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(100, 100, 100, 100)
DropShadow.SliceScale = 0.250

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(-0.00621118024, 0, 0.0643564388, 0)
TextLabel.Size = UDim2.new(0, 161, 0, 39)
TextLabel.ZIndex = 2
TextLabel.Font = Enum.Font.PatrickHand
TextLabel.Text = "Teleport GUI"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 32.000
TextLabel.TextWrapped = true

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
TextBox.Position = UDim2.new(0.0434782617, 0, 0.297029704, 0)
TextBox.Size = UDim2.new(0, 146, 0, 58)
TextBox.ZIndex = 2
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderText = "Insert Username"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 24.000
TextBox.TextWrapped = true

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 0.900
TextButton.Position = UDim2.new(0.0434782617, 0, 0.648514867, 0)
TextButton.Size = UDim2.new(0, 146, 0, 50)
TextButton.ZIndex = 2
TextButton.Font = Enum.Font.Nunito
TextButton.Text = "Teleport"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 35.000

close.Name = "close"
close.Parent = Frame
close.BackgroundTransparency = 1.000
close.Position = UDim2.new(0.842999995, 0, 0.0350000001, 0)
close.Size = UDim2.new(0, 20, 0, 20)
close.ZIndex = 2
close.Image = "rbxassetid://3926305904"
close.ImageRectOffset = Vector2.new(284, 4)
close.ImageRectSize = Vector2.new(24, 24)

local gmt = getrawmetatable(game)
local oldindex = gmt.__namecall
setreadonly(gmt, false) 

gmt.__namecall = newcclosure(function(Self, ...)
	local method = getnamecallmethod()
	if tostring(Self) == game.Players.LocalPlayer and tostring(method) == "Kick" then
		return
	end
	return oldindex(Self, ...)
end)

-- Module Scripts:

local fake_module_scripts = {}

do -- TeleportGUI.DraggableObject
	local script = Instance.new('ModuleScript', TeleportGUI)
	script.Name = "DraggableObject"
	local function module_script()
		--[[
			@Author: Spynaz
			@Description: Enables dragging on GuiObjects. Supports both mouse and touch.
			
			For instructions on how to use this module, go to this link:
			https://devforum.roblox.com/t/simple-module-for-creating-draggable-gui-elements/230678
		--]]
		
		local UDim2_new = UDim2.new
		
		local UserInputService = game:GetService("UserInputService")
		
		local DraggableObject 		= {}
		DraggableObject.__index 	= DraggableObject
		
		-- Sets up a new draggable object
		function DraggableObject.new(Object)
			local self 			= {}
			self.Object			= Object
			self.DragStarted	= nil
			self.DragEnded		= nil
			self.Dragged		= nil
			self.Dragging		= false
			
			setmetatable(self, DraggableObject)
			
			return self
		end
		
		-- Enables dragging
		function DraggableObject:Enable()
			local object			= self.Object
			local dragInput			= nil
			local dragStart			= nil
			local startPos			= nil
			local preparingToDrag	= false
			
			-- Updates the element
			local function update(input)
				local delta 		= input.Position - dragStart
				local newPosition	= UDim2_new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				object.Position 	= newPosition
			
				return newPosition
			end
			
			self.InputBegan = object.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					preparingToDrag = true
					--[[if self.DragStarted then
						self.DragStarted()
					end
					
					dragging	 	= true
					dragStart 		= input.Position
					startPos 		= Element.Position
					--]]
					
					local connection 
					connection = input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End and (self.Dragging or preparingToDrag) then
							self.Dragging = false
							connection:Disconnect()
							
							if self.DragEnded and not preparingToDrag then
								self.DragEnded()
							end
							
							preparingToDrag = false
						end
					end)
				end
			end)
			
			self.InputChanged = object.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)
			
			self.InputChanged2 = UserInputService.InputChanged:Connect(function(input)
				if object.Parent == nil then
					self:Disable()
					return
				end
				
				if preparingToDrag then
					preparingToDrag = false
					
					if self.DragStarted then
						self.DragStarted()
					end
					
					self.Dragging	= true
					dragStart 		= input.Position
					startPos 		= object.Position
				end
				
				if input == dragInput and self.Dragging then
					local newPosition = update(input)
					
					if self.Dragged then
						self.Dragged(newPosition)
					end
				end
			end)
		end
		
		-- Disables dragging
		function DraggableObject:Disable()
			self.InputBegan:Disconnect()
			self.InputChanged:Disconnect()
			self.InputChanged2:Disconnect()
			
			if self.Dragging then
				self.Dragging = false
				
				if self.DragEnded then
					self.DragEnded()
				end
			end
		end
		
		return DraggableObject
		
	end
	fake_module_scripts[script] = module_script
end


-- Scripts:

local function FXMUKP_fake_script() -- TeleportGUI.Draggable 
	local script = Instance.new('LocalScript', TeleportGUI)
	local req = require
	local require = function(obj)
		local fake = fake_module_scripts[obj]
		if fake then
			return fake()
		end
		return req(obj)
	end

	local DraggableObject = require(script.Parent.DraggableObject)
	local FrameDrag = DraggableObject.new(script.Parent.Frame)
	FrameDrag:Enable()
end
coroutine.wrap(FXMUKP_fake_script)()
local function FGRQEO_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)
	local req = require
	local require = function(obj)
		local fake = fake_module_scripts[obj]
		if fake then
			return fake()
		end
		return req(obj)
	end

	script.Parent.MouseButton1Down:Connect(function()
		local text = script.Parent.Parent.TextBox.Text
		local plr = nil
		if game:GetService("Players"):FindFirstChild(text) then
			plr = game:GetService("Players"):FindFirstChild(text)
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
		else
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local name = v.Name
				if text == string.sub(name, 1, string.len(text)) then
					plr = v
				end
			end
			if plr ~= nil then
				plr = game:GetService("Players"):FindFirstChild(text)
				game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
			else
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Player not found.";
					Text = "An invalid player was entered.";
					Duration = 5;
				})
			end
			
		end
	end)
end
coroutine.wrap(FGRQEO_fake_script)()
local function BLPV_fake_script() -- close.LocalScript 
	local script = Instance.new('LocalScript', close)
	local req = require
	local require = function(obj)
		local fake = fake_module_scripts[obj]
		if fake then
			return fake()
		end
		return req(obj)
	end

	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent:Destroy()
	end)
end
coroutine.wrap(BLPV_fake_script)()
