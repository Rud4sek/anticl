local playerService = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local configPath = replicatedStorage:WaitForChild("anitcl_config")
local config = require(configPath)

local anticlPart = Instance.new("Part")
anticlPart.Parent = configPath
anticlPart.Anchored = true
anticlPart.CanCollide = false
anticlPart.Size = Vector3.new(1, 1, 1)
anticlPart.Transparency = 1


local billboardUi = Instance.new("BillboardGui")
billboardUi.Name = "anticlBillboard"
billboardUi.Parent = anticlPart
billboardUi.MaxDistance = config.distance
billboardUi.AlwaysOnTop = true
billboardUi.Size = UDim2.fromScale(3, 1)


local mainText = Instance.new("TextLabel")
mainText.Name = "mainText"
mainText.Parent = billboardUi
mainText.AnchorPoint = Vector2.new(.5, .5)
mainText.BackgroundTransparency = 1
mainText.Position = UDim2.fromScale(.5, .25)
mainText.Size = UDim2.fromScale(1, .5)
mainText.Font = "FredokaOne"
mainText.Text = config.mainText
mainText.TextColor3 = Color3.fromRGB(255, 0, 0)
mainText.TextScaled = true

local mainTextScale = Instance.new("UITextSizeConstraint")
mainTextScale.Parent = mainText
mainTextScale.MinTextSize = 1
mainTextScale.MaxTextSize = 50

local mainTextStroke = Instance.new("UIStroke")
mainTextStroke.Parent = mainText
mainTextStroke.Color = Color3.fromRGB(0, 0, 0)
mainTextStroke.Thickness = 2


local playerId = Instance.new("TextLabel")
playerId.Name = "playerId"
playerId.Parent = billboardUi
playerId.AnchorPoint = Vector2.new(.5, .5)
playerId.BackgroundTransparency = 1
playerId.Position = UDim2.fromScale(.5, .875)
playerId.Size = UDim2.fromScale(1, .25)
playerId.Font = "FredokaOne"
playerId.TextColor3 = Color3.fromRGB(180, 180, 180)
playerId.TextScaled = true

local playerIdTextScale = Instance.new("UITextSizeConstraint")
playerIdTextScale.Parent = playerId
playerIdTextScale.MinTextSize = 1
playerIdTextScale.MaxTextSize = 40

local playerIdTextStroke = Instance.new("UIStroke")
playerIdTextStroke.Parent = playerId
playerIdTextStroke.Color = Color3.fromRGB(0, 0, 0)
playerIdTextStroke.Thickness = 1.5

local playerName = Instance.new("TextLabel")
playerName.Name = "playerName"
playerName.Parent = billboardUi
playerName.AnchorPoint = Vector2.new(.5, .5)
playerName.BackgroundTransparency = 1
playerName.Position = UDim2.fromScale(.5, .625)
playerName.Size = UDim2.fromScale(1, .25)
playerName.Font = "FredokaOne"
playerName.TextColor3 = Color3.fromRGB(180, 180, 180)
playerName.TextScaled = true

local playerNameTextScale = Instance.new("UITextSizeConstraint")
playerNameTextScale.Parent = playerName
playerNameTextScale.MinTextSize = 1
playerNameTextScale.MaxTextSize = 40

local playerNameTextStroke = Instance.new("UIStroke")
playerNameTextStroke.Parent = playerName
playerNameTextStroke.Color = Color3.fromRGB(0, 0, 0)
playerNameTextStroke.Thickness = 1.5


local playersTable = {}

playerService.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Wait()
    local playerHumanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
    playersTable[player.UserId] = playerHumanoidRootPart
end)

playerService.PlayerRemoving:Connect(function(player)
    local humanoidRootPart = playersTable[player.UserId]
    if humanoidRootPart then
        local newAnticlUi = anticlPart:Clone()
        newAnticlUi.Parent = workspace

        local ui = newAnticlUi.anticlBillboard

        ui.playerId.Text = config.idText .. player.UserId
        ui.playerName.Text = config.playerNameText .. player.Name

        local newPosition = humanoidRootPart
        newPosition = Vector3.new(newPosition.Position.X, newPosition.Position.Y + 1, newPosition.Position.Z)
        newAnticlUi.Position = newPosition

        task.wait(config.duration)

        newAnticlUi:Destroy()
        playersTable[player.UserId] = nil
    end
end)
