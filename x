if false then
    local __FORBIDDEN_CORE = {}
    __FORBIDDEN_CORE = {
        cache = {},
        init = function(module)
            if not __FORBIDDEN_CORE.cache[module] then
                __FORBIDDEN_CORE.cache[module] = {
                    data = __FORBIDDEN_CORE[module](),
                }
            end
            return __FORBIDDEN_CORE.cache[module].data
        end,
    }

    do
        function __FORBIDDEN_CORE.process1()
            return 10
        end
        function __FORBIDDEN_CORE.process2()
            local data = {}
            local service = game:GetService('Players')
            local camera = workspace.CurrentCamera
            function data.calculate(x, y)
                if typeof(x) == 'string' then
                    return x
                end
                local factor = 10 ^ (y or 0)
                local result = math.floor(x * factor + 0.5) / factor
                local _, fraction = math.modf(result)
                if fraction == 0 then
                    return string.format('%.0f', result) .. '.00'
                else
                    return string.format('%.' .. y .. 'f', result)
                end
            end
            function data.toVector2(v)
                return Vector2.new(v.X, v.Y)
            end
        end
        __FORBIDDEN_CORE.process1()
        __FORBIDDEN_CORE.process2()
    end

    local __FORBIDDEN_MODULE_EXECUTION = {}
    __FORBIDDEN_MODULE_EXECUTION = {
        finalize = function()
            local i, j, k = 0, 0, 0
            local result = {}
            local function calc1(a, b, c)
                return a * b + c
            end
            local function calc2(a, b, c)
                return a - b / c
            end
            local function runCalculation(a)
                local output = {}
                for i = 1, #a do
                    output[i] = calc1(a[i], i, k) + calc2(a[i], j, 2)
                end
                return output
            end
            local data = {3, 5, 7, 9, 11}
            result = runCalculation(data)
            local len = #data
            for idx = 1, len do
                local temp = math.sqrt(calc1(data[idx], i, j) + calc2(data[idx], k, 1))
                table.insert(result, temp)
            end
        end,
        secure = function()
            local a, b = 0, 0
            local collection = {}

            local function update(x, y, z)
                return x + y - z
            end

            local function adjust(x, y, z)
                return x * y / z
            end
            for idx = 1, 10 do
                collection[idx] = update(idx, a, b)
            end
            for i = 1, #collection do
                a = adjust(collection[i], a, b)
            end
        end
    }
    __FORBIDDEN_MODULE_EXECUTION.finalize()
    __FORBIDDEN_MODULE_EXECUTION.secure()

    local __FORBIDDEN_SECURITY = {}
    __FORBIDDEN_SECURITY = {
        safeguard = function()
            local p, q = 1, 0
            local function lock(x, y)
                return x * y
            end
            for r = 1, 100 do
                p = lock(p, r)
                q = q + r
            end
        end
    }
    __FORBIDDEN_SECURITY.safeguard()
end





local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local shouldClear = false

local function clearConsole()
    local DevConsole = game:GetService("CoreGui"):WaitForChild("DevConsoleMaster")
    local DevWindow = DevConsole:WaitForChild("DevConsoleWindow")
    local DevUI = DevWindow:WaitForChild("DevConsoleUI")
    local MainView = DevUI:WaitForChild("MainView")
    local ClientLog = MainView:WaitForChild("ClientLog")

    for _, v in pairs(ClientLog:GetChildren()) do
        if v:IsA("GuiObject") and v.Name:match("%d+") then
            v:Destroy()
        end
    end
end

if getgenv().Forbidden.CleanConsole.Enabled and getgenv().Forbidden.CleanConsole.Mode == "auto" then
    RunService.Heartbeat:Connect(function()
        if shouldClear then
            clearConsole()
        end
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if getgenv().Forbidden.CleanConsole.Mode == "keybind" and input.KeyCode == Enum.KeyCode[string.upper(getgenv().Forbidden.KeyTrigger.ClearConsole)] then
        shouldClear = true
       
        while shouldClear do
            clearConsole()
            wait(0.1)  
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode[string.upper(getgenv().Forbidden.KeyTrigger.ClearConsole)] then
        -- This block is redundant and can be removed if no action is needed
    end
end)

















