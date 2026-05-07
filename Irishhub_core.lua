-- Irish Hub: Core Module
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")

local lp = Players.LocalPlayer
local COLORS = {
    MainBG = Color3.fromRGB(11, 14, 20),
    TabBG = Color3.fromRGB(15, 20, 28),
    Border = Color3.fromRGB(0, 170, 0),
    TextActive = Color3.fromRGB(0, 170, 0),
    TextInactive = Color3.fromRGB(140, 140, 140),
    RowBG = Color3.fromRGB(18, 24, 35)
}

-- Global State Management
_G.IrishConfig = {
    File = "Irish_Hub_Duels_config.json",
    States = {},
    Keybinds = {},
    LockUI = false
}

local function saveConfig()
    local data = HttpService:JSONEncode({Toggles = _G.IrishConfig.States, Keybinds = _G.IrishConfig.Keybinds})
    writefile(_G.IrishConfig.File, data)
end

-- Helper: Create Instance
local function create(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props) do if k ~= "Parent" then obj[k] = v end end
    obj.Parent = props.Parent
    return obj
end

-- Feature Logic Module
local Features = {}

function Features.ToggleSpeedVisual(state)
    if state then
        -- Insert SpeedVisual Logic Here (from your original script)
        print("Speed Visual Enabled")
    else
        -- Clean up BillboardGuis
    end
end

function Features.HandleFloat(state)
    _G.FloatActive = state
    task.spawn(function()
        while _G.FloatActive do
            local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 0, hrp.AssemblyLinearVelocity.Z)
            end
            task.wait()
        end
    end)
end

function Features.AutoMedusaLogic()
    -- Insert your Medusa distance check and tool:Activate() here
end

-- Infinite Jump Listener
UserInputService.JumpRequest:Connect(function()
    if _G.IrishConfig.States["Infinite Jump"] then
        local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.AssemblyLinearVelocity = Vector3.new(hrp.X, 54, hrp.Z) end
    end
end)

-- UI Assembly Module
local ScreenGui = create("ScreenGui", {Name = "IrishHub_Official", Parent = CoreGui, ResetOnSpawn = false})

local MainFrame = create("Frame", {
    Size = UDim2.new(0, 380, 0, 480),
    Position = UDim2.new(0.5, -190, 0.5, -240),
    BackgroundColor3 = COLORS.MainBG,
    Parent = ScreenGui
})

-- Adding a Toggle (Example)
local function AddToggle(name, callback)
    -- Your Toggle creation logic here
    -- When clicked, it calls Features.SomeFunction()
end

AddToggle("Speed Visual", function(state) Features.ToggleSpeedVisual(state) end)
AddToggle("Float", function(state) Features.HandleFloat(state) end)
AddToggle("Auto Medusa", function(state) _G.IrishConfig.States["Medusa"] = state end)

print("Irish Hub Loaded Successfully in Chunks")