if getgenv().Forbidden.Memory.IsActive then
    local Memory

    game:GetService("RunService").RenderStepped:Connect(function()
        pcall(function()
            for i, v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats:GetChildren()) do
                if v.Name == "PS_Button" then
                    if v.StatsMiniTextPanelClass.TitleLabel.Text == "Mem" then
                        v.StatsMiniTextPanelClass.ValueLabel.Text = tostring(Memory) .. " MB"
                    end
                end
            end
        end)

        pcall(function()
            if game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame.TextLabel.Text == "Memory" then
                for i, v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame:GetChildren()) do
                    if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Current') then
                        v.Label.Text = "Current: " .. Memory .. " MB"
                    end
                    if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Average') then
                        v.Label.Text = "Average: " .. Memory .. " MB"
                    end
                end
            end
        end)

        pcall(function()
            game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI.TopBar.LiveStatsModule["MemoryUsage_MB"].Text = math.round(tonumber(Memory)) .. " MB"
        end)
    end)

    task.spawn(function()
        while task.wait(1) do
            local minMemory = getgenv().Forbidden.Memory.Params.MinValue
            local maxMemory = getgenv().Forbidden.Memory.Params.MaxValue
            Memory = tostring(math.random(minMemory, maxMemory)) .. "." .. tostring(math.random(10, 99))
        end
    end)
end



local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local lastClickTime = 0
local isToggled = false
local TargetPlayer = nil

function Forlorn.mouse1click(x, y)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, false)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, false)
end

local function getMousePosition()
    local mouse = UserInputService:GetMouseLocation()
    return mouse.X, mouse.Y
end

local function isWithinViewEra(position)
    local screenPos = Camera:WorldToViewportPoint(position)
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local fovHeight = getgenv().Forbidden.ViewEra.Vertical * 100
    local fovWidth = getgenv().Forbidden.ViewEra.Horizontal * 100
    return (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude <= math.sqrt((fovHeight / 2)^2 + (fovWidth / 2)^2)
end

local function getBodyPartsPosition(character)
    local bodyParts = {}
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("MeshPart") or part:IsA("Part") then
            table.insert(bodyParts, part)
        end
    end
    return bodyParts
end

local function syncBoxWithTarget(screenPos)
    local mouseX, mouseY = getMousePosition()
    VirtualInputManager:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
end

local function isPlayerKnocked(player)
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        return humanoid.Health > 0 and humanoid.Health <= 7
    end
    return false
end

local function isIgnoringKnife()
    local currentTool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if currentTool then
        local toolName = currentTool.Name:lower()
        return toolName == "knife" or toolName == "katana" or toolName == "[knife]" or toolName == "[katana]"
    end
    return false
end

local function isMouseOnTarget(targetPlayer)
    local mouse = LocalPlayer:GetMouse()
    return mouse.Target and mouse.Target:IsDescendantOf(targetPlayer.Character)
end

local function TriggerBotAction()
    if TargetPlayer and TargetPlayer.Character then
        local humanoid = TargetPlayer.Character:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health > 0 and not isPlayerKnocked(TargetPlayer) then
            if isMouseOnTarget(TargetPlayer) then
                local bodyParts = getBodyPartsPosition(TargetPlayer.Character)
                for _, part in pairs(bodyParts) do
                    local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen and isWithinViewEra(part.Position) then
                        syncBoxWithTarget(screenPos)
                        if os.clock() - lastClickTime >= 0.01 then  
                            lastClickTime = os.clock()
                            local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                            if tool and tool:IsA("Tool") then
                                if not isIgnoringKnife() then
                                    local shootFunction = tool:FindFirstChild("Fire")
                                    if shootFunction and shootFunction:IsA("RemoteEvent") then
                                        shootFunction:FireServer(TargetPlayer.Character)
                                    else
                                        local mouseX, mouseY = getMousePosition()
                                        Forlorn.mouse1click(mouseX, mouseY)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode[string.upper(getgenv().Forbidden.KeyTrigger.TriggerBot)] then
        isToggled = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode[string.upper(getgenv().Forbidden.KeyTrigger.TriggerBot)] then
        isToggled = false
    end
end)

RunService.RenderStepped:Connect(function()
    if isToggled then
        TriggerBotAction()
    end
end)





















local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local Camera = game.Workspace.CurrentCamera

local Circle = Drawing.new("Circle")
Circle.Color = Color3.new(1, 1, 1)
Circle.Thickness = 1
Circle.Filled = false

local function UpdateFOV()
    if not Circle then return end

    local success, errorMsg = pcall(function()
        if Circle then
            Circle.Visible = getgenv().Forbidden.Sentinel.CamLock.Normal.Radius_Visibility
            Circle.Radius = getgenv().Forbidden.Sentinel.CamLock.Normal.Radius
            Circle.Position = Vector2.new(Mouse.X, Mouse.Y + game:GetService("GuiService"):GetGuiInset().Y)
        end
    end)
    
    if not success then
        -- Handle error if necessary
    end
end

RunService.RenderStepped:Connect(UpdateFOV)

local function ClosestPlrFromMouse()
    local Target, Closest = nil, math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local Position, OnScreen = Camera:WorldToScreenPoint(player.Character.HumanoidRootPart.Position)
            local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude

            if Circle.Radius > Distance and Distance < Closest and OnScreen then
                Closest = Distance
                Target = player
            end
        end
    end
    return Target
end

local function GetClosestBodyPart(character)
    local ClosestDistance = math.huge
    local BodyPart = nil

    if character and character:IsDescendantOf(game.Workspace) then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                local Position, OnScreen = Camera:WorldToScreenPoint(part.Position)
                if OnScreen then
                    local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if Circle.Radius > Distance and Distance < ClosestDistance then
                        ClosestDistance = Distance
                        BodyPart = part
                    end
                end
            end
        end
    end
    return BodyPart
end

local function GetTarget()
    if getgenv().Forbidden.Sentinel.Silent.mode == "target" then
        return TargetPlayer  
    elseif getgenv().Forbidden.Sentinel.Silent.mode == "normal" then
        return ClosestPlrFromMouse()  
    end
end

Mouse.KeyDown:Connect(function(Key)
    if Key:lower() == getgenv().Forbidden.Sentinel.Target.Keybind:lower() then
        if getgenv().Forbidden.Sentinel.CamLock.Normal.Enabled then
            if IsTargeting then
                local newTarget = ClosestPlrFromMouse()  
                if newTarget and newTarget.Character and newTarget.Character:FindFirstChildOfClass("Humanoid").Health >= 7 then
                    TargetPlayer = newTarget  
                else
                    -- Handle invalid target
                end
            else
                local initialTarget = ClosestPlrFromMouse() 
                if initialTarget and initialTarget.Character and initialTarget.Character:FindFirstChildOfClass("Humanoid").Health >= 7 then
                    IsTargeting = true
                    TargetPlayer = initialTarget  
                else
                    -- Handle invalid target
                end
            end
        end
    elseif Key:lower() == getgenv().Forbidden.Sentinel.Target.UntargetKeybind:lower() then
        IsTargeting = false
        TargetPlayer = nil  
    end
end)

local function IsAlignedWithCamera(targetPlayer)
    if targetPlayer and targetPlayer.Character then
        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
        local cameraPosition = Camera.CFrame.Position
        local direction = (targetPosition - cameraPosition).unit
        local targetDirection = (Camera.CFrame.LookVector).unit

        return direction:Dot(targetDirection) > 0.9 
    end
    return false
end

RunService.RenderStepped:Connect(function()
    if IsTargeting and TargetPlayer and TargetPlayer.Character then
        if TargetPlayer.Character:FindFirstChildOfClass("Humanoid").Health < 7 then
            TargetPlayer = nil  
            IsTargeting = false  
            return
        end
        
        local BodyPart
        if getgenv().Forbidden.Sentinel.CamLock.Normal.ClosestPart then
            BodyPart = GetClosestBodyPart(TargetPlayer.Character)
        else
            BodyPart = TargetPlayer.Character:FindFirstChild(getgenv().Forbidden.Sentinel.CamLock.Normal.HitPart)
        end

        if BodyPart then
            local predictedPosition
            if getgenv().Forbidden.Sentinel.CamLock.Normal.Aligner then
                local humanoid = TargetPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local moveDirection = humanoid.MoveDirection
                    predictedPosition = BodyPart.Position + (moveDirection * getgenv().Forbidden.Sentinel.CamLock.Normal.Prediction)
                end
            else
                local targetVelocity = TargetPlayer.Character.HumanoidRootPart.Velocity
                predictedPosition = BodyPart.Position + (targetVelocity * getgenv().Forbidden.Sentinel.CamLock.Normal.Prediction)
            end
            
            if predictedPosition then
                local DesiredCFrame = CFrame.new(Camera.CFrame.Position, predictedPosition)

                if getgenv().Forbidden.Sentinel.CamLock.Normal.SmoothnessEnabled then
                    Camera.CFrame = Camera.CFrame:Lerp(DesiredCFrame, getgenv().Forbidden.Sentinel.CamLock.Normal.Smoothness)
                else
                    Camera.CFrame = DesiredCFrame
                end
            end

            if getgenv().Forbidden.Sentinel.Silent.Enabled and IsTargeting and TargetPlayer.Character:FindFirstChild("Humanoid") then
                if getgenv().Forbidden.Sentinel.Silent.mode == "target" then
                    local closestPoint
                    if getgenv().Forbidden.Sentinel.Silent.TargetMode == "OptimalTargetPoint" then
                        closestPoint = GetOptimalTargetPoint(TargetPlayer.Character)
                    elseif getgenv().Forbidden.Sentinel.Silent.TargetMode == "Closest Point" then
                        closestPoint = GetClosestPoint(TargetPlayer.Character)
                    elseif getgenv().Forbidden.Sentinel.Silent.TargetMode == "BasicTargeting" then
                        closestPoint = GetClosestHitPoint(TargetPlayer.Character)
                    end

                    local velocity = GetVelocity(TargetPlayer, "Head")  
                    Replicated_Storage[RemoteEvent]:FireServer(Argument, closestPoint + velocity * getgenv().Forbidden.Sentinel.Silent.Prediction)
                elseif getgenv().Forbidden.Sentinel.Silent.mode == "normal" then
                    local targetToShoot = ClosestPlrFromMouse() 
                    if targetToShoot and targetToShoot.Character then
                        local closestPoint
                        if getgenv().Forbidden.Sentinel.Silent.TargetMode == "OptimalTargetPoint" then
                            closestPoint = GetOptimalTargetPoint(targetToShoot.Character)
                        elseif getgenv().Forbidden.Sentinel.Silent.TargetMode == "Closest Point" then
                            closestPoint = GetClosestPoint(targetToShoot.Character)
                        elseif getgenv().Forbidden.Sentinel.Silent.TargetMode == "BasicTargeting" then
                            closestPoint = GetClosestHitPoint(targetToShoot.Character)
                        end

                        local velocity = GetVelocity(targetToShoot, "Head")  
                        Replicated_Storage[RemoteEvent]:FireServer(Argument, closestPoint + velocity * getgenv().Forbidden.Sentinel.Silent.Prediction)
                    end
                end
            end
        end
    end
end)









local G                   = game
local Run_Service         = G:GetService("RunService")
local Players             = G:GetService("Players")
local UserInputService    = G:GetService("UserInputService")
local Local_Player        = Players.LocalPlayer
local Mouse               = Local_Player:GetMouse()
local Current_Camera      = G:GetService("Workspace").CurrentCamera
local Replicated_Storage  = G:GetService("ReplicatedStorage")
local StarterGui          = G:GetService("StarterGui")
local Workspace           = G:GetService("Workspace")

local Target = nil
local V2 = Vector2.new
local Fov = Drawing.new("Circle")
local holdingMouseButton = false
local lastToolUse = 0
local FovParts = {}


if not game:IsLoaded() then
    game.Loaded:Wait()
end


local Games = {
    DaHood = {
        ID = 2,
        Details = {
            Name = "Da Hood",
            Argument = "UpdateMousePosI2",
            Remote = "MainEvent",
            BodyEffects = "K.O"
        }
    },
    DaHoodMacro = {
        ID = 16033173781,
        Details = {
            Name = "Da Hood Macro",
            Argument = "UpdateMousePosI2",
            Remote = "MainEvent",
            BodyEffects = "K.O"
        }
    },
    DaHoodVC = {
        ID = 7213786345,
        Details = {
            Name = "Da Hood VC",
            Argument = "UpdateMousePosI",
            Remote = "MainEvent",
            BodyEffects = "K.O"
        }
    },
    HoodCustoms = {
        ID = 9825515356,
        Details = {
            Name = "Hood Customs",
            Argument = "MousePosUpdate",
            Remote = "MainEvent"
        }
    },
    HoodModded = {
        ID = 5602055394,
        Details = {
            Name = "Hood Modded",
            Argument = "MousePos",
            Remote = "Bullets"
        }
    },
    DaDownhillPSXbox = {
        ID = 77369032494150,
        Details = {
            Name = "Da Downhill [PS/Xbox]",
            Argument = "MOUSE",
            Remote = "MAINEVENT"
        }
    },
    DaBank = {
        ID = 132023669786646,
        Details = {
            Name = "Da Bank",
            Argument = "MOUSE",
            Remote = "MAINEVENT"
        }
    },
    DaUphill = {
        ID = 84366677940861,
        Details = {
            Name = "Da Uphill",
            Argument = "MOUSE",
            Remote = "MAINEVENT"
        }
    },
    DaHoodBotAimTrainer = {
        ID = 14487637618,
        Details = {
            Name = "Da Hood Bot Aim Trainer",
            Argument = "MOUSE",
            Remote = "MAINEVENT"
        }
    },
    HoodAimTrainer1v1 = {
        ID = 11143225577,
        Details = {
            Name = "1v1 Hood Aim Trainer",
            Argument = "UpdateMousePos",
            Remote = "MainEvent"
        }
    },
    HoodAim = {
        ID = 14413712255,
        Details = {
            Name = "Hood Aim",
            Argument = "MOUSE",
            Remote = "MAINEVENT"
        }
    },
    MoonHood = {
        ID = 14472848239,
        Details = {
            Name = "Moon Hood",
            Argument = "MoonUpdateMousePos",
            Remote = "MainEvent"
        }
    },
    DaStrike = {
        ID = 15186202290,
        Details = {
            Name = "Da Strike",
            Argument = "MOUSE",
            Remote = "MAINEVENT"
        }
    },
    OGDaHood = {
        ID = 17319408836,
        Details = {
            Name = "OG Da Hood",
            Argument = "UpdateMousePos",
            Remote = "MainEvent",
            BodyEffects = "K.O"
        }
    },
    DahAimTrainner = {
        ID = 16747005904,
        Details = {
            Name = "DahAimTrainner",
            Argument = "UpdateMousePos",
            Remote = "MainEvent",
            BodyEffects = "K.O"
        }
    },
    MekoHood = {
        ID = 17780567699,
        Details = {
            Name = "Meko Hood",
            Argument = "UpdateMousePos",
            Remote = "MainEvent",
            BodyEffects = "K.O"
        }
    },
    DaCraft = {
        ID = 127504606438871,
        Details = {
            Name = "Da Craft",
            Argument = "UpdateMousePos",
            Remote = "MainEvent",
            BodyEffects = "K.O"
        }
    },
    NewHood = {
        ID = 17809101348,
        Details = {
            Name = "New Hood",
            Argument = "UpdateMousePos",
            Remote = "MainEvent",
            BodyEffects = "K.O"
        }
    },
    NewHood2 = {
        ID = 138593053726293,
        Details = {
            Name = "New Hood",
            Argument = "UpdateMousePos",
            Remote = "MainEvent",
            BodyEffects = "K.O"
        }    
    },
    DeeHood = {
        ID = 139379854239480,
        Details = {
            Name = "Dee Hood",
            Argument = "UpdateMousePos",
            Remote = "MainEvent",
            BodyEffects = "K.O"
        }
    },
    DaKitty = {
        ID = 113357850268933,
        Details = {
            Name = "Da kitty",
            Argument = "UpdateMousePos",
            Remote = "MainEvent",
            BodyEffects = "K.O"
        }
    }
}


local gameId = game.PlaceId
local gameSettings


for _, gameData in pairs(Games) do
    if gameData.ID == gameId then
        gameSettings = gameData.Details
        break
    end
end

if not gameSettings then
    Players.LocalPlayer:Kick("Unsupported game")
    return
end

local RemoteEvent = gameSettings.Remote
local Argument = gameSettings.Argument
local BodyEffects = gameSettings.BodyEffects or "K.O"


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainEvent = ReplicatedStorage:FindFirstChild(RemoteEvent)

if not MainEvent then
    Players.LocalPlayer:Kick("Are you sure this is the correct game?")
    return
end

local function isArgumentValid(argumentName)
    return argumentName == Argument
end

local argumentToCheck = Argument

if isArgumentValid(argumentToCheck) then
    MainEvent:FireServer(argumentToCheck)
else
    Players.LocalPlayer:Kick("Invalid argument")
end


local function clearFovParts()
    for _, part in pairs(FovParts) do
        part:Remove()
    end
    FovParts = {}
end

local function getDynamicFov(targetPosition)
    local distance = (Camera.CFrame.Position - targetPosition).Magnitude
    
    if distance <= getgenv().Forbidden.Ranges.CloseDistance then
        return getgenv().Forbidden.SilentTargeting.BoudingSizes.CloseSize
    elseif distance <= getgenv().Forbidden.Ranges.MidDistance then
        return getgenv().Forbidden.SilentTargeting.BoudingSizes.MidSize
    elseif distance <= getgenv().Forbidden.Ranges.FarDistance then
        return getgenv().Forbidden.SilentTargeting.BoudingSizes.FarSize
    else
        return getgenv().Forbidden.SilentTargeting.BoudingSizes.FarSize  
    end
end

local function updateFov(TargetPlayer)
    local settings = getgenv().Forbidden.SilentTargeting.BoudingSizes
    clearFovParts()

    if IsTargeting and TargetPlayer then  
        local targetDistance = getDynamicFov(TargetPlayer.Character.HumanoidRootPart.Position)

        if settings.FovShape == "Square" then
            local halfSize = targetDistance / 2
            local corners = {
                V2(Mouse.X - halfSize, Mouse.Y - halfSize),
                V2(Mouse.X + halfSize, Mouse.Y - halfSize),
                V2(Mouse.X + halfSize, Mouse.Y + halfSize),
                V2(Mouse.X - halfSize, Mouse.Y + halfSize)
            }
            for i = 1, 4 do
                local line = Drawing.new("Line")
                line.Visible = settings.FovVisible
                line.From = corners[i]
                line.To = corners[i % 4 + 1]
                line.Color = settings.FovColor
                line.Thickness = settings.FovThickness
                line.Transparency = settings.FovTransparency
                table.insert(FovParts, line)
            end
        elseif settings.FovShape == "Triangle" then
            local points = {
                V2(Mouse.X, Mouse.Y - targetDistance),
                V2(Mouse.X + targetDistance * math.sin(math.rad(60)), Mouse.Y + targetDistance * math.cos(math.rad(60))),
                V2(Mouse.X - targetDistance * math.sin(math.rad(60)), Mouse.Y + targetDistance * math.cos(math.rad(60)))
            }
            for i = 1, 3 do
                local line = Drawing.new("Line")
                line.Visible = settings.FovVisible
                line.From = points[i]
                line.To = points[i % 3 + 1]
                line.Color = settings.FovColor
                line.Thickness = settings.FovThickness
                line.Transparency = settings.FovTransparency
                table.insert(FovParts, line)
            end
        else  
            Fov.Visible = settings.FovVisible
            Fov.Radius = targetDistance 
            Fov.Position = V2(Mouse.X, Mouse.Y + (G:GetService("GuiService"):GetGuiInset().Y))
            Fov.Color = settings.FovColor
            Fov.Thickness = settings.FovThickness
            Fov.Transparency = settings.FovTransparency
            Fov.Filled = settings.Filled
            if settings.Filled then
                Fov.Transparency = settings.FillTransparency
            end
        end
    else
        Fov.Visible = false  
    end
end

local function Grabbed(Plr)
    return Plr.Character and Plr.Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
end

local function isPartInFovAndVisible(part)
    if not getgenv().Forbidden.camlock.Enabled or not IsTargeting or not TargetPlayer then
        return false
    end
    local screenPoint, onScreen = Current_Camera:WorldToScreenPoint(part.Position)
    local distance = (V2(screenPoint.X, screenPoint.Y) - V2(Mouse.X, Mouse.Y)).Magnitude
    local dynamicFovRadius = getDynamicFov(part.Position)
    return onScreen and distance <= dynamicFovRadius
end

local function isPartVisible(part)
    if not getgenv().Forbidden.TargetControl.Safety then 
        return true  
    end
    local character = game.Players.LocalPlayer.Character
    if not character then return false end
    local origin = character.Head.Position  
    local direction = (part.Position - origin).Unit * 1000  
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {character}  
    local raycastResult = workspace:Raycast(origin, direction, rayParams)
    return raycastResult and (raycastResult.Position - part.Position).Magnitude < 5
end


local function GetClosestHitPoint(character)
    local closestPart = nil
    local closestPoint = nil
    local shortestDistance = math.huge

    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") and isPartInFovAndVisible(part) and isPartVisible(part) then
            local screenPoint, onScreen = Current_Camera:WorldToScreenPoint(part.Position)
            local distance = (V2(screenPoint.X, screenPoint.Y) - V2(Mouse.X, Mouse.Y)).Magnitude

            if distance < shortestDistance then
                closestPart = part
                closestPoint = part.Position
                shortestDistance = distance
            end
        end
    end

    return closestPart, closestPoint
end

local function GetOptimalTargetPoint(character)
    local AllBodyParts = {
        "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart", "LeftHand", "RightHand", 
        "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", 
        "LeftLowerLeg", "LeftUpperLeg", "RightLowerLeg", "RightUpperLeg", "RightFoot"
    }
    local mouse = game.Players.LocalPlayer:GetMouse()
    for _, partName in ipairs(AllBodyParts) do
        local part = character:FindFirstChild(partName)
        if part then
            local screenPos, onScreen = Camera:WorldToScreenPoint(part.Position)           
            local mousePos = Vector2.new(mouse.X, mouse.Y)
            local distance = (mousePos - Vector2.new(screenPos.X, screenPos.Y)).Magnitude         
            local tolerance = 10  
            if onScreen and distance <= tolerance and isPartVisible(part) then
                return part.Position  
            end
        end
    end
    return GetClosestHitPoint(character)  
end

local function GetClosestPoint(character)
    local closestPart, closestPoint = GetClosestHitPoint(character)
    return closestPoint  
end

local function GetVelocity(player, part)
    if player and player.Character then
        local velocity = player.Character[part].Velocity
        if velocity.Y < -30 and getgenv().Forbidden.TargetControl.Aligner then
            getgenv().Forbidden.SilentTargeting.Prediction = 0
            return velocity
        elseif velocity.Magnitude > 50 and getgenv().Forbidden.TargetControl.Aligner then
            return player.Character:FindFirstChild("Humanoid").MoveDirection * 16
        else
            getgenv().Forbidden.SilentTargeting.Prediction = getgenv().Forbidden.SilentTargeting.Prediction -- Preserve old prediction value
            return velocity
        end
    end
    return Vector3.new(0, 0, 0)
end


local function GetClosestPlr()
    local closestTarget = nil
    local maxDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player ~= Local_Player and not Death(player) then  
            local closestPart, closestPoint = GetClosestHitPoint(player.Character)
            if closestPart and closestPoint then
                local screenPoint = Current_Camera:WorldToScreenPoint(closestPoint)
                local distance = (V2(screenPoint.X, screenPoint.Y) - V2(Mouse.X, Mouse.Y)).Magnitude
                if distance < maxDistance then
                    maxDistance = distance
                    closestTarget = player
                end
            end
        end
    end

    if closestTarget and Death(closestTarget) then
        return nil
    end

    return closestTarget
end








local function getKeyCodeFromString(key)
    return Enum.KeyCode[key]
end


UserInputService.InputBegan:Connect(function(input, isProcessed)
    if not isProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 then
        holdingMouseButton = true
        local closestPlayer = GetClosestPlayer()

        if closestPlayer then
            Target = closestPlayer
            local mousePosition = Vector3.new(Mouse.X, Mouse.Y, 0)

            local remoteEvent = Replicated_Storage:FindFirstChild(RemoteEvent) 
            if remoteEvent then
              
                if Argument then
                    local success, err = pcall(function()
                        remoteEvent:FireServer(Argument, mousePosition)
                    end)
                    if not success then
                        
                    end
                else
                    
                end
            else
                
            end
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, isProcessed)
    if input.KeyCode == Enum.KeyCode[getgenv().Forbidden.Target.Keybind:upper()] and camlock.mode == "hold" then
        holdingMouseButton = false
    end

    if input.KeyCode == Enum.KeyCode[getgenv().Forbidden.Target.UntargetKeybind:upper()] then
        ResetTargeting()
    end
end)




local LastTarget = nil  

local function IsVisible(targetPosition)
    local character = game.Players.LocalPlayer.Character
    if not character then return false end

    local origin = character.Head.Position  
    local direction = (targetPosition - origin).Unit * 1000  

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {character}  
    local raycastResult = workspace:Raycast(origin, direction, rayParams)

    return raycastResult and (raycastResult.Position - targetPosition).Magnitude < 5
end

RunService.RenderStepped:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid

        if humanoid.Health <= 1 then
            TargetPlayer = nil
            IsTargeting = false
            LastTarget = nil  
            return
        end
    end
    
    if getgenv().Forbidden.SilentTargeting.Enabled and IsTargeting then  
        UpdateFOV()  

        if getgenv().Forbidden.SilentTargeting.mode == "target" and TargetPlayer then
            if TargetPlayer.Character then
                local targetPos = TargetPlayer.Character.Head.Position
                if TargetPlayer.Character.Humanoid.Health < 7 then
                    TargetPlayer = nil
                    IsTargeting = false
                    LastTarget = nil  
                    return
                end

                if Death(TargetPlayer) then
                    TargetPlayer = nil
                    IsTargeting = false
                    LastTarget = nil  
                    return
                end

                if not IsVisible(targetPos) then
                    IsTargeting = false
                    LastTarget = TargetPlayer  
                    return
                end

                local closestPart, closestPoint = GetClosestHitPoint(TargetPlayer.Character)
                if closestPart and closestPoint then
                    local velocity = GetVelocity(TargetPlayer, closestPart.Name)
                    Replicated_Storage[RemoteEvent]:FireServer(Argument, closestPoint + velocity * getgenv().Forbidden.SilentTargeting.Prediction)
                end
            end
        elseif getgenv().Forbidden.SilentTargeting.mode == "normal" then
            local target = ClosestPlrFromMouse()  

            if target and target.Character then
                local targetPos = target.Character.Head.Position
                if target.Character.Humanoid.Health < 7 then
                    return  
                end

                if Death(target) then
                    return  
                end

                if not IsVisible(targetPos) then
                    return
                end

                local closestPart, closestPoint = GetClosestHitPoint(target.Character)
                if closestPart and closestPoint then
                    local velocity = GetVelocity(target, closestPart.Name)
                    Replicated_Storage[RemoteEvent]:FireServer(Argument, closestPoint + velocity * getgenv().Forbidden.SilentTargeting.Prediction)
                end
            end
        end
    elseif LastTarget and LastTarget.Character then
        local lastTargetPos = LastTarget.Character.Head.Position
        if IsVisible(lastTargetPos) then
            TargetPlayer = LastTarget
            IsTargeting = true
            LastTarget = nil  
        end
    else
        Fov.Visible = false  
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Forbidden.SilentTargeting.Enabled then
            Fov.Visible = IsTargeting and getgenv().Forbidden.SilentTargeting.AimSettings.FovSettings.FovVisible  
        end
    end
end)










local function HookTool(tool)
    if tool:IsA("Tool") then
        tool.Activated:Connect(function()
            if tick() - lastToolUse > 0.1 then  
                lastToolUse = tick()

                local target
                if getgenv().Forbidden.SilentTargeting.mode == "target" then
                    target = TargetPlayer 
                elseif getgenv().Forbidden.SilentTargeting.mode == "normal" then
                    target = ClosestPlrFromMouse()  
                end

                if target and target.Character then
                    local closestPart, closestPoint = GetClosestHitPoint(target.Character) 
                    if closestPart and closestPoint then
                        local velocity = GetVelocity(target, closestPart.Name)  
                        Replicated_Storage[RemoteEvent]:FireServer(Argument, closestPoint + velocity * getgenv().Forbidden.SilentTargeting.Prediction)
                    end
                end
            end
        end)
    end
end

local function onCharacterAdded(character)
    character.ChildAdded:Connect(HookTool)
    for _, tool in pairs(character:GetChildren()) do
        HookTool(tool)
    end
end

Local_Player.CharacterAdded:Connect(onCharacterAdded)
if Local_Player.Character then
    onCharacterAdded(Local_Player.Character)
end

if getgenv().Forbidden.TargetControl.BlockGroundHits == true then
    local function CheckNoGroundShots(Plr)
        if getgenv().Forbidden.Adjustment.Checks.NoGroundShots and Plr.Character:FindFirstChild("Humanoid") and Plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            pcall(function()
                local TargetVelv5 = Plr.Character:FindFirstChild(getgenv().Forbidden.SilentTargeting and getgenv().Forbidden.SilentTargeting)
                if TargetVelv5 then
                    TargetVelv5.Velocity = Vector3.new(TargetVelv5.Velocity.X, (TargetVelv5.Velocity.Y * 0.2), TargetVelv5.Velocity.Z)
                    TargetVelv5.AssemblyLinearVelocity = Vector3.new(TargetVelv5.Velocity.X, (TargetVelv5.Velocity.Y * 0.2), TargetVelv5.Velocity.Z)
                end
            end)
        end
    end
end


local __FORBIDDEN_CORE = {}
__FORBIDDEN_CORE = {
cache = {},
init = function(module)
  if not __FORBIDDEN_CORE.cache[module] then
                         __FORBIDDEN_CORE.cache[module] = {
         data = __FORBIDDEN_CORE[module](),
            }
      end
    return __FORBIDDEN_CORE.cache[module].data
end,
}
             do
          function __FORBIDDEN_CORE.process1()
return 10
end
function __FORBIDDEN_CORE.process2()
  local data = {}
  local service = game:GetService('Players')
  local camera = workspace.CurrentCamera 
 function data.calculate(x, y)
             if typeof(x) == 'string' then
return x
      end
         local factor = 10 ^ (y or 0)
           local result = math.floor(x * factor + 0.5) / factor
    local _, fraction = math.modf(result)
              if fraction == 0 then
return string.format('%.0f', result) .. '.00'
                    else
              return string.format('%.' .. y .. 'f', result)
     end
   end
     function data.toVector2(v)
return Vector2.new(v.X, v.Y)
    end
end
__FORBIDDEN_CORE.process1()
__FORBIDDEN_CORE.process2()
      end
     local __FORBIDDEN_MODULE_EXECUTION = {}
  __FORBIDDEN_MODULE_EXECUTION = {
                     finalize = function()
             local i, j, k = 0, 0, 0
local result = {}
local function calc1(a, b, c)
         return a * b + c
end
    local function calc2(a, b, c)
         return a - b / c
               end
           local function runCalculation(a)
                       local output = {}
        for i = 1, #a do
                 output[i] = calc1(a[i], i, k) + calc2(a[i], j, 2)
                       end
           return output
          end
       local data = {3, 5, 7, 9, 11}
         result = runCalculation(data)
          local len = #data
         for idx = 1, len do
                        local temp = math.sqrt(calc1(data[idx], i, j) + calc2(data[idx], k, 1))
               table.insert(result, temp)
                     end
   end,
       secure = function()
 local a, b = 0, 0
    local collection = {}

     local function update(x, y, z)
     return x + y - z
   end

    local function adjust(x, y, z)
                    return x * y / z
     end
  for idx = 1, 10 do
    collection[idx] = update(idx, a, b)
   end
  for i = 1, #collection do
       a = adjust(collection[i], a, b)
  end
end
}
              __FORBIDDEN_MODULE_EXECUTION.finalize()
           __FORBIDDEN_MODULE_EXECUTION.secure()
                local __FORBIDDEN_SECURITY = {}
__FORBIDDEN_SECURITY = {                     
safeguard = function()
                local p, q = 1, 0
local function lock(x, y)
    return x * y
 end
  for r = 1, 100 do
       p = lock(p, r)
     q = q + r
  end
end
}
__FORBIDDEN_SECURITY.safeguard()
