--[[
    strawberry maple sahur
    Defense (Full) / Kick (All) / ESP (All)
    Obsidian UI (deividcomsono) - Mobile Edition
]]

local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local ContextActionService = game:GetService("ContextActionService")
local PhysicsService = game:GetService("PhysicsService")

local localPlayer = Players.LocalPlayer

-- ============================================================
-- Library & Window (Obsidian)
-- ============================================================
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()

local Window = Library:CreateWindow({
    Title = "strawberry maple sahur",
    Footer = "version: 1.0",
    NotifySide = "Right",
    ShowCustomCursor = true,
    CornerRadius = 30,
})

local function _NOTIFY(arg, arg2)
    if type(arg) == "table" then
        Library:Notify(arg)
    else
        Library:Notify({
            Title = "strawberry maple sahur",
            Description = tostring(arg),
            Time = type(arg2) == "number" and arg2 or 4,
        })
    end
end
getgenv()._NOTIFY = _NOTIFY

-- ============================================================
-- サービス
-- ============================================================
local replicatedStorage = ReplicatedStorage
local runService = RunService
local workspace_ = Workspace
local userInputService = UserInputService

local spawnToyRemoteFunction = replicatedStorage:WaitForChild("MenuToys"):WaitForChild("SpawnToyRemoteFunction")
local ragdollRemote = replicatedStorage:WaitForChild("CharacterEvents"):WaitForChild("RagdollRemote")
local v = workspace_:WaitForChild(localPlayer.Name .. "SpawnedInToys")
local setNetworkOwner = replicatedStorage:WaitForChild("GrabEvents"):WaitForChild("SetNetworkOwner")
local look = replicatedStorage.CharacterEvents.Look

-- ============================================================
-- 状態
-- ============================================================
local tbl2 = {
    antiblob = false, antiLag1 = false, protectionEnabled = false, infjump = false,
    kickTargetPlayerDisplay = "All Players", kickTargetHeightMode = "Spawn",
    kickExcludeFriends = true, kickUseWhitelist = true,
    lineLagIntensity = 520, lineLagDelay = 1,
    loopKickBlobActive = false, loopKickBlobTarget = nil, loopKickBlobMode = "Default",
    gkaCircleRadius = 6, gkaCenterY = 50, gkaBlobRotateRadius = 18, gkaBlobRotateSpeed = 4,
    shurikenESPEnabled = false, blobmanESPEnabled = false,
    blobmanESPColorMode = "Rainbow", shurikenESPColorMode = "Rainbow",
    blobmanESPSolidColor = Color3.fromRGB(160, 0, 255), shurikenESPSolidColor = Color3.fromRGB(0, 230, 255),
    blobmanESPTransparency = 0.3, shurikenESPTransparency = 0.3, rainbowSpeedESP = 2,
    noksEspEnabled = false, noksBoxEnable = false,
    noksBoxColor1 = Color3.fromRGB(180, 140, 255), noksBoxColor2 = Color3.fromRGB(100, 50, 200),
    noksBoxGradient = false, noksBoxOutline = false,
    noksBoxOutlineColor1 = Color3.fromRGB(10, 10, 10), noksBoxOutlineColor2 = Color3.fromRGB(40, 40, 40),
    noksBoxOutlineGradient = false, noksBoxStrokeThickness = 1.5, noksBoxStrokeTrans = 30,
    noksBoxCornerRadius = 4, noksMaxBoxHeight = 350,
    noksNameEnable = false, noksNameColor = Color3.fromRGB(255, 255, 255),
    noksNameGradient = false,
    noksTextGradColor1 = Color3.fromRGB(255, 110, 110), noksTextGradColor2 = Color3.fromRGB(255, 230, 110),
    noksNameScrollSpeed = 4, noksTextFont = "GothamBold", noksTextSize = 11,
    noksTextStrokeThickness = 1, noksTextStrokeTrans = 30,
    noksLineEnable = false,
    noksLineColor1 = Color3.fromRGB(0, 230, 255), noksLineColor2 = Color3.fromRGB(255, 0, 150),
    noksLineGradient = false, noksLineThickness = 2, noksLineOutline = false,
    noksLineOutlineColor = Color3.fromRGB(0, 0, 0), noksLineStrokeThickness = 1,
    noksLineOrigin = "Bottom", noksLineAttachment = "Bottom",
    noksHealthBarEnable = false, noksHealthBarWidth = 3, noksHealthBarOffset = 6,
    noksHealthTextEnable = false, noksHealthGradient = false,
    noksHealthGrad1 = Color3.fromRGB(50, 255, 100), noksHealthGrad2 = Color3.fromRGB(255, 220, 50), noksHealthGrad3 = Color3.fromRGB(255, 50, 50),
    noksDistanceEnable = false, noksDistanceColor = Color3.fromRGB(240, 240, 240), noksMaxDistance = 2000,
    noksFlagsEnable = false, noksFlagSpacing = 2, noksFlagTextSize = 9,
    noksFlagNameEnable = true, noksFlagNameColor = Color3.fromRGB(220, 220, 220),
    noksFlagWeaponEnable = true, noksFlagWeaponColor = Color3.fromRGB(200, 200, 200),
    noksFlagStateEnable = true, noksFlagStateColor = Color3.fromRGB(255, 150, 50),
    noksBoxFill = false, noksGradientFill = false,
    noksGradientColor1 = Color3.fromRGB(140, 90, 255), noksGradientColor2 = Color3.fromRGB(0, 230, 255),
    noksBoxFillOpacity1 = 25, noksBoxFillOpacity2 = 5,
    noksGradientRotate = false, noksRotateSpeed = 3,
    noksSkeletonEnable = false, noksSkeletonThickness = 2, noksSkeletonGradient = false,
    noksSkeletonColor1 = Color3.fromRGB(180, 140, 255), noksSkeletonColor2 = Color3.fromRGB(0, 230, 255),
    noksSkeletonScroll = false, noksSkeletonScrollSpeed = 4,
    noksChamsEnable = false,
    noksChamsFillColor = Color3.fromRGB(140, 90, 255), noksChamsOutlineColor = Color3.fromRGB(255, 255, 255),
    noksChamsFillTransparency = 50, noksChamsOutlineTransparency = 0, noksChamsOcclusion = "Always See",
    noksFadeOutEnable = false, noksFadeDuration = 1.2,
    playerLocationVisualEnabled = false,
    locationESPCornerEnabled = true, locationESPThickness = 2, locationESPCornerRoundness = 0,
    locationESPLength = 12, locationESPRotationSpeed = 90, locationESPExpandSpeed = 3,
    locationESPMinRadius = 15, locationESPMaxRadius = 35,
    locationESPSmoothingEnabled = true, locationESPSmoothingSpeed = 15,
    locationESPColor = Color3.fromRGB(160, 0, 255),
    locationESPGradientEnabled = false,
    locationESPGradientColor1 = Color3.fromRGB(160, 0, 255), locationESPGradientColor2 = Color3.fromRGB(0, 230, 255),
    locationESPGradientSpeed = 1,
    locationESPUIGradientAngle = 0, locationESPUIGradientAutoRotate = false, locationESPUIGradientAutoSpeed = 20,
    locationESPPartEnabled = false, locationESPPartTransparency = 0.7,
    locationESPPartMaterial = "Neon", locationESPPartColor = Color3.fromRGB(160, 0, 255),
    locationESPBoxOutlineEnabled = false, locationESPBoxOutlineColor = Color3.fromRGB(255, 255, 255),
    locationESPBoxOutlineThickness = 0.05,
    locationESPCornerOutlineEnabled = false, locationESPCornerOutlineColor = Color3.fromRGB(0, 0, 0),
    locationESPCornerOutlineThickness = 1,
    locationESPGlowEnabled = false,
    locationESPGlowColor1 = Color3.fromRGB(160, 0, 255), locationESPGlowColor2 = Color3.fromRGB(0, 230, 255),
    locationESPGlowTransparency = 0.5, locationESPGlowSize = 20,
    locationESPTrailEnabled = false, locationESPTrailColor = Color3.fromRGB(160, 0, 255), locationESPTrailLifetime = 0.5,
    autoRunEnabled = false, targetToyName = "CreatureBlobman",
    currentInstance = nil, activeConnection = nil, originalPos = nil,
    ragdollRunning = false, autoSitEnabled = false, whitelistEnabled = false,
    characterInfJumpEnabled = false,
    blobmanAuraEnabled = false, blobmanAuraMode = "Kill Aura",
    blobmanAllEnabled = false, blobmanAllMode = "All Kill",
    blobmanAuraRunning = false, blobmanAllRunning = false,
    targetWalkSpeed = 16, targetJumpPower = 50,
    targetKillEnabled = false, targetKillRunning = false,
    selectedTargetPlayer = nil, lastTargetPosition = nil,
    selectedPlayerName = nil, selectedPart = "Head",
    radius = 20, speed = 3, height = 3, lerpAlpha = 0.25, obeyRightDistance = 5,
    characterWalkSpeedEnabled = false, characterWalkSpeed = 1,
    characterJumpPowerEnabled = false, characterJumpPower = 50,
    characterFOV = 70, characterSpinEnabled = false, characterSpinSpeed = 5, characterSpinAngle = 0,
    thirdPersonEnabled = false, headEnabled = false, legsEnabled = false,
    obeyPartEnabled = false, obeyAllEnabled = false, feetTPDeleteEnabled = false, headViewEnabled = false,
    notificationSoundEnabled = false, selectedNotificationSound = "Ahh~",
}

local tbl3 = {
    Wings = {}, connections = {}, visualConnections = {}, rainbowParts = {}, espObjects = {},
    rainbowHue = 0, whitelistedPlayers = {}, targetItems = {},
    antiExplosionConnection = nil, characterAddedConn = nil,
    kickAuraBlobman = nil, kickAuraCooldowns = {}, forceDisabledPlayers = {},
    kickAuraConnection = nil, forceDisabledConnection = nil,
    shurikenESPs = {}, blobmanESPs = {},
}

local tbl4 = {
    ANTI_DURATION = 0.5,
    SPAWN_POS = Vector3.new(0, 1e15, 0),
    partsPosition = Vector3.new(1, -6, 1),
    tpExitPosition = Vector3.one,
    randomPositions = {
        Vector3.new(282, -4.5, 470), Vector3.new(570, 124, -93), Vector3.new(530, 96, -376),
        Vector3.new(-500, -6, -155), Vector3.new(-560, -6, 86),
    },
    Offsets = { CFrame.new(-4.125, 0, 1), CFrame.new(4.125, 0, 1) },
    ATTACK_TARGETS = { "CreatureBlobman", "TractorRed", "TractorGreen", "TractorOrange" },
}

-- ============================================================
-- 共通ユーティリティ
-- ============================================================
local function getChar()
    return localPlayer.Character or localPlayer.CharacterAdded:Wait()
end

local function getCharInfo()
    local character = localPlayer.Character
    return character, character and character:FindFirstChild("HumanoidRootPart"), character and character:FindFirstChildOfClass("Humanoid")
end

local function GetPlayerListDisplay()
    local list = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            table.insert(list, player.DisplayName .. " @" .. player.Name)
        end
    end
    if #list == 0 then table.insert(list, "No Players") end
    return list
end

local function ExtractUsername(arg)
    if not arg or arg == "" or arg == "No Players" then return nil end
    return arg:match("@(.+)$")
end

local function isWhitelisted(player)
    if not tbl2.whitelistEnabled then return false end
    if player == localPlayer then return true end
    if localPlayer:IsFriendsWith(player.UserId) then return true end
    if tbl3.whitelistedPlayers[player.Name] then return true end
    return false
end

-- ============================================================
-- Tabs
-- ============================================================
local Tabs = {
    Defense = Window:AddTab("Defense", "shield"),
    Kick = Window:AddTab("Kick", "ban"),
    ESP = Window:AddTab("ESP", "eye"),
}

-- ============================================================
-- Defense Tab (Full)
-- ============================================================
local DisblVoid
do
    local isHeld = localPlayer:WaitForChild("IsHeld", 5)
    local tbl17 = {}
    local tbl18 = {
        CounterMethod = "Kill", TargetedLimbCA = "All", AntiLagSens = 3,
        AGType = "Normal", GucciType = "CreatureBlobman",
        AntiInputType = "FoodHamburger", InputLgDelay = 0.05, AILTransparency = 1,
        NKOffset = 15, NKDelayMode = "Normal",
    }
    local tbl19 = {
        AntiGrab = false, GucciAntiGrab = false, AntiBlobman = false, AntiInputLag = false,
        AntiExplosion = false, AntiBurn = false, AntiVoid = false, AntiKick = false, AntiKick2 = false,
        AntiSticky = false, AntiSnowball = false, AntiBanana = false, AntiPaint = false, AntiPoison = false,
        AntiLag = false, AutoAntiLag = true, AntiInvis = false, AutoReset = true, LoopTP = false,
        DestroyVoid = true, WaterWalk = false, DeleteBarriers = false, OtherInvCollisions = false,
        CounterAttack = false, LoopApplyMethodT = false, LoopApplyMethodTServer = false,
        RagdollInNK = true, RagdollInRG = false, DeleteShurInNK = true,
    }
    local tbl20 = {
        SelectedPlayers = {}, TargetMethods = {}, Whitelisted = {}, PlayerDropdowns = {},
        WhoGrabbed = nil, KickFlags = 0, LastKickFlagTime = 0,
        States = { Owning = false, Spawning = false, Ragdolling = false, Escaping = false },
        BrokenPlots = {}, FailedToys = {},
        GrabbableParts = setmetatable({}, { __mode = "k" }),
        LimbOffsetsRL = {
            Head = CFrame.new(0, 1.5, 0), ["Left Arm"] = CFrame.new(-1.5, 0, 0),
            ["Right Arm"] = CFrame.new(1.5, 0, 0), ["Left Leg"] = CFrame.new(-0.5, -2, 0),
            ["Right Leg"] = CFrame.new(0.5, -2, 0), Torso = CFrame.new(),
        },
        NetworkKickQueue = {}, DestroyThread = nil, AKType = "Shuriken",
        AntiKickSettings = {
            Highlight = false, HighlightFill = Color3.new(1, 0, 0), HighlightOutl = Color3.new(1, 1, 1),
            HighlightFT = 0.5, HighlightOT = 0, Transparency = 0.9,
        },
    }

    local tbl21, tbl22, tbl23, v21
    tbl21 = {}; tbl22 = {}; tbl23 = {}; v21 = nil
    local obj = setmetatable({}, { __mode = "k" })
    local obj2 = setmetatable({}, { __mode = "k" })
    local tbl25 = {}
    local tbl26 = {}

    local function notify(arg, arg2)
        if _NOTIFY then
            arg2 = arg2 and arg2 .. ": " or ""
            _NOTIFY(arg2 .. tostring(arg), 3)
        else
            warn((arg2 and arg2 .. ": " or "") .. tostring(arg))
        end
    end

    local function isRemoteRoot(inst)
        return inst and inst:FindFirstChild("GrabEvents") and inst:FindFirstChild("MenuToys") and inst:FindFirstChild("CharacterEvents")
    end
    local function locateRemoteRoot()
        if isRemoteRoot(replicatedStorage) then return replicatedStorage end
        for _, d in ipairs(replicatedStorage:GetDescendants()) do
            if isRemoteRoot(d) then return d end
        end
        return replicatedStorage
    end
    local function refreshRemotes()
        v21 = locateRemoteRoot()
        local grabEvents = replicatedStorage:FindFirstChild("GrabEvents")
        local menuToys = v21 and v21:FindFirstChild("MenuToys")
        local characterEvents = v21 and v21:FindFirstChild("CharacterEvents")
        local playerEvents = v21 and v21:FindFirstChild("PlayerEvents")
        tbl23.sno = grabEvents and grabEvents:FindFirstChild("SetNetworkOwner")
        tbl23.cgl = grabEvents and grabEvents:FindFirstChild("CreateGrabLine")
        tbl23.dgl = grabEvents and grabEvents:FindFirstChild("DestroyGrabLine")
        tbl23.Struggle = characterEvents and characterEvents:FindFirstChild("Struggle")
        tbl23.RagdollRemote = characterEvents and characterEvents:FindFirstChild("RagdollRemote")
        tbl23.spe = playerEvents and playerEvents:FindFirstChild("StickyPartEvent")
        tbl23.spawnEvent = menuToys and menuToys:FindFirstChild("SpawnToyRemoteFunction")
        tbl23.destroyToyEvent = menuToys and menuToys:FindFirstChild("DestroyToy")
        return v21
    end
    refreshRemotes()

    local function fireRemote(remote, ...)
        if not remote then return false, nil end
        return pcall(function(...)
            if remote:IsA("RemoteFunction") then return remote:InvokeServer(...) end
            remote:FireServer(...)
            return true
        end, ...)
    end

    tbl17.charp = function(player)
        local p = player or localPlayer
        local char = p and p.Character
        if not char then return nil, nil, nil end
        return char, char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"), char:FindFirstChildWhichIsA("Humanoid")
    end
    tbl17.getMagnitude = function(a, b)
        if not a or not b or not a:IsA("BasePart") or not b:IsA("BasePart") then return math.huge end
        return (a.Position - b.Position).Magnitude
    end
    tbl17.isnetworkowner = function(part)
        if typeof(part) ~= "Instance" or not part:IsA("BasePart") then return false end
        local root = part
        if part.Massless and part.AssemblyRootPart then root = part.AssemblyRootPart end
        if not root or root.Anchored then return false end
        if type(isnetworkowner) == "function" then
            local ok, result = pcall(isnetworkowner, root)
            if ok and type(result) == "boolean" then return result end
        end
        local ok, result = pcall(function() return root.ReceiveAge end)
        return ok and result == 0
    end
    tbl17.ispartowner = function(part)
        if typeof(part) ~= "Instance" or not part:IsA("BasePart") then return false end
        if part.Name == "HumanoidRootPart" then
            local parent = part.Parent
            if parent then
                local head = parent:FindFirstChild("Head")
                if head then
                    local po = head:FindFirstChild("PartOwner")
                    if po then return po.Value == localPlayer.Name end
                end
            end
        end
        local po = part:FindFirstChild("PartOwner")
        if po and po.Value == localPlayer.Name then return true end
        local parent = part.Parent
        if not parent then return false end
        local po2 = parent:FindFirstChild("PartOwner", true)
        if not po2 then return false end
        return po2.Value == localPlayer.Name
    end
    tbl17.WhichPlot = function(player)
        if typeof(player) ~= "Instance" or not player:IsA("Player") then return nil, nil end
        local plots = Workspace:FindFirstChild("Plots")
        if not plots then return nil, nil end
        for _, child in pairs(plots:GetChildren()) do
            local area = child:FindFirstChild("PlotArea")
            if area and area:IsA("BasePart") then
                local ok, result = pcall(function() return Workspace:GetPartsInPart(area) end)
                if ok and type(result) == "table" then
                    for _, p in pairs(result) do
                        p = p and p.Parent
                        if (p and Players:GetPlayerFromCharacter(p)) == player then
                            local iop = player:FindFirstChild("InOwnedPlot")
                            return child, iop and iop.Value
                        end
                    end
                end
            end
        end
        return nil, nil
    end

    local function removeSpawnSound(toy)
        task.spawn(function()
            local main = toy and toy:WaitForChild("Main", 0.4)
            local snd = main and main:WaitForChild("ItemSpawnSound", 0.4)
            if snd then snd:Destroy() end
        end)
    end

    tbl17.BreakPlot = function(player)
        if typeof(player) ~= "Instance" then return false end
        local plot = player
        local inPlot = nil
        if player:IsA("Player") then
            inPlot = player:FindFirstChild("InPlot")
            if not inPlot then return false end
            plot = tbl17.WhichPlot(player)
            if not plot then return false end
        end
        if typeof(plot) ~= "Instance" then return false end
        if tbl20.BrokenPlots[plot.Name] then return true end
        local area = plot:FindFirstChild("PlotArea")
        if not area then return false end
        refreshRemotes()
        if not tbl23.spe then return false end
        local shuriken = tbl17.st("NinjaShuriken")
        if not shuriken then return false end
        removeSpawnSound(shuriken)
        shuriken.Parent = nil
        local sticky = shuriken:WaitForChild("StickyPart", 0.4)
        local weld = sticky and sticky:WaitForChild("StickyWeld", 0.4)
        if not sticky or not weld then tbl17.dt(shuriken) return false end
        local cframe = CFrame.new(1099511627776, 1099511627776, 1099511627776)
        if plot.Name == "Plot5" then cframe = CFrame.new(2147483648, 2147483648, 2147483648) end
        if not tbl17.sno(sticky) then tbl17.dt(shuriken) return false end
        fireRemote(tbl23.spe, sticky, area, cframe)
        local now = tick()
        while true do
            if weld.Parent and tick() - now <= 0.8 then
                if not (weld.Part1 == area and (not inPlot or inPlot.Value ~= true)) then
                    task.wait()
                    continue
                end
            end
            break
        end
        if not weld.Parent or weld.Part1 ~= area or (inPlot and inPlot.Value == true) then
            tbl17.dt(shuriken)
            return false
        end
        tbl20.BrokenPlots[plot.Name] = shuriken
        pcall(function()
            shuriken.Destroying:Once(function()
                if tbl20.BrokenPlots[plot.Name] == shuriken then tbl20.BrokenPlots[plot.Name] = nil end
            end)
        end)
        return shuriken
    end

    local function performOwnershipGrabLoop(part, timeout, hrp, head, hum, useHidden)
        local cframe, cframe2, cframe3 = CFrame.new(), CFrame.new(), CFrame.new()
        local conn = nil
        local function setupHidden()
            cframe = hrp.CFrame; cframe2 = head.CFrame; cframe3 = hrp.CFrame
            pcall(function() runService:UnbindFromRenderStep("RSCClient") end)
            runService:BindToRenderStep("RSCClient", Enum.RenderPriority.Camera.Value - 1, function()
                if hrp.Parent then hrp.CFrame = cframe end
                if head.Parent then head.CFrame = cframe2 end
            end)
            conn = runService.Heartbeat:Connect(function()
                if not hrp.Parent or not head.Parent then return end
                cframe = hrp.CFrame; cframe2 = head.CFrame
                hrp.CFrame = cframe3; head.CFrame = cframe3
            end)
        end
        local function cleanupHidden()
            pcall(function() runService:UnbindFromRenderStep("RSCClient") end)
            if conn then conn:Disconnect() conn = nil end
            if head.Parent then head.CFrame = cframe2 end
            if hrp.Parent then hrp.CFrame = cframe end
        end
        local t = tonumber(timeout) or 0.65
        local now = tick()
        local ok, result = pcall(function()
            if useHidden then setupHidden() end
            while part.Parent and not tbl17.ispartowner(part) and hum.Health ~= 0 and hrp.Parent and tick() - now < t do
                if useHidden then cframe3 = part.CFrame - Vector3.new(0, 22, 0) end
                runService.Heartbeat:Wait()
                tbl17.grab(part, useHidden and cframe3 or nil)
            end
        end)
        if useHidden then pcall(cleanupHidden) end
        return ok, result
    end

    tbl17.sno = function(part, timeout)
        if typeof(part) ~= "Instance" or not part:IsA("BasePart") or not part.Parent then return false end
        local char, hrp, hum = tbl17.charp()
        local head = char and char:FindFirstChild("Head")
        local ragdolled = hum and hum:FindFirstChild("Ragdolled")
        if not char or not head or not hrp or not hum or not ragdolled or hum.Health <= 0 then return false end
        local spawn = Workspace:FindFirstChild("SpawnLocation")
        if not spawn or tbl17.getMagnitude(part, spawn) > 10000000 then return false end
        if tbl17.ispartowner(part) then return true end
        local far = (hrp.Position - part.Position).Magnitude >= 31
        if far and tbl20.States.Owning == true then return false end
        local isHRP = part.Name == "HumanoidRootPart" or part.Name == "Torso"
        local brokenToy = nil
        if isHRP then
            local owner = part.Parent and Players:FindFirstChild(part.Parent.Name)
            if owner and owner:IsA("Player") then
                local c, r, h = tbl17.charp(owner)
                if not h or h.Health == 0 then return false end
                local iop = owner:FindFirstChild("InPlot")
                iop = iop and iop.Value == true
                if iop then
                    brokenToy = tbl17.BreakPlot(owner)
                    if not brokenToy then return false end
                end
            end
        end
        tbl20.States.Owning = true
        local ok, result = performOwnershipGrabLoop(part, timeout, hrp, head, hum, far)
        tbl20.States.Owning = false
        if typeof(brokenToy) == "Instance" then task.delay(1, tbl17.dt, brokenToy) end
        if not ok then warn("[sno] " .. tostring(result)) return false end
        return tbl17.ispartowner(part)
    end
    tbl17.unsno = function(part)
        if not part then return false end
        refreshRemotes()
        if tbl23.dgl then return fireRemote(tbl23.dgl, part) end
        return false
    end
    tbl17.teleport = function(part, target, offset)
        if not part then return false end
        if typeof(part) == "Instance" and part:IsA("Model") then
            part = part.PrimaryPart or part:FindFirstChildWhichIsA("BasePart", true)
        end
        if typeof(part) ~= "Instance" or not part:IsA("BasePart") then return false end
        local cframe
        if typeof(target) == "CFrame" then cframe = target
        elseif typeof(target) == "Vector3" then cframe = CFrame.new(target)
        elseif typeof(target) == "Instance" then
            if target:IsA("BasePart") then cframe = target.CFrame
            elseif target:IsA("Model") then cframe = target:GetPivot() end
        end
        if not cframe then return false end
        if typeof(offset) == "CFrame" then cframe = cframe * offset end
        part.CFrame = cframe
        tbl17.resetVelocity(part)
        return true
    end
    tbl17.resetVelocity = function(part)
        if part and part:IsA("BasePart") then
            part.AssemblyLinearVelocity = Vector3.zero
            part.AssemblyAngularVelocity = Vector3.zero
        end
    end
    tbl17.FormatPlayer = function(player)
        if typeof(player) ~= "Instance" or not player:IsA("Player") then return tostring(player) end
        if player == localPlayer then return "You" end
        if player.DisplayName == player.Name then return player.Name end
        return string.format("%s (@%s)", player.DisplayName, player.Name)
    end
    tbl17.findNicePart = function(model)
        if typeof(model) ~= "Instance" or not model:IsA("Model") then return nil end
        local cached = tbl20.GrabbableParts[model]
        if cached then
            if cached.Parent and cached:IsA("BasePart") and cached.CanQuery and cached.Name ~= "Button" then return cached end
            tbl20.GrabbableParts[model] = nil
        end
        for _, child in pairs(model:GetChildren()) do
            if child:IsA("BasePart") and child.CanQuery and child.Name ~= "Button" then
                tbl20.GrabbableParts[model] = child
                return child
            end
        end
        return nil
    end
    tbl17.DestroyObject = function(model)
        if typeof(model) ~= "Instance" or not model:IsA("Model") then return false end
        local part = tbl17.findNicePart(model)
        if not part or not tbl17.sno(part) then return false end
        if DisblVoid and type(DisblVoid.SetDisabled) == "function" then
            pcall(function() DisblVoid:SetDisabled(true) end)
        end
        Workspace.FallenPartsDestroyHeight = (0/0)
        model:PivotTo(CFrame.new(0, -11111, 0))
        if tbl20.DestroyThread then pcall(task.cancel, tbl20.DestroyThread) end
        tbl20.DestroyThread = task.delay(0.25, function()
            Workspace.FallenPartsDestroyHeight = -10000
            task.wait()
            Workspace.FallenPartsDestroyHeight = tbl19.DestroyVoid and (0/0) or -100
            if DisblVoid and type(DisblVoid.SetDisabled) == "function" then
                pcall(function() DisblVoid:SetDisabled(false) end)
            end
        end)
        return true
    end
    tbl17.getInventory = function(player)
        if typeof(player) ~= "Instance" or not player:IsA("Player") then return nil, nil end
        local inv = Workspace:FindFirstChild(player.Name .. "SpawnedInToys")
        local plots = Workspace:FindFirstChild("Plots")
        local plotItems = Workspace:FindFirstChild("PlotItems")
        local hasBoth = plots and plotItems
        local plotInv = nil
        if hasBoth then
            for _, child in pairs(plots:GetChildren()) do
                local sign = child:FindFirstChild("PlotSign")
                sign = sign and sign:FindFirstChild("ThisPlotsOwners")
                if sign then
                    for _, sv in pairs(sign:GetChildren()) do
                        if sv:IsA("StringValue") and sv.Value == player.Name then
                            plotInv = plotItems:FindFirstChild(child.Name)
                        end
                    end
                end
            end
        end
        return inv, plotInv
    end
    tbl17.kill = function(player)
        local char, hrp, hum = tbl17.charp(player)
        if hum and hum.Health ~= 0 and hrp then
            if Workspace:FindFirstChild("SpawnLocation") then tbl17.getMagnitude(Workspace.SpawnLocation, hrp) end
            if tbl17.sno(hrp) then
                hum.BreakJointsOnDeath = false
                hum.Sit = false
                hum:ChangeState(Enum.HumanoidStateType.Dead)
                tbl17.teleport(hrp, CFrame.new(0, 9e9, 0))
                task.delay(2, tbl17.unsno, hrp)
            end
        end
    end
    tbl17.void = function(player)
        local char, hrp, hum = tbl17.charp(player)
        if hum and hum.Health ~= 0 and hrp then
            local spawn = Workspace:FindFirstChild("SpawnLocation")
            if (not spawn or tbl17.getMagnitude(spawn, hrp) < 15000) and tbl17.sno(hrp) then
                tbl17.teleport(hrp, CFrame.new(0, 9e9, 0))
                hrp.Velocity = Vector3.new(0, 9e9, 0)
                task.delay(0.35, tbl17.unsno, hrp)
            end
        end
    end
    tbl17.grab = function(part, cframe)
        local char, hrp, hum = tbl17.charp()
        if not hrp or not hum or hum.Health == 0 then return end
        if not part or not part.Parent or not part:IsA("BasePart") then return end
        refreshRemotes()
        if not tbl23.sno then return end
        cframe = cframe or hrp.CFrame
        if typeof(cframe) ~= "CFrame" then return end
        local pos = part.Position
        local lookCF = CFrame.new((cframe * CFrame.new(0, 1.593, 0)).Position, pos)
        tbl23.sno:FireServer(part, lookCF)
    end

    local function limbMatchesMode(part, mode)
        if not part:IsA("BasePart") then return false end
        local isArm = part.Name:find("Arm") ~= nil
        local isLeg = part.Name:find("Leg") ~= nil
        if mode == "Arms" then return isArm end
        if mode == "Legs" then return isLeg end
        if mode == "All" then return isArm or isLeg end
        return false
    end

    tbl17.breaklimb = function(player, mode)
        local isSelf = player == localPlayer
        if isSelf and tbl19.GucciAntiGrab then notify("Can't break limbs while in Gucci!") return false end
        local char, hrp, hum = tbl17.charp(player)
        local ragdolled = hum and hum:FindFirstChild("Ragdolled")
        if not hrp or not hum or hum.Health == 0 or not ragdolled then return false end
        local children = char:GetChildren()
        local found = false
        for _, child in ipairs(children) do
            if limbMatchesMode(child, mode) then found = true break end
        end
        if not found then return false end
        if isSelf then
            refreshRemotes()
            if not tbl23.RagdollRemote then return false end
            fireRemote(tbl23.RagdollRemote, hrp, 0.35)
            local now = tick()
            while true do
                task.wait()
                if ragdolled.Value then break
                elseif tick() - now > 0.5 then break end
            end
        else
            if not tbl17.sno(hrp) then return false end
            if not tbl17.ragdoll(char) then return false end
        end
        if not ragdolled.Value then return false end
        for _, child in ipairs(children) do
            if limbMatchesMode(child, mode) then child.CFrame = CFrame.new(0, -100000, 0) end
        end
        task.wait(0.15)
        if isSelf then
            tbl17.grab(hrp)
            task.wait()
            refreshRemotes()
            if tbl23.RagdollRemote then fireRemote(tbl23.RagdollRemote, hrp, 0) end
        else
            Workspace.FallenPartsDestroyHeight = -1000
            tbl17.teleport(hrp, CFrame.new(0, -1100, 0))
            task.wait()
            Workspace.FallenPartsDestroyHeight = tbl19.DestroyVoid and (0/0) or -100
            tbl17.unsno(hrp)
        end
        return true
    end

    local function recoveredYield(t)
        local n = t or 0
        local now = tick()
        repeat runService.Heartbeat:Wait() until tick() - now >= n
        return true
    end

    tbl17.ExtraEscape = function()
        local char, hrp, hum = tbl17.charp()
        if not hrp or not hum or hum.Health == 0 or tbl20.States.Escaping then return end
        local inPlot = localPlayer:FindFirstChild("InPlot")
        if not inPlot or inPlot.Value then return end
        tbl20.States.Escaping = true
        local wp = Workspace:FindFirstChild("Waypoints")
        wp = wp and wp:FindFirstChild("TudorHouse")
        if not wp then tbl20.States.Escaping = false return end
        local tractor = tbl17.st("TractorGreen", wp.CFrame)
        if not tractor then tbl20.States.Escaping = false return end
        local seat = tractor:WaitForChild("VehicleSeat", 1)
        if not seat then tbl20.States.Escaping = false return tbl17.dt(tractor) end
        local now = tick()
        local flag = false
        hum.Sit = false
        seat:Sit(hum)
        local conn = seat.ChildAdded:Connect(function(child)
            if child.Name == "SeatWeld" then
                child.Enabled = false
                flag = true
                child:Destroy()
            end
        end)
        while true do
            recoveredYield()
            if flag then break
            elseif tick() - now > 0.7 then break end
        end
        conn:Disconnect()
        hum.Sit = false
        tbl20.States.Escaping = false
        return tbl17.dt(tractor)
    end

    local function breakVehicleSeat(seat, hum, hrp, playerHRP)
        if tbl19.GucciAntiGrab then return false end
        if not seat or not seat.Parent then return false end
        if not (seat:IsA("VehicleSeat") or seat:IsA("Seat")) then return false end
        if seat.Occupant or seat:GetAttribute("broken") then return false end
        if not hum or hum.Health == 0 or not hrp then return false end
        hum.Sit = false
        if tbl19.RagdollInRG and playerHRP then tbl17.sno(playerHRP, 1.5) end
        seat.CanCollide = false
        local broke = false
        local conn = seat.ChildAdded:Connect(function(child)
            if child.Name == "SeatWeld" then
                pcall(function() child.Enabled = false end)
                child:Destroy()
                broke = true
            end
        end)
        local now = tick()
        while seat.Parent and hum.Parent and not broke and tick() - now <= 0.5 do
            runService.Heartbeat:Wait()
            seat:Sit(hum)
        end
        hum.Sit = false
        local parent = seat.Parent
        task.delay(0.5, function()
            if seat and parent then
                pcall(function()
                    seat.Parent = replicatedStorage
                    task.wait()
                    seat.Parent = parent
                end)
            end
        end)
        if broke then
            seat:SetAttribute("broken", true)
            if conn then conn:Disconnect() end
            local c2 = nil
            c2 = seat.ChildAdded:Connect(function(child)
                if child.Name ~= "SeatWeld" then return end
                local _, cHrp = tbl17.charp()
                local p1 = nil
                pcall(function() p1 = child.Part1 end)
                if p1 ~= cHrp then
                    seat:SetAttribute("broken", false)
                    if c2 then c2:Disconnect() end
                end
            end)
            return true
        end
        hum.Sit = true
        task.wait(0.05)
        hum.Sit = false
        if conn then conn:Disconnect() end
        return false
    end

    local function applySeatBreakerToInventory(inv, hum, hrp, playerHRP)
        if not inv then return end
        for _, child in ipairs(inv:GetChildren()) do
            if child:IsA("Model") then
                local seat = child:FindFirstChildWhichIsA("VehicleSeat") or child:FindFirstChildWhichIsA("Seat")
                if seat then breakVehicleSeat(seat, hum, hrp, playerHRP) end
            end
        end
    end

    tbl17.RemoveGucci = function(player)
        local char, hrp, hum = tbl17.charp()
        local _, tHrp, tHum = tbl17.charp(player)
        local inv, plotInv = tbl17.getInventory(player)
        if not hum or hum.Health <= 0 or not hrp or not inv or not tHum then return false end
        local seat = tHum.SeatPart
        if not seat then
            applySeatBreakerToInventory(inv, hum, hrp, tHrp)
            if plotInv then applySeatBreakerToInventory(plotInv, hum, hrp, tHrp) end
            return nil
        end
        if tHum.Sit then
            applySeatBreakerToInventory(inv, hum, hrp, tHrp)
            if plotInv then applySeatBreakerToInventory(plotInv, hum, hrp, tHrp) end
            return nil
        end
        seat:SetAttribute("broken", false)
        return breakVehicleSeat(seat, hum, hrp, tHrp)
    end
    tbl17.DeleteSeatables = function(player)
        local char, hrp, hum = tbl17.charp()
        local inv, plotInv = tbl17.getInventory(player)
        if not hum or hum.Health <= 0 or not hrp or not inv then return false end
        local function process(inv2)
            if not inv2 then return end
            for _, child in ipairs(inv2:GetChildren()) do
                if child:IsA("Model") then
                    local pp = child.PrimaryPart or tbl17.findNicePart(child)
                    if pp and pp:IsA("BasePart") and pp.Velocity.Magnitude <= 10 then
                        local vs = child:FindFirstChild("VehicleSeat")
                        if vs and not vs.Occupant then tbl17.DestroyObject(child) end
                    end
                end
            end
        end
        process(inv)
        if plotInv then process(plotInv) end
        return nil
    end
    tbl17.EatAntiInput = function(player)
        local char = player and player.Character
        local leftArm = char and char:FindFirstChild("Left Arm")
        local char2, hrp, hum = tbl17.charp()
        local leftArm2 = char2 and char2:FindFirstChild("Left Arm")
        leftArm2 = leftArm2 and leftArm2:FindFirstChild("LeftGripAttachment")
        local plotItems = Workspace:FindFirstChild("PlotItems")
        if not leftArm or not char2 or not leftArm2 or not hum or hum.Health == 0 or not plotItems then return false end
        local flag = false
        for _, connected in pairs(leftArm:GetConnectedParts()) do
            if connected.Name == "HoldPart" and not connected:IsDescendantOf(plotItems) then
                local parent = connected.Parent
                local holdRF = connected:WaitForChild("HoldItemRemoteFunction", 0.45)
                local dropRF = connected:WaitForChild("DropItemRemoteFunction", 0.45)
                local rigid = connected:WaitForChild("RigidConstraint", 0.45)
                if holdRF and dropRF and rigid then
                    rigid.Enabled = false
                    local now = tick()
                    while char2.Parent and parent.Parent and leftArm2.Parent and rigid.Parent and rigid.Attachment1 ~= leftArm2 and hum.Health ~= 0 and tick() - now < 1 do
                        task.spawn(function()
                            local ok, err = pcall(function() holdRF:InvokeServer(parent, char2) end)
                            if not ok then warn("[EatAntiInput] " .. tostring(err)) end
                        end)
                        task.wait()
                    end
                    if rigid.Parent and rigid.Attachment1 == leftArm2 then
                        task.spawn(function()
                            local ok, err = pcall(function() dropRF:InvokeServer(parent) end)
                            if not ok then warn("[EatAntiInput/drop] " .. tostring(err)) end
                        end)
                        pcall(function() dropRF:Destroy() end)
                        flag = true
                    end
                end
            end
        end
        return flag
    end
    tbl17.RemoveInvisibility = function(player)
        local char, hrp, hum = tbl17.charp(player)
        if not hrp or not hum or hum.Health == 0 then return false end
        hrp.Massless = false
        return true
    end
    tbl17.ToggleCollisions = function(model, enable, skipRL, customPhys)
        if typeof(model) ~= "Instance" or not model:IsA("Model") then return end
        for _, child in pairs(model:GetChildren()) do
            if child:IsA("BasePart") then
                if enable then
                    if child.Name == "Torso" or child.Name == "Head" then child.CanCollide = true end
                else
                    child.CanCollide = false
                    if not skipRL then
                        local rlp = child:FindFirstChild("RagdollLimbPart")
                        if rlp then rlp.CanCollide = false end
                    end
                end
                if child.Name ~= "HumanoidRootPart" then
                    local pp = nil
                    if customPhys then pp = PhysicalProperties.new(0.01, 0.01, 0.01, 0.01, 0.01) end
                    child.CustomPhysicalProperties = pp
                end
            end
        end
    end
    tbl17.ToggleMotor6D = function(model, enable, useConstraints)
        if typeof(model) ~= "Instance" or not model:IsA("Model") then return false end
        local hum = model:FindFirstChild("Humanoid")
        local torso = model:FindFirstChild("Torso")
        if not hum or not torso then return false end
        local ragdolled = hum:FindFirstChild("Ragdolled")
        if not ragdolled then return false end
        if ragdolled.Value ~= true then
            for _, child in pairs(torso:GetChildren()) do
                if child:IsA("Motor6D") then child.Enabled = enable end
            end
            return true
        end
        if not useConstraints then return false end
        for _, name in pairs({ "Left Leg", "Right Leg", "Left Arm", "Right Arm", "Head" }) do
            local p = model:FindFirstChild(name)
            if p then
                local bsc = p:FindFirstChild("BallSocketConstraint")
                if bsc then bsc.Enabled = enable end
            end
        end
        return true
    end
    tbl17.RepositionLimbs = function(model, resetVel)
        if typeof(model) ~= "Instance" or not model:IsA("Model") then return false end
        local hrp = model:FindFirstChild("HumanoidRootPart")
        if not hrp then return false end
        local torso = model:FindFirstChild("Torso")
        if not torso then return false end
        local neck = torso:FindFirstChild("Neck")
        if neck and neck.Enabled == true then return false end
        for k, offset in pairs(tbl20.LimbOffsetsRL) do
            local p = model:FindFirstChild(k)
            if p and p:IsA("BasePart") then
                p.CFrame = hrp.CFrame * offset
                if resetVel then tbl17.resetVelocity(p) end
            end
        end
        return true
    end
    tbl17.removesticky = function(model)
        if typeof(model) ~= "Instance" or not model:IsA("Model") or not model.Parent then return false end
        local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso")
        if not hrp or not hrp:IsA("BasePart") then return false end
        local plotItems = Workspace:FindFirstChild("PlotItems")
        local stSet = setmetatable({}, { __mode = "k" })
        local function register(inst)
            if typeof(inst) ~= "Instance" then return end
            local parent
            if inst:IsA("BasePart") then parent = inst.Parent else parent = inst end
            if parent and parent:IsA("Model") and parent ~= model and parent.Parent then stSet[parent] = true end
        end
        for _, d in pairs(model:GetDescendants()) do
            if d:IsA("BasePart") then
                for _, c in pairs(d:GetConnectedParts()) do
                    if c.Name == "StickyPart" then
                        for _, child in pairs(c:GetChildren()) do
                            if child:IsA("TouchInterest") then child:Destroy() end
                        end
                        register(c)
                    end
                end
            end
        end
        local player = Players:GetPlayerFromCharacter(model)
        if player then
            local inv, plotInv = tbl17.getInventory(player)
            if inv then for _, child in pairs(inv:GetChildren()) do register(child) end end
            if plotInv then for _, child in pairs(plotInv:GetChildren()) do register(child) end end
        end
        local flag = false
        for k in pairs(stSet) do
            if k.Parent then
                local ok, pivot = pcall(k.GetPivot, k)
                if ok and (pivot.Position - hrp.Position).Magnitude <= 10 then
                    local nice = tbl17.findNicePart(k)
                    if nice and nice:IsA("BasePart") then
                        local bv = nice:FindFirstChild("RscBV")
                        if bv and not bv:IsA("BodyVelocity") then bv:Destroy() bv = nil end
                        if not bv then
                            local bodyVelocity = Instance.new("BodyVelocity")
                            bodyVelocity.Velocity = Vector3.new(0, -50000, 0)
                            bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                            bodyVelocity.Name = "RscBV"
                            bodyVelocity.Parent = nice
                        end
                        tbl17.ToggleCollisions(k, false)
                        if not (plotItems and k:IsDescendantOf(plotItems)) then tbl17.grab(nice) end
                        local sticky = k:FindFirstChild("StickyPart")
                        if sticky then
                            for _, child in pairs(sticky:GetChildren()) do child:Destroy() end
                        end
                        k:PivotTo(CFrame.new(0, -50000, 0))
                        task.delay(1, tbl17.unsno, nice)
                        flag = true
                    end
                end
            end
        end
        return flag
    end
    tbl17.ragdoll = function(target, timeout)
        if typeof(target) ~= "Instance" then return end
        local torso, hum
        if target:IsA("Player") then
            local c = target.Character
            torso = c and c:FindFirstChild("Torso")
            hum = c and c:FindFirstChild("Humanoid")
        elseif target:IsA("Model") then
            local head = target:FindFirstChild("Head")
            torso = target:FindFirstChild("Torso")
            hum = target:FindFirstChild("Humanoid")
            if not head then return end
        else
            if not target:IsA("BasePart") then return end
            local isModel = target.Parent and target.Parent:IsA("Model")
            if isModel then
                hum = target.Parent:FindFirstChild("Humanoid")
                torso = target
            else
                torso = target
            end
        end
        if not torso or not torso:IsA("BasePart") or not torso.Parent or not hum then return end
        local ragdolled = hum:FindFirstChild("Ragdolled")
        if not ragdolled then return end
        if ragdolled.Value ~= false then return end
        if tbl20.States.Ragdolling then return end
        torso.CanCollide = false
        tbl20.States.Ragdolling = true
        local inv = Workspace:FindFirstChild(localPlayer.Name .. "SpawnedInToys")
        if not inv then tbl20.States.Ragdolling = false return end
        local rsc = inv:FindFirstChild("RagdollRSC") or tbl17.st("PalletLightBrown")
        if not rsc then tbl20.States.Ragdolling = false return end
        local sound = rsc:WaitForChild("SoundPart", 0.5)
        if not sound or not sound:IsA("BasePart") then
            tbl20.States.Ragdolling = false
            tbl17.dt(rsc)
            return
        end
        local main = rsc:WaitForChild("Main", 0.5)
        if not main or not main:IsA("BasePart") then
            tbl20.States.Ragdolling = false
            tbl17.dt(rsc)
            return
        end
        if not tbl17.sno(sound) then
            tbl20.States.Ragdolling = false
            tbl17.dt(rsc)
            return
        end
        rsc.Name = "RagdollRSC"
        local bp = main:FindFirstChild("RagdollBP")
        if bp and not bp:IsA("BodyPosition") then bp:Destroy() bp = nil end
        if not bp then
            local newBP = Instance.new("BodyPosition")
            newBP.Name = "RagdollBP"
            newBP.D = 1500
            newBP.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            newBP.Position = Vector3.new(0, 100000, 0)
            newBP.Parent = main
        else
            bp.D = 1500
            bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bp.Position = Vector3.new(0, 100000, 0)
        end
        local now = tick()
        while rsc.Parent and sound.Parent and torso.Parent and ragdolled.Parent and ragdolled.Value ~= true and tick() - now <= 0.5 do
            sound.Position = torso.Position
            sound.Velocity = Vector3.new(0, -10, 0)
            task.wait(0.1)
        end
        tbl20.States.Ragdolling = false
        return ragdolled.Value
    end
    tbl17.st = function(name, cframe)
        if type(name) ~= "string" or tbl20.FailedToys[name] then return nil end
        local char, hrp = tbl17.charp()
        if not hrp or tbl20.States.Spawning then return nil end
        local inPlot = localPlayer:FindFirstChild("InPlot")
        local inOwnedPlot = localPlayer:FindFirstChild("InOwnedPlot")
        local isOtherPlot = inPlot ~= nil and inPlot.Value == true
        if isOtherPlot then isOtherPlot = not (inOwnedPlot ~= nil and inOwnedPlot.Value == true) end
        if isOtherPlot and tbl20.States.Owning then return nil end
        refreshRemotes()
        if not tbl23.spawnEvent or not tbl23.spawnEvent:IsA("RemoteFunction") then return nil end
        local inv = Workspace:FindFirstChild(localPlayer.Name .. "SpawnedInToys")
        if not inv then return nil end
        tbl20.States.Spawning = true
        if isOtherPlot then tbl20.States.Owning = true end
        local conn1, conn2 = nil, nil
        local hidden = false
        local savedCF = hrp.CFrame
        local spawned = nil
        local function cleanup()
            if hidden then
                pcall(function() runService:UnbindFromRenderStep("STClient") end)
                hidden = false
            end
            if conn2 then conn2:Disconnect() conn2 = nil end
            if conn1 then conn1:Disconnect() conn1 = nil end
            if isOtherPlot and hrp and hrp.Parent then hrp.CFrame = savedCF end
            tbl20.States.Spawning = false
            if isOtherPlot then tbl20.States.Owning = false end
        end
        local ok, err = pcall(function()
            local canSpawn = localPlayer:FindFirstChild("CanSpawnToy")
            if canSpawn then
                while canSpawn.Value == false do
                    task.wait()
                    if not hrp.Parent then return end
                end
            end
            local baseCF = isOtherPlot and CFrame.new(0, 25, 0) or hrp.CFrame + Vector3.new(0, 15, 0)
            local spawnCF = CFrame.new((typeof(cframe) == "CFrame" and cframe or baseCF).Position) + Vector3.new(0, 0, 20)
            local rotPart = Workspace:FindFirstChild("RotateOrientPart")
            local rotation = rotPart and rotPart.Rotation or Vector3.zero
            conn1 = inv.ChildAdded:Connect(function(child)
                if child.Name == name then
                    spawned = child
                    if conn1 then conn1:Disconnect() conn1 = nil end
                end
            end)
            savedCF = hrp.CFrame
            if isOtherPlot then
                local hideCF = CFrame.new(0, 10, 0)
                pcall(function() runService:UnbindFromRenderStep("STClient") end)
                runService:BindToRenderStep("STClient", Enum.RenderPriority.Camera.Value - 1, function()
                    if hrp.Parent then hrp.CFrame = savedCF end
                end)
                hidden = true
                conn2 = runService.Heartbeat:Connect(function()
                    if hrp.Parent then
                        savedCF = hrp.CFrame
                        hrp.CFrame = hideCF
                    end
                end)
            end
            local function invokeSpawn() fireRemote(tbl23.spawnEvent, name, spawnCF, rotation) end
            task.spawn(invokeSpawn)
            local now = tick()
            while true do
                runService.Heartbeat:Wait()
                if isOtherPlot then task.spawn(invokeSpawn) end
                local done = spawned or tick() - now > 1.3
                if done then break end
            end
        end)
        cleanup()
        if not ok then warn(("[st] %s"):format(tostring(err))) return nil end
        if not spawned then
            tbl20.FailedToys[name] = true
            task.delay(2, function() tbl20.FailedToys[name] = nil end)
        end
        return spawned
    end
    tbl17.dt = function(model)
        if typeof(model) ~= "Instance" or not model:IsA("Model") then return false end
        refreshRemotes()
        if not tbl23.destroyToyEvent then return false end
        return fireRemote(tbl23.destroyToyEvent, model) == true
    end

    -- Anti-Grab
    local agConn = nil
    local agSavedCF = nil
    local function stopAntiGrab()
        if agConn then agConn:Disconnect() agConn = nil end
        tbl20.States["Anti Grab"] = false
        local _, _, hum = tbl17.charp()
        if hum then
            if tbl18.AGType == "Anti-Kill" then
                task.delay(0.1, function() if hum.Parent then hum.Sit = false end end)
            end
            hum.AutoRotate = true
        end
    end
    local function startAntiGrabIfNeeded()
        if not tbl19.AntiGrab or not isHeld.Value or tbl20.States["Anti Grab"] then return end
        refreshRemotes()
        if tbl23.Struggle then fireRemote(tbl23.Struggle) end
        local char, hrp, hum = tbl17.charp()
        local torso = char and char:FindFirstChild("Torso")
        local neck = torso and torso:FindFirstChild("Neck")
        if not hum or not torso then return end
        hum.RequiresNeck = false
        tbl17.resetVelocity(hrp or torso)
        agSavedCF = torso.CFrame
        tbl20.States["Anti Grab"] = true
        local buggy = tbl18.AGType == "Escapes Anything, but buggy"
        local sit = tbl18.AGType == "Anti-Kill"
        local noRag = tbl18.AGType == "No Ragdoll"
        if buggy then task.spawn(tbl17.ExtraEscape) end
        local now = tick()
        agConn = runService.Heartbeat:Connect(function(dt)
            if tbl23.Struggle then fireRemote(tbl23.Struggle) end
            if hrp and not buggy and not noRag and tbl23.RagdollRemote then
                fireRemote(tbl23.RagdollRemote, hrp, sit and 0.11 or 0)
            end
            if buggy then
                if tick() - now > 2 then
                    task.spawn(tbl17.ExtraEscape)
                    now = tick()
                end
            end
            local moveDir = hum.MoveDirection
            local speed = 16
            if hum.WalkSpeed > 16 then speed = hum.WalkSpeed end
            if moveDir.Magnitude > 0 then
                agSavedCF = agSavedCF + moveDir.Unit * speed * dt
                local planar = Vector3.new(moveDir.X, 0, moveDir.Z)
                if planar.Magnitude > 0 then
                    local pos = agSavedCF.Position
                    agSavedCF = agSavedCF:Lerp(CFrame.lookAt(pos, pos + planar.Unit), 0.12)
                end
            end
            tbl17.resetVelocity(hrp or torso)
            torso.CFrame = agSavedCF
            hum.Sit = sit
            task.spawn(tbl17.ToggleCollisions, char, false)
            if not neck or not neck.Enabled then task.spawn(tbl17.RepositionLimbs, char) end
            for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                local anim = track.Animation
                if anim and anim.AnimationId == "rbxassetid://7047322890" then track:Stop() end
            end
            if hrp then
                local scream = hrp:FindFirstChild("Scream")
                if scream then scream.Playing = false end
            end
            if not isHeld.Value or not tbl19.AntiGrab then
                tbl20.States["Anti Grab"] = false
                if sit then
                    task.delay(0.1, function() if hum.Parent then hum.Sit = false end end)
                end
                hum.AutoRotate = true
                if agConn then agConn:Disconnect() agConn = nil end
            end
        end)
    end
    task.spawn(function()
        while task.wait(0.03) do
            if tbl19.AntiGrab then startAntiGrabIfNeeded()
            elseif tbl20.States["Anti Grab"] then stopAntiGrab() end
        end
    end)

    -- Gucci Anti-Grab
    local gucciCount = 0
    local gucciCleanup = nil
    local function stopGucciAntiGrab()
        gucciCount += 1
        if gucciCleanup then
            local c = gucciCleanup
            gucciCleanup = nil
            pcall(c)
        end
    end
    local function runGucciAntiGrab()
        gucciCount += 1
        local myId = gucciCount
        local toy, seat, nicePart, toyType = nil, nil, nil, nil
        local conn = nil
        local function cleanup()
            if conn then conn:Disconnect() conn = nil end
            if toy then tbl17.dt(toy) toy = nil end
            seat = nil nicePart = nil toyType = nil
        end
        gucciCleanup = cleanup
        local function waitTypeChange(oldType)
            while true do
                task.wait()
                if not (tbl18.GucciType ~= oldType or not tbl19.GucciAntiGrab or myId ~= gucciCount) then continue end
                break
            end
        end
        local function hideDescendant(d)
            if d:IsA("BasePart") then
                d.Transparency = 1
                d.CanCollide = false
            elseif d:IsA("Decal") or d:IsA("Texture") then
                d.Transparency = 1
            elseif d.Name == "ItemSpawnSound" then
                d:Destroy()
            end
        end
        local function sitLoop()
            local char, hrp, hum = tbl17.charp()
            if not hum or hum.Health == 0 then return end
            local ragdolled = hum:FindFirstChild("Ragdolled")
            if not hrp or not ragdolled or isHeld.Value or ragdolled.Value or hum.Health <= 0 then return end
            if hum.Sit then hum.Sit = false end
            local gType = tbl18.GucciType
            local reuse = toy and toy.Parent and seat and seat.Parent and toyType == gType
            local valid = false
            if reuse then
                local occ = seat.Occupant
                if occ == nil or occ == hum then valid = true end
            end
            if not valid then
                cleanup()
                if gType == "Train" then
                    local map = Workspace:FindFirstChild("Map")
                    map = map and map:FindFirstChild("AlwaysHereTweenedObjects")
                    map = map and map:FindFirstChild("Train")
                    local obj = map and map:FindFirstChild("Object")
                    obj = obj and obj:FindFirstChild("ObjectModel")
                    if not obj then
                        notify("Train doesn't exist!")
                        waitTypeChange(gType)
                        return
                    end
                    toy = obj
                    seat = toy:FindFirstChildWhichIsA("Seat")
                    nicePart = nil
                    toyType = gType
                    if not seat then
                        notify("Train doesn't have seats!")
                        waitTypeChange(gType)
                        cleanup()
                        return
                    end
                else
                    toy = tbl17.st(gType, CFrame.new(100000, 500000, 0))
                    seat = toy and toy:WaitForChild("VehicleSeat", 1.25)
                    nicePart = seat and tbl17.findNicePart(toy) or nil
                    toyType = gType
                    if toy then
                        for _, d in pairs(toy:GetDescendants()) do hideDescendant(d) end
                        conn = toy.DescendantAdded:Connect(hideDescendant)
                    end
                    if not seat then cleanup() return end
                end
            end
            local active = true
            if nicePart then
                local bp = nicePart:FindFirstChild("GucciBP")
                if bp then bp:Destroy() end
            end
            seat.Transparency = 1
            seat.CanCollide = false
            local gotWeld = false
            local savedCF = hrp.CFrame
            local now = tick()
            seat.ChildAdded:Once(function(child)
                if child.Name == "SeatWeld" then
                    child.Enabled = false
                    child:Destroy()
                    gotWeld = true
                end
            end)
            local ragdollFlag = false
            refreshRemotes()
            task.defer(function()
                while hum and hum.Health > 0 and active and task.wait() do
                    ragdollFlag = true
                    if tbl23.RagdollRemote then fireRemote(tbl23.RagdollRemote, hrp, 0) end
                end
                ragdollFlag = true
            end)
            while true do
                task.wait()
                if ragdollFlag or myId ~= gucciCount then break end
            end
            if myId ~= gucciCount then
                active = false
                return
            end
            seat:Sit(hum)
            while true do
                task.wait()
                local stop = hum.Health <= 0 or not hrp.Parent or not toy.Parent or not seat.Parent
                if not stop then
                    stop = isHeld.Value or ragdolled.Value or gotWeld or tick() - now > 0.75
                    if not stop then continue end
                end
                break
            end
            if gotWeld then
                hum.Sit = false
                task.delay(0.15, function()
                    active = false
                    task.wait()
                    if tbl23.RagdollRemote and hrp.Parent then fireRemote(tbl23.RagdollRemote, hrp, 0.15) end
                end)
                if nicePart and toy.Parent and seat.Parent then
                    local plotItems = Workspace:FindFirstChild("PlotItems")
                    local owned = plotItems and nicePart:IsDescendantOf(plotItems) or tbl17.isnetworkowner(nicePart)
                    if owned or tbl17.sno(nicePart) then
                        local randomPos = Vector3.new(math.random(-100000, 100000), 100000, math.random(-100000, 100000))
                        local bp = Instance.new("BodyPosition")
                        bp.Name = "GucciBP"
                        bp.D = 200
                        bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                        bp.Position = randomPos
                        toy.Name = "GucciRSC"
                        bp.Parent = nicePart
                    end
                end
                task.delay(0.75, function()
                    if not seat or not seat.Parent or not toy or not toy.Parent then return end
                    seat.Parent = replicatedStorage
                    task.wait()
                    if hum and hum.Parent then hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end
                    if toy and toy.Parent and seat then seat.Parent = toy end
                end)
                while true do
                    local parentsOK = toy.Parent and seat.Parent and hum.Parent
                    local cont = parentsOK and hum.Health > 0 and not isHeld.Value and not ragdolled.Value
                        and (seat.Occupant == nil or seat.Occupant == hum)
                        and tbl19.GucciAntiGrab and tbl18.GucciType == gType and myId == gucciCount
                    if cont then task.wait() continue end
                    break
                end
                local occ = seat.Occupant
                if occ and occ ~= hum and occ.Parent then
                    local p = Players:FindFirstChild(occ.Parent.Name)
                    if p then notify(p.DisplayName .. " sat on your gucci!") end
                end
                if hum and hum.Parent and hum.Health > 0 then
                    local sp = hum.SeatPart
                    if sp and sp ~= seat then notify("You can't sit on other Vehicles while in Gucci!", "Invincibility") end
                    hum.Sit = true
                    task.wait(0.05)
                    hum.Sit = false
                    task.wait(0.05)
                end
            end
            if conn then conn:Disconnect() conn = nil end
            if toy and toy.Parent then tbl17.dt(toy) end
            toy = nil seat = nil nicePart = nil toyType = nil
            task.wait(0.05)
        end
        while tbl19.GucciAntiGrab and myId == gucciCount do sitLoop() end
        cleanup()
        if gucciCleanup == cleanup then gucciCleanup = nil end
    end

    -- Anti Blobman
    task.spawn(function()
        local savedRoot, boolVal = nil, nil
        while task.wait() do
            local char, hrp, hum = tbl17.charp()
            if not hrp or not hum then
                if savedRoot and savedRoot.Parent then savedRoot:Destroy() end
                savedRoot = nil
            elseif tbl19.AntiBlobman then
                if (not savedRoot or not savedRoot.Parent) and hrp:FindFirstChild("RootAttachment") then
                    task.wait(0.5)
                    local ra = hrp:FindFirstChild("RootAttachment")
                    if ra and v21 then
                        ra.Parent = replicatedStorage
                        boolVal = Instance.new("BoolValue")
                        boolVal.Name = "RootAttachment"
                        boolVal.Parent = hrp
                        savedRoot = ra
                    end
                end
                hum.Massless = false
            else
                if savedRoot then savedRoot.Parent = hrp savedRoot = nil end
                if boolVal then boolVal:Destroy() boolVal = nil end
            end
        end
    end)

    -- Anti Input Lag
    task.spawn(function()
        local inputToy, remoteEvent = nil, nil
        while true do
            task.wait(tbl18.InputLgDelay)
            if tbl19.AntiInputLag then
                refreshRemotes()
                local grabEvents = v21 and v21:FindFirstChild("GrabEvents")
                if grabEvents and not remoteEvent then
                    local ege = grabEvents:FindFirstChild("EndGrabEarly")
                    if ege then ege:Destroy() end
                    remoteEvent = Instance.new("RemoteEvent")
                    remoteEvent.Name = "EndGrabEarly"
                    remoteEvent.Parent = grabEvents
                end
                local char, hrp, hum = tbl17.charp()
                inputToy = inputToy or tbl17.st(tbl18.AntiInputType, CFrame.new(0, 1e20, 0))
                if inputToy and inputToy.Parent then
                    local hold = inputToy:WaitForChild("HoldPart", 2)
                    local holdRF = hold and hold:WaitForChild("HoldItemRemoteFunction", 2)
                    local dropRF = holdRF and hold:WaitForChild("DropItemRemoteFunction", 2)
                    local rigid = hold and hold:FindFirstChild("RigidConstraint")
                    for _, d in ipairs(inputToy:GetDescendants()) do
                        if d:IsA("BasePart") then
                            d.CanCollide = false
                            if d:IsA("MeshPart") or d.Name == "Part" then
                                d.Transparency = tbl18.AILTransparency
                                continue
                            end
                            continue
                        end
                        if d:IsA("Decal") then d.Transparency = tbl18.AILTransparency end
                    end
                    if char and hum and hum.Health > 0 and hold and holdRF and dropRF then
                        task.spawn(function() pcall(function() dropRF:InvokeServer(inputToy, CFrame.new(0, 1e20, 0), Vector3.new()) end) end)
                        task.spawn(function() pcall(function() holdRF:InvokeServer(inputToy, char) end) end)
                        if rigid then
                            local la = char:FindFirstChild("Left Arm")
                            local ra = char:FindFirstChild("Right Arm")
                            la = la and la:FindFirstChild("LeftGripAttachment")
                            ra = ra and ra:FindFirstChild("RightGripAttachment")
                            local a1 = rigid.Attachment1
                            if a1 and a1 ~= la and a1 ~= ra then
                                tbl17.dt(inputToy)
                                inputToy = nil
                                continue
                            end
                            continue
                        end
                        continue
                    end
                    tbl17.dt(inputToy)
                    inputToy = nil
                end
            else
                if inputToy then tbl17.dt(inputToy) inputToy = nil end
                if remoteEvent then remoteEvent:Destroy() remoteEvent = nil end
            end
        end
    end)

    -- Anti Explosion
    Workspace.ChildAdded:Connect(function(child)
        if child.Name ~= "Part" or not tbl19.AntiExplosion or not child:IsA("BasePart") then return end
        local char, hrp, hum = tbl17.charp()
        if not char or not hrp or not hum or (child.Position - hrp.Position).Magnitude > 20 then return end
        hrp.Anchored = true
        task.wait(0.02)
        if not hum.SeatPart then hum.Sit = false end
        local ragdolls = nil
        pcall(function() ragdolls = char:QueryDescendants("#RagdollLimbPart") end)
        if ragdolls then
            for _, p in pairs(ragdolls) do p.CanCollide = false end
        else
            for _, d in ipairs(char:GetDescendants()) do
                if d:IsA("BasePart") and (d.Name == "RagdollLimbPart" or d:GetAttribute("RagdollLimbPart")) then
                    d.CanCollide = false
                end
            end
        end
        tbl17.resetVelocity(hrp)
        hrp.Anchored = false
    end)

    -- Anti Burn
    local function bindAntiBurn(character)
        local hrp = character and character:WaitForChild("HumanoidRootPart", 2)
        if not hrp then return end
        hrp.ChildAdded:Connect(function(child)
            if child.Name ~= "FireParticleEmitter" or not tbl19.AntiBurn then return end
            local map = Workspace:FindFirstChild("Map")
            local hole = map and map:FindFirstChild("Hole")
            hole = hole and hole:FindFirstChild("PoisonSmallHole")
            hole = hole and hole:FindFirstChild("ExtinguishPart")
            if not hole or not hole:IsA("BasePart") then return end
            local savedCF = hole.CFrame
            local fireLight = hrp:FindFirstChild("FireLight")
            if fireLight then fireLight:Destroy() end
            if child:IsA("ParticleEmitter") then child.Enabled = false end
            local pg = localPlayer:FindFirstChildOfClass("PlayerGui")
            pg = pg and pg:FindFirstChild("ScreenOverlayGui")
            pg = pg and pg:FindFirstChild("FireFade")
            if pg and pg:IsA("GuiObject") then pg.Visible = false end
            while child and child.Parent and hrp.Parent do
                hole.CFrame = hrp.CFrame
                task.wait()
            end
            if hole.Parent then hole.CFrame = savedCF end
        end)
    end
    do
        local map = Workspace:FindFirstChild("Map")
        local hole = map and map:FindFirstChild("Hole")
        hole = hole and hole:FindFirstChild("PoisonSmallHole")
        hole = hole and hole:FindFirstChild("ExtinguishPart")
        if hole and hole:IsA("BasePart") then
            local tex = hole:FindFirstChild("Tex")
            if tex then tex:Destroy() end
            hole.Transparency = 1
        end
    end
    localPlayer.CharacterAdded:Connect(bindAntiBurn)
    if localPlayer.Character then task.defer(bindAntiBurn, localPlayer.Character) end

    -- Anti Void
    task.spawn(function()
        while task.wait(0.03) do
            if tbl19.AntiVoid then
                local _, hrp = tbl17.charp()
                if hrp and (hrp.Position.Y >= 10000 or hrp.Position.Y <= -500) then
                    tbl17.teleport(hrp, CFrame.new(0, 15, 0))
                end
            end
        end
    end)

    -- Anti Kick (Shuriken)
    local akShuriken = nil
    local function destroyAKShuriken()
        if akShuriken then tbl17.dt(akShuriken) akShuriken = nil end
    end
    local function getAKParts()
        if not akShuriken or not akShuriken.Parent then return nil, nil end
        local sp = akShuriken:FindFirstChild("StickyPart")
        if not sp then return nil, nil end
        return sp, sp:FindFirstChild("StickyWeld")
    end
    local function akAttachedTo(part)
        if not akShuriken or not akShuriken.Parent or akShuriken.Name ~= "ShurikenRSC" then return false end
        local sp, sw = getAKParts()
        if not sp or not sw then return false end
        return sw.Part1 == part
    end
    local function syncProps(target, src)
        for k, v in next, src, nil do
            if target[k] ~= v then
                local cur = target[k]
                if type(cur) ~= "number" then target[k] = v
                elseif type(v) ~= "number" then target[k] = v
                elseif math.abs(cur - v) > 1e-5 then target[k] = v end
            end
        end
    end
    local function applyAKAppearance()
        if not akShuriken or not akShuriken.Parent then return end
        local h = akShuriken:FindFirstChild("ShurHighlight")
        if not h then
            h = Instance.new("Highlight")
            h.Name = "ShurHighlight"
            h.Adornee = akShuriken
            h.Parent = akShuriken
        end
        syncProps(h, {
            Enabled = tbl20.AntiKickSettings.Highlight,
            FillColor = tbl20.AntiKickSettings.HighlightFill,
            OutlineColor = tbl20.AntiKickSettings.HighlightOutl,
            FillTransparency = tbl20.AntiKickSettings.HighlightFT,
            OutlineTransparency = tbl20.AntiKickSettings.HighlightOT,
        })
        local trans = tbl20.AntiKickSettings.Transparency
        for _, child in ipairs(akShuriken:GetChildren()) do
            if child:IsA("BasePart") then
                if child.Transparency ~= trans then
                    if child:IsA("MeshPart") or child.Name == "Part" then syncProps(child, { Transparency = trans }) end
                end
                child.CanCollide = false
                child.CanQuery = false
            end
        end
    end
    local function attachAKShuriken(part)
        if not akShuriken or not akShuriken.Parent then
            if akShuriken then tbl17.dt(akShuriken) end
            akShuriken = tbl17.st("NinjaShuriken", part.CFrame + Vector3.new(0, 15, 0))
            if not akShuriken then return false end
        end
        local sp = akShuriken:WaitForChild("StickyPart", 1.5)
        if not sp then destroyAKShuriken() return false end
        local sw = sp:WaitForChild("StickyWeld", 1.5)
        if not sw then destroyAKShuriken() return false end
        if not tbl17.sno(sp) then destroyAKShuriken() return false end
        akShuriken.Name = "ShurikenRSC"
        task.spawn(function()
            local ti = sp:WaitForChild("TouchInterest", 2.5)
            if ti then ti:Destroy() end
        end)
        refreshRemotes()
        if tbl23.spe then
            fireRemote(tbl23.spe, sp, part, CFrame.new(0, -0.3, 0) * CFrame.Angles(1.5707963267948966, 0, 0))
        end
        local now = tick()
        while true do
            recoveredYield()
            if sw.Part1 == part then break
            else
                if not (not sw.Parent or not part.Parent or not sp.Parent or not akShuriken or not akShuriken.Parent) then
                    local _, _, hum = tbl17.charp()
                    if not (not hum or hum.Health == 0) then
                        if not (tick() - now > 0.5) then continue end
                    end
                end
                break
            end
        end
        return sw.Parent ~= nil
    end
    task.spawn(function()
        while task.wait(0.03) do
            if tbl19.AntiKick then
                local char, hrp, hum = tbl17.charp()
                if hrp and hum then
                    local hb = hrp:FindFirstChild("RagdollTouchedHitbox")
                    if hb and hum.Health > 0 then
                        local inPlot = localPlayer:FindFirstChild("InPlot")
                        local inOwned = localPlayer:FindFirstChild("InOwnedPlot")
                        if inPlot and inPlot.Value then
                            while inPlot.Value and (not inOwned or not inOwned.Value) do task.wait() end
                        end
                        if tbl20.AKType == "Shuriken" then
                            if (akAttachedTo(hb) or attachAKShuriken(hb)) and akShuriken and akShuriken.Parent then
                                applyAKAppearance()
                            end
                        end
                    end
                end
            else
                destroyAKShuriken()
            end
        end
    end)

    -- Anti Kick 2 (Break PCLD)
    local function runPCLDKillLoop(hum, stopFn)
        repeat
            hum.Health = 0
            pcall(function() hum:ChangeState(Enum.HumanoidStateType.Dead) end)
            recoveredYield()
        until stopFn()
    end
    local function runPCLDBreakSequence(hum)
        local result = nil
        if hum.Health <= 0 then notify("Detected death, breaking PCLD again...", "PCLD Breaker")
        else
            notify("Starting PCLD Break...", "PCLD Breaker")
            task.spawn(runPCLDKillLoop, hum, function() return result ~= nil end)
        end
        result = localPlayer.CharacterAdded:Wait()
        local hum2 = result:WaitForChild("Humanoid", 5)
        if not hum2 then return end
        local result2 = nil
        task.spawn(runPCLDKillLoop, hum2, function() return result2 ~= nil end)
        result2 = localPlayer.CharacterAdded:Wait()
        local hum3 = result2:WaitForChild("Humanoid", 5)
        if not hum3 then return end
        hum3:SetAttribute("BrokenPCLD", true)
        notify("Done!", "PCLD Breaker")
    end
    task.spawn(function()
        while task.wait(0.2) do
            if tbl19.AntiKick2 then
                local _, _, hum = tbl17.charp()
                if hum and (not hum:GetAttribute("BrokenPCLD") or hum.Health <= 0) then
                    runPCLDBreakSequence(hum)
                end
            end
        end
    end)

    -- Anti Sticky / Snowball / Banana / Paint / Poison / Lag / Invis
    do
        local stickyCount = 0
        local function startAntiStickyLoop()
            stickyCount += 1
            local myId = stickyCount
            task.spawn(function()
                while tbl19.AntiSticky and myId == stickyCount and task.wait(0.1) do
                    local char = tbl17.charp()
                    if char then
                        for _, d in ipairs(char:GetDescendants()) do
                            if d:IsA("BasePart") then
                                for _, c in ipairs(d:GetConnectedParts()) do
                                    if c.Name == "StickyPart" then
                                        local plotItems = Workspace:FindFirstChild("PlotItems")
                                        local inOwned = localPlayer:FindFirstChild("InOwnedPlot")
                                        local inOwnedVal = inOwned and inOwned.Value
                                        if not plotItems or not c:IsDescendantOf(plotItems) or inOwnedVal then
                                            for _, ch in ipairs(c:GetChildren()) do
                                                if ch:IsA("TouchInterest") then ch:Destroy() end
                                            end
                                            local nice = tbl17.findNicePart(c.Parent)
                                            if nice then tbl17.grab(nice) end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
        getgenv()._defense_startAntiStickyLoop = startAntiStickyLoop

        task.spawn(function()
            task.wait(0.5)
            while task.wait(0.03) do
                if tbl19.AntiSnowball then
                    if tbl19.GucciAntiGrab then
                        repeat task.wait() until not tbl19.GucciAntiGrab
                        task.wait(1)
                    end
                    if tbl19.AntiBanana then
                        local rightLeg = tbl17.charp()
                        rightLeg = rightLeg and rightLeg:FindFirstChild("Right Leg")
                        while rightLeg do
                            task.wait()
                            local c = tbl17.charp()
                            if not c then rightLeg = nil
                            else rightLeg = c:FindFirstChild("Right Leg") end
                        end
                    end
                    local char, hrp, hum = tbl17.charp()
                    if hrp and hum and hum.Health ~= 0 then
                        local weld = hrp:FindFirstChild("WeldHRP")
                        if weld then
                            refreshRemotes()
                            if tbl23.RagdollRemote then fireRemote(tbl23.RagdollRemote, hrp, 0.5) end
                            if not hum.SeatPart then hum.Sit = false end
                            hum.AutoRotate = true
                            if weld.Enabled then
                                ContextActionService:UnbindAction("JumpRemover")
                                hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                                tbl17.RepositionLimbs(char)
                                tbl17.ToggleCollisions(char, false, false, true)
                            end
                        end
                    end
                end
            end
        end)

        task.spawn(function()
            task.wait(2)
            while task.wait(0.03) do
                if tbl19.AntiBanana then
                    local char, hrp, hum = tbl17.charp()
                    local rightLeg = char and char:FindFirstChild("Right Leg")
                    if char and rightLeg and hrp and hum then
                        if hum.Health == 0 then
                            localPlayer.CharacterAdded:Wait()
                            task.wait(0.5)
                        elseif tbl17.isnetworkowner(hrp) then
                            local hadGucci = tbl19.GucciAntiGrab
                            if hadGucci then
                                if toggles.GucciAntiGrab then toggles.GucciAntiGrab:SetValue(false) end
                                task.wait(0.25)
                            end
                            hum.Sit = false
                            hum.HipHeight = 2
                            tbl17.breaklimb(localPlayer, "Legs")
                            local conn = nil
                            conn = hum:GetPropertyChangedSignal("HipHeight"):Connect(function()
                                if tbl19.AntiBanana then hum.HipHeight = 2
                                elseif conn then conn:Disconnect() end
                            end)
                            local now = tick()
                            while true do
                                task.wait()
                                if not rightLeg.Parent then break
                                else
                                    if hum.Health ~= 0 then
                                        if not (tick() - now > 0.75) then continue end
                                    end
                                    break
                                end
                            end
                            if hadGucci and toggles.GucciAntiGrab then toggles.GucciAntiGrab:SetValue(true) end
                        end
                    end
                end
            end
        end)

        local paintConns = {}
        local paintConn = nil
        local function applyPaintPart(part, enabled)
            if not part:IsA("BasePart") or part.Name ~= "PaintPlayerPart" then return end
            part.CanTouch = not enabled
            if enabled and not paintConns[part] then
                paintConns[part] = part:GetPropertyChangedSignal("CanTouch"):Connect(function()
                    if tbl19.AntiPaint and part.Parent then part.CanTouch = false end
                end)
            end
        end
        local function applyAntiPaint(enabled)
            for k, c in pairs(paintConns) do
                c:Disconnect()
                paintConns[k] = nil
                if k.Parent then k.CanTouch = true end
            end
            if paintConn then paintConn:Disconnect() paintConn = nil end
            for _, d in ipairs(Workspace:GetDescendants()) do applyPaintPart(d, enabled) end
            if enabled then paintConn = Workspace.DescendantAdded:Connect(function(d) applyPaintPart(d, true) end) end
        end
        local function applyAntiPoison(enabled)
            local map = Workspace:FindFirstChild("Map")
            local hole = map and map:FindFirstChild("Hole")
            if not hole then return end
            local holes = { hole:FindFirstChild("PoisonBigHole"), hole:FindFirstChild("PoisonSmallHole") }
            for _, h in ipairs(holes) do
                if h then
                    local php = h:FindFirstChild("PoisonHurtPart")
                    local ppp = h:FindFirstChild("PaintPlayerPart")
                    if php and php:IsA("BasePart") then php.CanTouch = not enabled end
                    if ppp and ppp:IsA("BasePart") then ppp.CanTouch = not enabled end
                end
            end
        end
        local function applyAntiLag(enabled)
            tbl19.AntiLag = enabled
            local ps = localPlayer:FindFirstChild("PlayerScripts")
            local cabm = ps and ps:FindFirstChild("CharacterAndBeamMove")
            local sptd = ps and ps:FindFirstChild("StickyPartsTouchDetection")
            if cabm then cabm.Enabled = not enabled end
            if sptd then sptd.Enabled = not enabled end
            if enabled then
                task.delay(1.5, function()
                    for _, p in ipairs(Players:GetPlayers()) do
                        local c = p.Character
                        if c then
                            for _, child in ipairs(c:GetChildren()) do
                                if child.Name == "GrabParts" then child:Destroy() end
                            end
                        end
                    end
                end)
            end
        end
        getgenv()._defense_applyAntiPaint = applyAntiPaint
        getgenv()._defense_applyAntiPoison = applyAntiPoison
        getgenv()._defense_applyAntiLag = applyAntiLag

        local lastAutoCheck = 0
        runService.RenderStepped:Connect(function(dt)
            if not tbl19.AutoAntiLag or os.clock() - lastAutoCheck < 2.5 or dt <= 0 then return end
            lastAutoCheck = os.clock()
            if math.floor(1 / dt) < tbl18.AntiLagSens and toggles.AntiLag and not toggles.AntiLag.Value then
                notify("Anti Lag Enabled || Too low fps", "Auto Anti Lag")
                toggles.AntiLag:SetValue(true)
            end
        end)

        local invisCount = 0
        local function startAntiInvisLoop()
            invisCount += 1
            local myId = invisCount
            task.spawn(function()
                while tbl19.AntiInvis and myId == invisCount and task.wait(0.1) do
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= localPlayer then
                            local _, hrp, hum = tbl17.charp(p)
                            if hrp then hrp.Massless = false end
                            if hum and hum.Sit and hum.SeatPart then
                                local sw = hum.SeatPart:FindFirstChild("SeatWeld")
                                if sw and not sw.Enabled then sw.Enabled = true end
                            end
                        end
                    end
                end
            end)
        end
        getgenv()._defense_startAntiInvisLoop = startAntiInvisLoop
    end

    -- Auto Reset
    do
        local autoResetConn = nil
        local function onPossibleKickFlag(flag)
            if flag ~= "Flying" then return end
            local now = tick()
            if now - tbl20.LastKickFlagTime <= 1 then tbl20.KickFlags += 1
            else
                tbl20.LastKickFlagTime = now
                tbl20.KickFlags = 1
            end
            if not tbl19.AutoReset then return end
            if tbl20.KickFlags < 4 then
                local _, _, hum = tbl17.charp()
                if hum then
                    pcall(function()
                        hum:ChangeState(Enum.HumanoidStateType.Running)
                        hum:ChangeState(Enum.HumanoidStateType.Dead)
                    end)
                    if tbl20.KickFlags == 1 then notify("Reset due to kick flag", "Auto Reset") end
                end
            else
                localPlayer:Kick("Resonance (Auto Reset)\nAvoided Kick")
            end
        end
        local function bindAutoResetRemote()
            refreshRemotes()
            local gce = v21 and v21:FindFirstChild("GameCorrectionEvents")
            gce = gce and gce:FindFirstChild("GameCorrectionsNotify")
            if not gce or not gce:IsA("RemoteEvent") then return false end
            if autoResetConn then autoResetConn:Disconnect() end
            autoResetConn = gce.OnClientEvent:Connect(onPossibleKickFlag)
            return true
        end
        if not bindAutoResetRemote() then
            task.spawn(function()
                while task.wait(0.5) do
                    if bindAutoResetRemote() then break end
                end
            end)
        end
    end

    -- Loop TP
    do
        local loopTPCount = 0
        local function startLoopTP()
            loopTPCount += 1
            local myId = loopTPCount
            task.spawn(function()
                local char, savedCF = tbl17.charp()
                savedCF = savedCF and savedCF.CFrame or CFrame.new(0, -5, 0)
                while tbl19.LoopTP and myId == loopTPCount and task.wait(0.04) do
                    local c = tbl17.charp()
                    if c then c:PivotTo(CFrame.new(math.random(-1000, 1000), -7.35, math.random(-1000, 1000))) end
                end
                local c = tbl17.charp()
                if c then c:PivotTo(savedCF) end
            end)
        end
        getgenv()._defense_startLoopTP = startLoopTP
    end

    -- Misc 系
    local function applyDisableVoid(enabled)
        tbl19.DestroyVoid = enabled
        if enabled then Workspace.FallenPartsDestroyHeight = (0/0)
        else Workspace.FallenPartsDestroyHeight = -100 end
    end
    local function applyWaterWalk(enabled)
        tbl19.WaterWalk = enabled
        local map = Workspace:FindFirstChild("Map")
        map = map and map:FindFirstChild("AlwaysHereTweenedObjects")
        local ocean = map and map:FindFirstChild("Ocean")
        ocean = ocean and ocean:FindFirstChild("Object")
        ocean = ocean and ocean:FindFirstChild("ObjectModel")
        if not ocean then return end
        for _, child in ipairs(ocean:GetChildren()) do
            if child:IsA("BasePart") then
                if enabled then
                    child.CanCollide = true
                    if child.Transparency ~= 1 then child.Transparency = 0.5 end
                else
                    child.CanCollide = false
                    if child.Transparency ~= 1 then child.Transparency = 0 end
                end
            end
        end
    end
    local function applyDeleteBarriers(enabled)
        tbl19.DeleteBarriers = enabled
        local plots = Workspace:FindFirstChild("Plots")
        if not plots then return end
        for _, child in ipairs(plots:GetChildren()) do
            local barrier = child:FindFirstChild("Barrier")
            if barrier then
                for _, b in ipairs(barrier:GetChildren()) do
                    if b:IsA("BasePart") and b.Name == "PlotBarrier" then
                        b.CanCollide = not enabled
                    end
                end
            end
        end
    end
    local otherInvCount = 0
    local function startOtherInvCollisions()
        otherInvCount += 1
        local myId = otherInvCount
        task.spawn(function()
            while tbl19.OtherInvCollisions and myId == otherInvCount and task.wait(0.1) do
                local char = tbl17.charp()
                if char then
                    for _, d in ipairs(char:GetDescendants()) do
                        if d:IsA("BasePart") then pcall(function() PhysicsService:SetPartCollisionGroup(d, "PlotPlayers") end) end
                    end
                end
            end
            local char = tbl17.charp()
            if char then
                local inOwned = localPlayer:FindFirstChild("InOwnedPlot", true)
                local inOwnedVal = inOwned and inOwned:IsA("BoolValue") and inOwned.Value
                local grp = inOwnedVal and "PlotPlayers" or "Players"
                for _, d in ipairs(char:GetDescendants()) do
                    if d:IsA("BasePart") then pcall(function() PhysicsService:SetPartCollisionGroup(d, grp) end) end
                end
            end
        end)
    end
    getgenv()._defense_startOtherInvCollisions = startOtherInvCollisions

    -- 安全足場
    do
        local safePlatform = Instance.new("Part")
        safePlatform.Name = "Safe Platform"
        safePlatform.Size = Vector3.new(250, 5, 250)
        safePlatform.Position = Vector3.new(math.random(-25000, 25000), -500, math.random(-25000, 25000))
        safePlatform.Anchored = true
        safePlatform.CanCollide = true
        safePlatform.Material = Enum.Material.Neon
        safePlatform.Parent = Workspace
    end

    -- Counter Attack
    local counterConn = nil
    local function handleCounterAttackChild(child, hrp)
        if not child:IsA("StringValue") or child.Name ~= "PartOwner" then return end
        local owner = Players:FindFirstChild(child.Value)
        if not owner then return end
        tbl20.WhoGrabbed = tbl17.FormatPlayer(owner)
        if not tbl19.CounterAttack or tbl20.Whitelisted[owner] then return end
        local _, tHrp = tbl17.charp(owner)
        if tbl18.CounterMethod == "Kill" then tbl17.kill(owner)
        elseif tbl18.CounterMethod == "Void" then tbl17.void(owner)
        elseif tbl18.CounterMethod == "Grab" then tbl17.grab(tHrp)
        elseif tbl18.CounterMethod == "Delete Limbs" then tbl17.breaklimb(owner, tbl18.TargetedLimbCA)
        elseif tbl18.CounterMethod == "Fling" then
            if tHrp and hrp and tbl17.sno(tHrp) then
                tHrp.Velocity = hrp.CFrame.LookVector * 100 + Vector3.new(0, 25, 0)
            end
        elseif tbl18.CounterMethod == "Teleport to Spawn" then
            if tHrp and tbl17.sno(tHrp) then tbl17.teleport(tHrp, CFrame.new(0, 10, 0)) end
        end
    end
    local function bindCounterAttack(character)
        local _, hrp = tbl17.charp()
        local head = character and character:FindFirstChild("Head")
        if not head then return end
        if counterConn then counterConn:Disconnect() end
        counterConn = head.ChildAdded:Connect(function(child) handleCounterAttackChild(child, hrp) end)
    end
    if localPlayer.Character then task.defer(bindCounterAttack, localPlayer.Character) end
    localPlayer.CharacterAdded:Connect(function(character)
        task.wait()
        bindCounterAttack(character)
    end)

    -- Target Extras
    local TargetTab_DeathNotif = false
    local TargetTab_DeathSound = false
    local targetDeathState = {}
    runService.Heartbeat:Connect(function()
        for k, sel in pairs(tbl20.SelectedPlayers) do
            if sel then
                local c = k.Character
                local hum = c and c:FindFirstChild("Humanoid")
                if hum and hum.Health <= 0 and not targetDeathState[k] then
                    targetDeathState[k] = true
                    if TargetTab_DeathNotif then _NOTIFY("Target Dead: " .. k.Name, 3) end
                    if TargetTab_DeathSound and tbl2.notificationSoundEnabled then
                        local sndId = { ["Ahh~"] = "rbxassetid://140095282951107" }[tbl2.selectedNotificationSound]
                        if sndId then
                            pcall(function()
                                local snd = Instance.new("Sound")
                                snd.SoundId = sndId
                                snd.Volume = 1
                                snd.Parent = game:GetService("SoundService")
                                snd:Play()
                                snd.Ended:Connect(function() snd:Destroy() end)
                            end)
                        end
                    end
                elseif c and hum and hum.Health > 0 then
                    targetDeathState[k] = false
                end
            end
        end
    end)

    -- Defense GUI
    local Antis = Tabs.Defense:AddLeftGroupbox("Antis")
    Antis:AddToggle("AntiGrab", { Text = "Anti Grab", Default = false, Tooltip = "The most default anti-grab",
        Callback = function(v) tbl19.AntiGrab = v if v then startAntiGrabIfNeeded() else stopAntiGrab() end end })
    Antis:AddToggle("GucciAntiGrab", { Text = "[GUCCI] Anti Grab", Default = false, Tooltip = "Can't be touched.",
        Callback = function(v) tbl19.GucciAntiGrab = v if v then task.spawn(runGucciAntiGrab) else stopGucciAntiGrab() task.spawn(runGucciAntiGrab) end end })
    Antis:AddToggle("AntiBlobman", { Text = "Anti Blobman", Default = false, Tooltip = "People can't grab you using Blobman",
        Callback = function(v) tbl19.AntiBlobman = v end })
    Antis:AddToggle("AntiInputLag", { Text = "Anti Network Ownership", Default = false, Tooltip = "Anti Blob-kill, etc.",
        Callback = function(v) tbl19.AntiInputLag = v end })
    Antis:AddToggle("AntiExplosion", { Text = "Anti Explosion", Default = false, Tooltip = "Makes you not able to be exploded",
        Callback = function(v) tbl19.AntiExplosion = v end })
    Antis:AddToggle("AntiBurn", { Text = "Anti Burn", Default = false, Tooltip = "Makes you not able to be burnt",
        Callback = function(v) tbl19.AntiBurn = v end })
    Antis:AddToggle("AntiVoid", { Text = "Anti Void", Default = false, Tooltip = "Teleports you up if you go far down into the void",
        Callback = function(v) tbl19.AntiVoid = v end })
    Antis:AddToggle("AntiKick", { Text = "Anti Kick", Default = false, Tooltip = "Default shuriken anti-kick",
        Callback = function(v) tbl19.AntiKick = v end })
    Antis:AddToggle("AntiKick2", { Text = "[Break PCLD] Anti Kick", Default = false, Tooltip = "Unable to get kicked at all",
        Callback = function(v) tbl19.AntiKick2 = v end })
    Antis:AddToggle("AntiSticky", { Text = "Anti Sticky", Default = false,
        Callback = function(v) tbl19.AntiSticky = v if v then getgenv()._defense_startAntiStickyLoop() end end })
    Antis:AddToggle("AntiSnowball", { Text = "Anti Snowball", Default = false, Tooltip = "Prevents you from getting snowballed",
        Callback = function(v) tbl19.AntiSnowball = v if not v then local c = tbl17.charp() if c then tbl17.ToggleCollisions(c, true) end end end })
    Antis:AddToggle("AntiBanana", { Text = "Anti Banana", Default = false, Tooltip = "Bananas won't touch you",
        Callback = function(v) tbl19.AntiBanana = v end })
    Antis:AddToggle("AntiPaint", { Text = "Anti Paint", Default = false, Tooltip = "You won't get painted",
        Callback = function(v) tbl19.AntiPaint = v task.spawn(getgenv()._defense_applyAntiPaint, v) end })
    Antis:AddToggle("AntiPoison", { Text = "Anti Poison", Default = false, Tooltip = "Poison parts won't kill you",
        Callback = function(v) tbl19.AntiPoison = v getgenv()._defense_applyAntiPoison(v) end })
    Antis:AddToggle("AntiLag", { Text = "Anti Lag", Default = false, Tooltip = "Anti Line-Lag, Shuriken-Lag",
        Callback = getgenv()._defense_applyAntiLag })
    Antis:AddToggle("AutoAntiLag", { Text = "Auto Anti Lag", Default = true, Tooltip = "Enables anti-lag for you if too low fps",
        Callback = function(v) tbl19.AutoAntiLag = v end })
    Antis:AddToggle("AntiInvis", { Text = "Anti Invis", Default = false, Tooltip = "Makes any invisible players visible",
        Callback = function(v) tbl19.AntiInvis = v if v then getgenv()._defense_startAntiInvisLoop() end end })
    Antis:AddToggle("AutoReset", { Text = "Auto Reset", Default = true, Tooltip = "Checks for kick frame and resets when needed",
        Callback = function(v) tbl19.AutoReset = v end })
    Antis:AddToggle("LoopTP", { Text = "Loop TP", Default = false, Tooltip = "Teleports you infinitely so you're unable to be grabbed",
        Callback = function(v) tbl19.LoopTP = v if v then getgenv()._defense_startLoopTP() end end })

    local Miscellaneous = Tabs.Defense:AddRightGroupbox("Miscellaneous")
    DisblVoid = Miscellaneous:AddToggle("DisblVoid", { Text = "Disable Void", Default = true, Tooltip = "Makes you not get killed in void",
        DisabledTooltip = "This function is currently being managed by another function.", Callback = applyDisableVoid })
    Miscellaneous:AddToggle("WaterWalk", { Text = "Water Walk", Default = false, Tooltip = "Walk on water", Callback = applyWaterWalk })
    Miscellaneous:AddToggle("DeleteBarriers", { Text = "Noclip Barrier", Default = false, Callback = applyDeleteBarriers })
    Miscellaneous:AddToggle("OtherInvCollisions", { Text = "Anti-Fling [Objects Noclip]", Default = false,
        Callback = function(v) tbl19.OtherInvCollisions = v if v then getgenv()._defense_startOtherInvCollisions()
        else task.spawn(getgenv()._defense_startOtherInvCollisions) end end })

    local LastGrabbedLabel = Miscellaneous:AddLabel("LastGrabbedLabel", { Text = "This is a label", DoesWrap = true })
    task.spawn(function()
        local last = nil
        while task.wait(0.05) do
            local who = tbl20.WhoGrabbed
            local changed = who ~= last
            if LastGrabbedLabel.SetVisible then LastGrabbedLabel:SetVisible(who ~= nil) end
            if changed then
                local text = "Last person who grabbed you: " .. tostring(who)
                if LastGrabbedLabel.SetText then LastGrabbedLabel:SetText(text) last = who
                else LastGrabbedLabel.Text = text last = who end
            end
        end
    end)

    local CA = Tabs.Defense:AddLeftGroupbox("Counter-attack")
    CA:AddDropdown("CADropdown", { Values = { "Grab", "Kill", "Void", "Delete Limbs", "Fling", "Teleport to Spawn" },
        Default = "Kill", Multi = false, Text = "Consequences",
        Tooltip = "What will you do when someone touches you and you have Counter-attack on",
        Callback = function(v) tbl18.CounterMethod = v end })
    CA:AddToggle("CAToggle", { Text = "Counter Attack", Default = false,
        Tooltip = "People who touch you will have the selected consequences",
        Callback = function(v) tbl19.CounterAttack = v end })
    local CADep = CA:AddDependencyBox()
    CADep:SetupDependencies({ { Tabs.Defense:AddLeftGroupbox("_dummy"), "dummy" } })
    CADep:AddDivider("Delete Limb Settings")
    CADep:AddDropdown("DLCADropdown", { Values = { "Legs", "Arms", "All" }, Default = 3, Multi = false, Searchable = true,
        Text = "Limbs to delete", Tooltip = "What limbs will you delete",
        Callback = function(v) tbl18.TargetedLimbCA = v end })

    local Config = Tabs.Defense:AddRightGroupbox("Config")
    Config:AddSlider("AntiLagSens", { Text = "Auto Anti-Lag Sensitivity", Default = 3, Min = 1, Max = 20, Prefix = "FPS",
        Callback = function(v) tbl18.AntiLagSens = v end })
    Config:AddDivider("Anti-Grabs")
    Config:AddDropdown("AGTDropdown", { Values = { "Normal", "No Ragdoll", "Anti-Kill", "Escapes Anything, but buggy" }, Default = 1, Multi = false,
        Text = "Anti-Grab Type", Tooltip = "Type of default Anti-Grab",
        Callback = function(v) tbl18.AGType = v end })
    Config:AddDropdown("GTDropdown", { Values = { "Blobman", "Tractor [Invisible]", "Train [Invisible]", "Sleigh [Invisible]" },
        Default = 1, Multi = false, Text = "GUCCI Type",
        Tooltip = "What vehicle will you sit on during Gucci Anti Grab",
        Callback = function(v)
            if v == "Blobman" then tbl18.GucciType = "CreatureBlobman"
            elseif v == "Tractor [Invisible]" then tbl18.GucciType = "TractorGreen"
            elseif v == "Train [Invisible]" then tbl18.GucciType = "Train"
            elseif v == "Sleigh [Invisible]" then tbl18.GucciType = "SantaSleigh" end
        end })
    Config:AddDivider("Anti Net-Owner")
    Config:AddDropdown("AITDropdown", {
        Values = {
            "FoodHamburger", "InstrumentDrumBongos", "InstrumentBrassTrumpet", "InstrumentBrassBugle",
            "InstrumentVoiceMicrophone", "InstrumentWoodwindOcarina", "InstrumentGuitarUkulele",
            "InstrumentGuitarLyre", "InstrumentGuitarBanjo", "InstrumentGuitarAcoustic",
            "CupMugBrown", "CupMugWhite", "FoodBanana", "FoodBread", "FoodBroccoli", "FoodCakePink",
            "FoodCoconut", "FoodDippyEgg", "FoodDonut", "FoodFrenchFries", "FoodHotdog", "FoodMayonnaise",
            "FoodMeatStick", "FoodMushroomPoison", "FoodPizzaCheese", "FoodPizzaPepperoni", "FoodSodaCan",
            "PoopPile", "PoopPileSparkle",
        },
        Default = 1, Multi = false, Text = "Type",
        Tooltip = "What interactable item will you use when doing anti-Net Owner",
        Callback = function(v) tbl18.AntiInputType = v end,
    })
    Config:AddSlider("AntiInpLagDel", { Text = "Grab & Drop Delay", Default = 0.05, Min = 0, Max = 0.3, Prefix = "sec", Rounding = 2,
        Callback = function(v) tbl18.InputLgDelay = v end })
    Config:AddLabel("Below 0.05 can cause high ping")
    Config:AddSlider("ItemTransAK", { Text = "Item Transparency", Default = tbl18.AILTransparency, Min = 0, Max = 1, Rounding = 2,
        Callback = function(v) tbl18.AILTransparency = v end })

    local TargetExtras = Tabs.Defense:AddRightGroupbox("Target Extras")
    TargetExtras:AddToggle("TargetDeathNotif", { Text = "Death Notification", Default = false,
        Callback = function(v) TargetTab_DeathNotif = v end })
    TargetExtras:AddToggle("TargetDeathSound", { Text = "Death Sound", Default = false,
        Callback = function(v) TargetTab_DeathSound = v end })

    applyDisableVoid(true)
end

-- ============================================================
-- Kick Tab
-- ============================================================
do
    local function IsInPlot(player)
        if not player then return false end
        local inPlot = player:FindFirstChild("InPlot")
        if inPlot and inPlot:IsA("BoolValue") then return inPlot.Value end
        return false
    end
    local function getAllPlayers()
        local list = {}
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer then table.insert(list, player) end
        end
        return list
    end
    local function getKickTargets()
        local list = {}
        local targetDisplay = tbl2.kickTargetPlayerDisplay
        local targetName = ExtractUsername(targetDisplay)
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                local exclude = false
                if tbl2.kickExcludeFriends and localPlayer:IsFriendsWith(player.UserId) then exclude = true end
                if tbl2.kickUseWhitelist and isWhitelisted(player) then exclude = true end
                if not exclude then
                    if targetDisplay == "All Players" or not targetName then table.insert(list, player)
                    elseif player.Name == targetName then table.insert(list, player) end
                end
            end
        end
        return list
    end
    local function teleportToPlayer(hrp, targetHrp)
        if not hrp or not targetHrp then return end
        pcall(function()
            hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 3)
            hrp.AssemblyLinearVelocity = Vector3.zero
        end)
    end
    local function destroyLineOnPlayer(hrp)
        local grabEvents = replicatedStorage:FindFirstChild("GrabEvents")
        if not grabEvents then return end
        local cgl = grabEvents:FindFirstChild("CreateGrabLine")
        local dgl = grabEvents:FindFirstChild("DestroyGrabLine")
        if not cgl or not dgl then return end
        pcall(function()
            cgl:FireServer(hrp, CFrame.new(3e9, 4e9, 2e9))
            task.wait()
            dgl:FireServer(hrp)
        end)
    end
    local lineLagActive = false
    local lineLagThreads = {}
    local function startLineLag()
        if lineLagActive then return end
        lineLagActive = true
        local thread = coroutine.create(function()
            while lineLagActive do
                local grabEvents = replicatedStorage:FindFirstChild("GrabEvents")
                local cgl = grabEvents and grabEvents:FindFirstChild("CreateGrabLine")
                if cgl then
                    local spawn = workspace_:FindFirstChild("SpawnLocation") or workspace_:FindFirstChild("Spawn")
                    if not spawn then
                        local c = localPlayer.Character
                        spawn = c and c:FindFirstChild("HumanoidRootPart")
                    end
                    if spawn then
                        local intensity = tbl2.lineLagIntensity or 520
                        for i = 1, intensity do
                            if lineLagActive then
                                local x = math.random(-2140500000, 2104000001)
                                local z = math.random(-2.11e9, 2101000000)
                                cgl:FireServer(spawn, CFrame.new(x, 0, z))
                            else break end
                        end
                    end
                end
                if lineLagActive then task.wait(tbl2.lineLagDelay or 1) end
            end
        end)
        table.insert(lineLagThreads, thread)
        coroutine.resume(thread)
    end
    local function stopLineLag()
        lineLagActive = false
        task.wait(0.1)
        for _, t in ipairs(lineLagThreads) do pcall(coroutine.close, t) end
        lineLagThreads = {}
    end
    getgenv().kt_startLineLag = startLineLag
    getgenv().kt_stopLineLag = stopLineLag

    local noBlobKicking = false
    local function executeNoBlobKick()
        if noBlobKicking then return end
        noBlobKicking = true
        task.spawn(function()
            lineLagActive = false
            startLineLag()
            local allPlayers = getAllPlayers()
            if #allPlayers == 0 then noBlobKicking = false return end
            local targets = {}
            for _, p in ipairs(allPlayers) do
                if not IsInPlot(p) then table.insert(targets, p) end
            end
            if #targets == 0 then stopLineLag() noBlobKicking = false return end
            local character = localPlayer.Character
            local hrp = character and character:FindFirstChild("HumanoidRootPart")
            if not hrp then noBlobKicking = false return end
            local targetData = {}
            for _, p in ipairs(targets) do
                local c = p.Character
                local tHrp = c and c:FindFirstChild("HumanoidRootPart")
                if tHrp then table.insert(targetData, { player = p, hrp = tHrp }) end
            end
            for _, data in ipairs(targetData) do
                teleportToPlayer(hrp, data.hrp)
                task.wait(0.16)
                for i = 1, 4 do pcall(function() setNetworkOwner:FireServer(data.hrp, data.hrp.CFrame) end) end
            end
            local n = 6.2831853071795862 / #targetData
            for i, data in ipairs(targetData) do
                local angle = (i - 1) * n
                local x = math.cos(angle) * 80
                local z = math.sin(angle) * 80
                pcall(function()
                    data.hrp.CFrame = CFrame.new(x, 32, z)
                    data.hrp.AssemblyLinearVelocity = Vector3.zero
                    data.hrp.Velocity = Vector3.zero
                end)
                local bp = Instance.new("BodyPosition")
                bp.MaxForce = Vector3.new(3e9, 4e9, 3e9)
                bp.P = 50000000
                bp.Position = Vector3.new(x, 32, z)
                bp.Parent = data.hrp
                task.delay(3, function() pcall(function() bp:Destroy() end) end)
                task.wait()
            end
            task.wait(1.3)
            for i = 1, 1 do
                for _, data in ipairs(targetData) do destroyLineOnPlayer(data.hrp) end
                task.wait(12)
            end
            stopLineLag()
            noBlobKicking = false
        end)
    end

    local function executeBlobmanKick()
        local targets = getKickTargets()
        if #targets == 0 then _NOTIFY("Kick Target: No targets found.", 3) return end
        _NOTIFY("Kick Target: Starting Blobman Kick V2 on " .. #targets .. " targets...", 3)
        task.spawn(function()
            local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            local folder = workspace_:FindFirstChild(localPlayer.Name .. "SpawnedInToys")
            if folder then
                local blob = folder:FindFirstChild("CreatureBlobman")
                if blob then pcall(function() blob:Destroy() end) task.wait(0.133) end
            end
            local spawnedBlob = nil
            task.spawn(function()
                pcall(function()
                    spawnToyRemoteFunction:InvokeServer("CreatureBlobman", character.Head.CFrame, Vector3.zero)
                end)
            end)
            for i = 1, 50 do
                spawnedBlob = folder:FindFirstChild("CreatureBlobman")
                if spawnedBlob then break end
                task.wait(0.05)
            end
            if not spawnedBlob then _NOTIFY("Kick Target: Failed to spawn Blobman.", 3) return end
            task.wait(0.1)
            local vehicleSeat = spawnedBlob:FindFirstChildWhichIsA("VehicleSeat", true)
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if vehicleSeat and humanoid then pcall(function() vehicleSeat:Sit(humanoid) end) end
            task.wait(0.3)
            local collisionCache = {}
            for _, d in ipairs(character:GetDescendants()) do
                if d:IsA("BasePart") then collisionCache[d] = d.CanCollide d.CanCollide = false end
            end
            local function grab(blob, part)
                for _, side in ipairs({ "Left", "Right" }) do
                    local det = blob:FindFirstChild(side .. "Detector")
                    local weld = det and det:FindFirstChild(side .. "Weld")
                    local s = blob:FindFirstChild("BlobmanSeatAndOwnerScript")
                    local cg = s and s:FindFirstChild("CreatureGrab")
                    if det and weld and cg then pcall(function() cg:FireServer(det, part, weld) end) end
                end
            end
            local function release(blob, part)
                for _, side in ipairs({ "Left", "Right" }) do
                    local det = blob:FindFirstChild(side .. "Detector")
                    local weld = det and det:FindFirstChild(side .. "Weld")
                    local s = blob:FindFirstChild("BlobmanSeatAndOwnerScript")
                    local cr = s and s:FindFirstChild("CreatureRelease")
                    if weld and cr then pcall(function() cr:FireServer(weld, part) end) end
                end
            end
            local function drop(blob, part)
                for _, side in ipairs({ "Left", "Right" }) do
                    local det = blob:FindFirstChild(side .. "Detector")
                    local weld = det and det:FindFirstChild(side .. "Weld")
                    local s = blob:FindFirstChild("BlobmanSeatAndOwnerScript")
                    local cd = s and s:FindFirstChild("CreatureDrop")
                    if weld and cd then pcall(function() cd:FireServer(weld, part) end) end
                end
            end
            local function ungrab(part)
                local dgl = replicatedStorage:WaitForChild("GrabEvents"):FindFirstChild("DestroyGrabLine")
                if part and dgl then pcall(function() dgl:FireServer(part) end) end
            end
            local targetData = {}
            for _, p in ipairs(targets) do
                local c = p.Character
                local tHrp = c and c:FindFirstChild("HumanoidRootPart")
                if tHrp then table.insert(targetData, { player = p, hrp = tHrp }) end
            end
            for _, data in ipairs(targetData) do
                pcall(function()
                    hrp.CFrame = data.hrp.CFrame
                    hrp.AssemblyAngularVelocity = Vector3.zero
                end)
                task.wait(0.11)
                if (hrp.Position - data.hrp.Position).Magnitude <= 35 then
                    for i = 1, 5 do
                        if not (not data.hrp.Parent or not spawnedBlob.Parent) then
                            grab(spawnedBlob, data.hrp)
                            task.wait()
                            release(spawnedBlob, data.hrp)
                            continue
                        end
                        break
                    end
                end
            end
            pcall(function()
                hrp.CFrame = CFrame.new(0, 90, 0)
                hrp.AssemblyLinearVelocity = Vector3.zero
            end)
            task.wait(0.2)
            hrp.Anchored = true
            local n = #targetData
            for i, data in ipairs(targetData) do
                local angle = 6.2831853071795862 / n * (i - 1)
                local vec = Vector3.new(math.cos(angle) * 22, 0, math.sin(angle) * 22)
                pcall(function()
                    data.hrp.CFrame = CFrame.new(hrp.Position.X + vec.X, 90, hrp.Position.Z + vec.Z)
                    data.hrp.AssemblyLinearVelocity = Vector3.zero
                    data.hrp.AssemblyAngularVelocity = Vector3.zero
                end)
            end
            task.wait(0.2)
            local sno = replicatedStorage:WaitForChild("GrabEvents"):FindFirstChild("SetNetworkOwner")
            for _, data in ipairs(targetData) do
                if sno then
                    for i = 1, 10 do pcall(function() sno:FireServer(data.hrp, data.hrp.CFrame) end) end
                end
            end
            task.wait(0.1)
            for _, data in ipairs(targetData) do ungrab(data.hrp) end
            for _, data in ipairs(targetData) do drop(spawnedBlob, data.hrp) end
            hrp.Anchored = false
            local now = os.clock()
            while os.clock() - now < 0.05 do
                for _, data in ipairs(targetData) do
                    task.spawn(function()
                        if data.hrp.Parent and spawnedBlob.Parent then grab(spawnedBlob, data.hrp) end
                    end)
                end
                task.wait()
            end
            for _, d in ipairs(character:GetDescendants()) do
                if d:IsA("BasePart") and collisionCache[d] ~= nil then d.CanCollide = collisionCache[d] end
            end
            _NOTIFY("Kick Target: Blobman Kick V2 execution complete.", 3)
        end)
    end

    local gkaActive = false
    local gkaConnection = nil
    local gkaTargets = {}
    local gkaAngle = 0
    local function gkaStop()
        gkaActive = false
        if gkaConnection then pcall(function() gkaConnection:Disconnect() end) gkaConnection = nil end
        gkaTargets = {}
        gkaAngle = 0
        pcall(function() stopLineLag() end)
        _NOTIFY("GatherKickAll: Stopped.", 2)
    end
    local function gkaExecute()
        if gkaActive then _NOTIFY("GatherKickAll: Already running!", 2) return end
        gkaActive = true
        task.spawn(function()
            local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart", 10)
            if not hrp then gkaStop() return end
            local targets = {}
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= localPlayer then
                    local ok, isFriend = pcall(function() return localPlayer:IsFriendsWith(p.UserId) end)
                    if not (tbl2.kickExcludeFriends and ok and isFriend) then
                        local c = p.Character
                        local tHrp = c and c:FindFirstChild("HumanoidRootPart")
                        if tHrp then table.insert(targets, { player = p, hrp = tHrp }) end
                    end
                end
            end
            if #targets == 0 then _NOTIFY("GatherKickAll: No targets!", 3) gkaStop() return end
            _NOTIFY("GatherKickAll: Starting...", 3)
            pcall(function() startLineLag() end)
            local folder = workspace_:FindFirstChild(localPlayer.Name .. "SpawnedInToys")
            if folder then
                local blob = folder:FindFirstChild("CreatureBlobman")
                if blob then pcall(function() blob:Destroy() end) task.wait(0.133) end
            end
            local spawnedBlob = nil
            task.spawn(function()
                pcall(function()
                    spawnToyRemoteFunction:InvokeServer("CreatureBlobman", character.Head.CFrame, Vector3.zero)
                end)
            end)
            for i = 1, 50 do
                spawnedBlob = folder:FindFirstChild("CreatureBlobman")
                if spawnedBlob then break end
                task.wait(0.05)
            end
            if not spawnedBlob then _NOTIFY("GatherKickAll: Blobman spawn failed!", 3) gkaStop() return end
            task.wait(0.1)
            local vehicleSeat = spawnedBlob:FindFirstChildWhichIsA("VehicleSeat", true)
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if vehicleSeat and humanoid then pcall(function() vehicleSeat:Sit(humanoid) end) end
            task.wait(0.3)
            local collisionCache = {}
            for _, d in ipairs(character:GetDescendants()) do
                if d:IsA("BasePart") then collisionCache[d] = d.CanCollide d.CanCollide = false end
            end
            local function bkGrab(blob, part)
                for _, side in ipairs({ "Left", "Right" }) do
                    local det = blob:FindFirstChild(side .. "Detector")
                    local weld = det and det:FindFirstChild(side .. "Weld")
                    local s = blob:FindFirstChild("BlobmanSeatAndOwnerScript")
                    local cg = s and s:FindFirstChild("CreatureGrab")
                    if det and weld and cg then pcall(function() cg:FireServer(det, part, weld) end) end
                end
            end
            local function bkRelease(blob, part)
                for _, side in ipairs({ "Left", "Right" }) do
                    local det = blob:FindFirstChild(side .. "Detector")
                    local weld = det and det:FindFirstChild(side .. "Weld")
                    local s = blob:FindFirstChild("BlobmanSeatAndOwnerScript")
                    local cr = s and s:FindFirstChild("CreatureRelease")
                    if weld and cr then pcall(function() cr:FireServer(weld, part) end) end
                end
            end
            local function bkDrop(blob, part)
                for _, side in ipairs({ "Left", "Right" }) do
                    local det = blob:FindFirstChild(side .. "Detector")
                    local weld = det and det:FindFirstChild(side .. "Weld")
                    local s = blob:FindFirstChild("BlobmanSeatAndOwnerScript")
                    local cd = s and s:FindFirstChild("CreatureDrop")
                    if weld and cd then pcall(function() cd:FireServer(weld, part) end) end
                end
            end
            local grabEvents = replicatedStorage:WaitForChild("GrabEvents")
            local function bkUngrab(part)
                local dgl = grabEvents:FindFirstChild("DestroyGrabLine")
                if part and dgl then pcall(function() dgl:FireServer(part) end) end
            end
            _NOTIFY("GatherKickAll: Gathering...", 3)
            local sno = grabEvents:FindFirstChild("SetNetworkOwner")
            for _, data in ipairs(targets) do
                if gkaActive then
                    pcall(function()
                        hrp.CFrame = data.hrp.CFrame
                        hrp.AssemblyAngularVelocity = Vector3.zero
                    end)
                    task.wait(0.11)
                    if sno and data.hrp and data.hrp.Parent then
                        for i = 1, 8 do pcall(function() sno:FireServer(data.hrp, data.hrp.CFrame) end) end
                    end
                    if (hrp.Position - data.hrp.Position).Magnitude <= 35 then
                        for i = 1, 5 do
                            if not (not data.hrp.Parent or not spawnedBlob.Parent) then
                                bkGrab(spawnedBlob, data.hrp)
                                task.wait()
                                bkRelease(spawnedBlob, data.hrp)
                                continue
                            end
                            break
                        end
                    end
                    if sno and data.hrp and data.hrp.Parent then
                        for i = 1, 4 do pcall(function() sno:FireServer(data.hrp, data.hrp.CFrame) end) end
                    end
                    continue
                end
                break
            end
            local centerY = tbl2.gkaCenterY or 50
            local circleRadius = tbl2.gkaCircleRadius or 6
            local n = #targets
            pcall(function()
                hrp.CFrame = CFrame.new(0, centerY, 0)
                hrp.AssemblyLinearVelocity = Vector3.zero
            end)
            task.wait(0.2)
            hrp.Anchored = true
            for i, data in ipairs(targets) do
                local angle = 6.2831853071795862 / n * (i - 1)
                local vec = Vector3.new(math.cos(angle) * circleRadius, 0, math.sin(angle) * circleRadius)
                pcall(function()
                    data.hrp.CFrame = CFrame.new(hrp.Position.X + vec.X, centerY, hrp.Position.Z + vec.Z)
                    data.hrp.AssemblyLinearVelocity = Vector3.zero
                    data.hrp.AssemblyAngularVelocity = Vector3.zero
                end)
            end
            task.wait(0.2)
            local sno2 = grabEvents:FindFirstChild("SetNetworkOwner")
            for _, data in ipairs(targets) do
                if sno2 and data.hrp and data.hrp.Parent then
                    for i = 1, 10 do pcall(function() sno2:FireServer(data.hrp, data.hrp.CFrame) end) end
                end
            end
            task.wait(0.1)
            for _, data in ipairs(targets) do bkUngrab(data.hrp) end
            for _, data in ipairs(targets) do bkDrop(spawnedBlob, data.hrp) end
            hrp.Anchored = false
            local now = os.clock()
            while os.clock() - now < 0.05 do
                for _, data in ipairs(targets) do
                    task.spawn(function()
                        if data.hrp and data.hrp.Parent and spawnedBlob and spawnedBlob.Parent then
                            bkGrab(spawnedBlob, data.hrp)
                        end
                    end)
                end
                task.wait()
            end
            for _, d in ipairs(character:GetDescendants()) do
                if d:IsA("BasePart") and collisionCache[d] ~= nil then d.CanCollide = collisionCache[d] end
            end
            _NOTIFY("GatherKickAll: Orbit starting!", 3)
            local rotateRadius = tbl2.gkaBlobRotateRadius or 18
            if not spawnedBlob.Parent then
                _NOTIFY("GatherKickAll: Re-spawning Blobman...", 2)
                pcall(function()
                    hrp.CFrame = CFrame.new(0, centerY + 3, rotateRadius)
                    hrp.AssemblyLinearVelocity = Vector3.zero
                end)
                task.wait(0.2)
                spawnedBlob = nil
                task.spawn(function()
                    pcall(function()
                        spawnToyRemoteFunction:InvokeServer("CreatureBlobman", character.Head.CFrame, Vector3.zero)
                    end)
                end)
                for i = 1, 50 do
                    spawnedBlob = folder:FindFirstChild("CreatureBlobman")
                    if spawnedBlob then break end
                    task.wait(0.05)
                end
                if not spawnedBlob then _NOTIFY("GatherKickAll: Blobman spawn failed, orbit aborted!", 3) gkaStop() return end
                local vs = spawnedBlob:FindFirstChildWhichIsA("VehicleSeat", true)
                if vs and humanoid then pcall(function() vs:Sit(humanoid) end) end
                task.wait(0.35)
            else
                local hum = character:FindFirstChildOfClass("Humanoid")
                if not (hum and hum.SeatPart) then
                    pcall(function()
                        hrp.CFrame = CFrame.new(0, centerY + 3, rotateRadius)
                        hrp.AssemblyLinearVelocity = Vector3.zero
                    end)
                    task.wait(0.2)
                    local vs = spawnedBlob:FindFirstChildWhichIsA("VehicleSeat", true)
                    if vs and humanoid then pcall(function() vs:Sit(humanoid) end) end
                    task.wait(0.35)
                else
                    pcall(function()
                        hrp.CFrame = CFrame.new(0, centerY + 3, rotateRadius)
                        hrp.AssemblyLinearVelocity = Vector3.zero
                    end)
                    task.wait(0.15)
                end
            end
            local bps = {}
            for i, data in ipairs(targets) do
                if data.hrp and data.hrp.Parent then
                    local angle = 6.2831853071795862 / n * (i - 1)
                    local x = math.cos(angle) * circleRadius
                    local z = math.sin(angle) * circleRadius
                    pcall(function()
                        data.hrp.CFrame = CFrame.new(x, centerY, z)
                        data.hrp.AssemblyLinearVelocity = Vector3.zero
                    end)
                    local bp = Instance.new("BodyPosition")
                    bp.MaxForce = Vector3.new(4e9, 5e9, 4e9)
                    bp.P = 100000000
                    bp.D = 10000
                    bp.Position = Vector3.new(x, centerY, z)
                    bp.Parent = data.hrp
                    table.insert(bps, bp)
                end
            end
            gkaTargets = targets
            gkaAngle = 0
            task.delay(8, function()
                for _, bp in ipairs(bps) do pcall(function() bp:Destroy() end) end
            end)
            local lagTimer = 0
            local sitTimer = 0
            local rotateSpeed = tbl2.gkaBlobRotateSpeed or 4
            gkaConnection = runService.RenderStepped:Connect(function(dt)
                if not gkaActive then
                    pcall(function() gkaConnection:Disconnect() end)
                    gkaConnection = nil
                    return
                end
                if not spawnedBlob or not spawnedBlob.Parent then return end
                sitTimer -= dt
                if sitTimer <= 0 then
                    sitTimer = 0.5
                    local hum = character:FindFirstChildOfClass("Humanoid")
                    if not (hum and hum.SeatPart) then
                        task.spawn(function()
                            local vs = spawnedBlob:FindFirstChildWhichIsA("VehicleSeat", true)
                            if vs and hum then pcall(function() vs:Sit(hum) end) end
                        end)
                    end
                end
                lagTimer -= dt
                if lagTimer <= 0 then
                    lagTimer = 3
                    local anyAlive = false
                    for _, data in ipairs(gkaTargets) do
                        if data.player and data.player.Parent then anyAlive = true break end
                    end
                    if not anyAlive then
                        _NOTIFY("GatherKickAll: All targets gone, stopping.", 3)
                        task.spawn(gkaStop)
                        return
                    end
                    pcall(function() startLineLag() end)
                end
                gkaAngle += rotateSpeed * dt
                local rx = math.cos(gkaAngle) * rotateRadius
                local rz = math.sin(gkaAngle) * rotateRadius
                local blobHrp = spawnedBlob:FindFirstChild("HumanoidRootPart") or spawnedBlob:FindFirstChildWhichIsA("BasePart", true)
                if blobHrp then
                    pcall(function()
                        local pos = blobHrp.Position
                        blobHrp.AssemblyLinearVelocity = (Vector3.new(rx, centerY + 2, rz) - pos) * 60
                        blobHrp.CFrame = CFrame.new(blobHrp.Position) * CFrame.Angles(0, -(gkaAngle + 1.5707963267948966), 0)
                    end)
                end
                local count = #gkaTargets
                if count > 0 then
                    local data = gkaTargets[math.random(1, count)]
                    if data and data.hrp and data.hrp.Parent then
                        task.spawn(function() bkGrab(spawnedBlob, data.hrp) end)
                    end
                    for i, d in ipairs(gkaTargets) do
                        local tHrp = d.hrp
                        if tHrp and tHrp.Parent then
                            local angle = 6.2831853071795862 / count * (i - 1)
                            pcall(function()
                                tHrp.CFrame = CFrame.new(math.cos(angle) * circleRadius, centerY, math.sin(angle) * circleRadius)
                                tHrp.AssemblyLinearVelocity = Vector3.zero
                            end)
                        end
                    end
                end
            end)
        end)
    end
    getgenv().gka_execute = gkaExecute
    getgenv().gka_stop = gkaStop

    local KickLeft = Tabs.Kick:AddLeftGroupbox("Kick Configuration")
    local KickRight = Tabs.Kick:AddRightGroupbox("Execute Kick")
    local kickTargetDropdown
    kickTargetDropdown = KickLeft:AddDropdown("kickTargetPlayerDisplay", {
        Text = "Target Player", Values = { "All Players" }, Default = 1,
        Callback = function(value) tbl2.kickTargetPlayerDisplay = value end,
    })
    local function updateKickDropdown()
        if kickTargetDropdown then
            pcall(function()
                local list = { "All Players" }
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= localPlayer then table.insert(list, p.DisplayName .. " @" .. p.Name) end
                end
                kickTargetDropdown:SetValues(list)
            end)
        end
    end
    Players.PlayerAdded:Connect(function() task.wait(1) updateKickDropdown() end)
    Players.PlayerRemoving:Connect(function() task.wait(1) updateKickDropdown() end)
    task.spawn(function() task.wait(1) updateKickDropdown() end)

    KickLeft:AddToggle("kickExcludeFriends", { Text = "Exclude Friends", Default = true,
        Callback = function(v) tbl2.kickExcludeFriends = v end })
    KickLeft:AddToggle("kickUseWhitelist", { Text = "Exclude Whitelisted Players", Default = true,
        Callback = function(v) tbl2.kickUseWhitelist = v end })

    KickRight:AddButton({ Text = "Execute NoBlob Kick", Func = function() executeNoBlobKick() end })
    KickRight:AddButton({ Text = "Execute Blobman Kick V2", Func = function() executeBlobmanKick() end })
    KickRight:AddDivider()
    KickRight:AddButton({ Text = "Gather + Blobman Orbit Kick (All)", Func = function() gkaExecute() end })
    KickRight:AddButton({ Text = "Stop Gather Kick All", Func = function() gkaStop() end })

    local KickSettings = Tabs.Kick:AddLeftGroupbox("Gather Kick Settings")
    KickSettings:AddSlider("gkaCircleRadius", { Text = "Circle Radius", Default = 6, Min = 2, Max = 25, Rounding = 1, Callback = function(v) tbl2.gkaCircleRadius = v end })
    KickSettings:AddSlider("gkaCenterY", { Text = "Center Height Y", Default = 50, Min = 10, Max = 300, Rounding = 0, Callback = function(v) tbl2.gkaCenterY = v end })
    KickSettings:AddSlider("gkaBlobRotateRadius", { Text = "Blob Orbit Radius", Default = 18, Min = 5, Max = 60, Rounding = 1, Callback = function(v) tbl2.gkaBlobRotateRadius = v end })
    KickSettings:AddSlider("gkaBlobRotateSpeed", { Text = "Blob Orbit Speed x0.1", Default = 40, Min = 5, Max = 200, Rounding = 0, Callback = function(v) tbl2.gkaBlobRotateSpeed = v * 0.1 end })

    local LagGroup = Tabs.Kick:AddRightGroupbox("Lag Server")
    LagGroup:AddToggle("LagServerToggle", { Text = "Lag Server", Default = false,
        Callback = function(v) if v then startLineLag() _NOTIFY("Lag Server: Started", 3)
        else stopLineLag() _NOTIFY("Lag Server: Stopped", 3) end end })
    LagGroup:AddSlider("LagIntensity", { Text = "Lag Intensity", Default = 520, Min = 1, Max = 2000, Rounding = 0, Callback = function(v) tbl2.lineLagIntensity = v end })
    LagGroup:AddSlider("LagDelay", { Text = "Lag Delay", Default = 1, Min = 0.1, Max = 5, Rounding = 1, Callback = function(v) tbl2.lineLagDelay = v end })

    local LoopKickLeft = Tabs.Kick:AddLeftGroupbox("Loop Kick Blob")
    local LoopKickRight = Tabs.Kick:AddRightGroupbox("Loop Kick Settings")
    local loopKickTargetDropdown
    loopKickTargetDropdown = LoopKickLeft:AddDropdown("LoopKickBlobTargetDropdown", {
        Text = "Loop Kick Target", Values = GetPlayerListDisplay(), Default = 1,
        Callback = function(value)
            local name = ExtractUsername(value)
            if name then tbl2.loopKickBlobTarget = name end
        end,
    })
    local function updateLoopKickDropdown()
        if loopKickTargetDropdown then pcall(function() loopKickTargetDropdown:SetValues(GetPlayerListDisplay()) end) end
    end
    Players.PlayerAdded:Connect(function() task.wait(1) updateLoopKickDropdown() end)
    Players.PlayerRemoving:Connect(function() task.wait(1) updateLoopKickDropdown() end)

    LoopKickLeft:AddToggle("LoopKickBlobToggle", { Text = "Loop Kick Blob (Single Target)", Default = false,
        Callback = function(enabled)
            tbl2.loopKickBlobActive = enabled
            if enabled then
                if not tbl2.loopKickBlobTarget then
                    _NOTIFY("Loop Kick: Please select a target first", 3)
                    tbl2.loopKickBlobActive = false
                    if toggles.LoopKickBlobToggle then toggles.LoopKickBlobToggle:SetValue(false) end
                    return
                end
                task.spawn(function()
                    while tbl2.loopKickBlobActive do
                        local target = tbl2.loopKickBlobTarget
                        if not target then break end
                        local player = Players:FindFirstChild(target)
                        if not player or not player.Character then task.wait(0.5)
                        else
                            pcall(function()
                                local character = localPlayer.Character
                                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                                if not hrp or not humanoid then return end
                                local folder = workspace_:FindFirstChild(localPlayer.Name .. "SpawnedInToys")
                                local blob = folder and folder:FindFirstChild("CreatureBlobman")
                                if not blob then
                                    spawnToyRemoteFunction:InvokeServer("CreatureBlobman", hrp.CFrame * CFrame.new(0, 0, -5), Vector3.new(0, -15.716, 0))
                                    task.wait(0.1)
                                    blob = folder and folder:FindFirstChild("CreatureBlobman")
                                end
                                if not blob then return end
                                local vs = blob:FindFirstChildOfClass("VehicleSeat")
                                if vs then vs:Sit(humanoid) end
                                local t = tick() + 1
                                while not humanoid.Sit and tick() < t do task.wait(0.05) end
                                if not humanoid.Sit then return end
                                local targetChar = player.Character
                                local targetHrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                                if not targetHrp then return end
                                local script = blob:FindFirstChild("BlobmanSeatAndOwnerScript")
                                local grab = script and script:FindFirstChild("CreatureGrab")
                                local leftDet = blob:FindFirstChild("LeftDetector")
                                local leftWeld = leftDet and leftDet:FindFirstChild("LeftWeld")
                                if grab and leftDet and leftWeld then grab:FireServer(leftDet, targetHrp, leftWeld) end
                                task.wait(0.2)
                                local release = script and script:FindFirstChild("CreatureRelease")
                                local drop = script and script:FindFirstChild("CreatureDrop")
                                if release and leftWeld then release:FireServer(leftWeld, targetHrp) end
                                if drop and leftWeld then drop:FireServer(leftWeld, targetHrp) end
                            end)
                        end
                        task.wait(0.5)
                    end
                end)
                _NOTIFY("Loop Kick Blob: Started on " .. tbl2.loopKickBlobTarget, 3)
            else
                _NOTIFY("Loop Kick Blob: Stopped", 2)
            end
        end })

    LoopKickRight:AddDropdown("LoopKickBlobModeDropdown", { Text = "Loop Kick Mode", Values = { "Default", "TP to Sky" }, Default = 1,
        Callback = function(v) tbl2.loopKickBlobMode = v end })
end

-- ============================================================
-- ESP Tab
-- ============================================================
do
    -- Toy ESP
    local function addESPToPart(adornee, isBlobman)
        if adornee:FindFirstChild("ToyESPBox") then return nil end
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "ToyESPBox"
        box.Adornee = adornee
        box.Size = adornee.Size
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Transparency = isBlobman and (tbl2.blobmanESPTransparency or 0.3) or (tbl2.shurikenESPTransparency or 0.3)
        box.Color3 = isBlobman and (tbl2.blobmanESPSolidColor or Color3.new(0, 1, 0)) or (tbl2.shurikenESPSolidColor or Color3.new(1, 0, 0))
        box.Parent = adornee
        return box
    end
    local function createESPForToy(model, isBlobman)
        local store = isBlobman and tbl3.blobmanESPs or tbl3.shurikenESPs
        if store[model] then return end
        local boxes = {}
        for _, d in ipairs(model:GetDescendants()) do
            if d:IsA("BasePart") then
                local b = addESPToPart(d, isBlobman)
                if b then table.insert(boxes, b) end
            end
        end
        if #boxes > 0 then store[model] = boxes end
    end
    local function removeESPFromToy(model, isBlobman)
        local store = isBlobman and tbl3.blobmanESPs or tbl3.shurikenESPs
        if not store[model] then return end
        for _, b in ipairs(store[model]) do if b then b:Destroy() end end
        store[model] = nil
    end
    local function findAndESPTos()
        local shSet, blSet = {}, {}
        local function scan(folder)
            for _, child in ipairs(folder:GetChildren()) do
                if child:IsA("Model") then
                    if (child.Name == "AntiKick" or child.Name == "Shuriken" or child.Name == "ToyShuriken") and tbl2.shurikenESPEnabled then
                        shSet[child] = true
                        createESPForToy(child, false)
                    elseif child.Name == "CreatureBlobman" and tbl2.blobmanESPEnabled then
                        blSet[child] = true
                        createESPForToy(child, true)
                    end
                end
            end
        end
        for _, p in ipairs(Players:GetPlayers()) do
            local f = workspace_:FindFirstChild(p.Name .. "SpawnedInToys")
            if f then scan(f) end
        end
        local plotItems = workspace_:FindFirstChild("PlotItems")
        if plotItems then
            for _, child in ipairs(plotItems:GetChildren()) do
                for _, d in ipairs(child:GetDescendants()) do
                    if d:IsA("Model") then
                        if (d.Name == "AntiKick" or d.Name == "Shuriken" or d.Name == "ToyShuriken") and tbl2.shurikenESPEnabled then
                            shSet[d] = true
                            createESPForToy(d, false)
                        elseif d.Name == "CreatureBlobman" and tbl2.blobmanESPEnabled then
                            blSet[d] = true
                            createESPForToy(d, true)
                        end
                    end
                end
            end
        end
        for k in pairs(tbl3.shurikenESPs) do
            if not shSet[k] or not k.Parent then removeESPFromToy(k, false) end
        end
        for k in pairs(tbl3.blobmanESPs) do
            if not blSet[k] or not k.Parent then removeESPFromToy(k, true) end
        end
    end
    local espConn = runService.Heartbeat:Connect(function()
        if tbl2.shurikenESPEnabled or tbl2.blobmanESPEnabled then findAndESPTos() end
    end)
    table.insert(tbl3.visualConnections, espConn)
    local espHue = 0
    local espColorConn = runService.RenderStepped:Connect(function(dt)
        espHue = (espHue + dt * 60 * (tbl2.rainbowSpeedESP or 2)) % 360
        local rc = Color3.fromHSV(espHue / 360, 1, 1)
        if tbl2.shurikenESPEnabled then
            local color = tbl2.shurikenESPColorMode == "Rainbow" and rc or tbl2.shurikenESPSolidColor
            local trans = tbl2.shurikenESPTransparency or 0.3
            for _, boxes in pairs(tbl3.shurikenESPs) do
                for _, b in ipairs(boxes) do if b and b.Parent then b.Color3 = color b.Transparency = trans end end
            end
        end
        if tbl2.blobmanESPEnabled then
            local color = tbl2.blobmanESPColorMode == "Rainbow" and rc or tbl2.blobmanESPSolidColor
            local trans = tbl2.blobmanESPTransparency or 0.3
            for _, boxes in pairs(tbl3.blobmanESPs) do
                for _, b in ipairs(boxes) do if b and b.Parent then b.Color3 = color b.Transparency = trans end end
            end
        end
    end)
    table.insert(tbl3.visualConnections, espColorConn)

    -- Noks ESP
    local noksPlayers = {}
    local noksFadeInstances = {}
    local noksAnimState = {}
    local noksScreenGui = Instance.new("ScreenGui")
    noksScreenGui.Name = "Noks_DamagePopups"
    noksScreenGui.IgnoreGuiInset = true
    noksScreenGui.Parent = CoreGui

    local function getNoksFont()
        local f = tbl2.noksTextFont
        if f == "GothamBold" then return Enum.Font.GothamBold end
        if f == "SourceSansBold" then return Enum.Font.SourceSansBold end
        if f == "Arcade" then return Enum.Font.Arcade end
        if f == "Roboto" then return Enum.Font.Roboto end
        return Enum.Font.GothamBold
    end
    local function snapshotTransparencies(gui)
        local snap = {}
        for _, d in ipairs(gui:GetDescendants()) do
            local data = {}
            local has = false
            if d:IsA("GuiObject") then data.BackgroundTransparency = d.BackgroundTransparency has = true end
            if d:IsA("TextLabel") or d:IsA("TextButton") then data.TextTransparency = d.TextTransparency has = true end
            if d:IsA("ImageLabel") or d:IsA("ImageButton") then data.ImageTransparency = d.ImageTransparency has = true end
            if d:IsA("UIStroke") then data.Transparency = d.Transparency has = true end
            if has then snap[d] = data end
        end
        return snap
    end
    local function applyFadeTransparency(snap, alpha)
        for obj, data in pairs(snap) do
            if obj.Parent then
                if data.BackgroundTransparency ~= nil then obj.BackgroundTransparency = data.BackgroundTransparency + (1 - data.BackgroundTransparency) * alpha end
                if data.TextTransparency ~= nil then obj.TextTransparency = data.TextTransparency + (1 - data.TextTransparency) * alpha end
                if data.ImageTransparency ~= nil then obj.ImageTransparency = data.ImageTransparency + (1 - data.ImageTransparency) * alpha end
                if data.Transparency ~= nil then obj.Transparency = data.Transparency + (1 - data.Transparency) * alpha end
            end
        end
    end
    local function updateNoksLine(frame, from, to, thickness)
        local mag = (to - from).Magnitude
        local angle = math.atan2(to.Y - from.Y, to.X - from.X)
        frame.Size = UDim2.new(0, mag, 0, thickness)
        frame.Position = UDim2.new(0, (from.X + to.X) / 2, 0, (from.Y + to.Y) / 2)
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.Rotation = math.deg(angle)
    end
    local function applyNoksChams(character)
        if not tbl2.noksChamsEnable then
            local h = character:FindFirstChild("Noks_Highlight")
            if h then h:Destroy() end
            return
        end
        local hl = character:FindFirstChild("Noks_Highlight") or Instance.new("Highlight")
        hl.Name = "Noks_Highlight"
        hl.FillColor = tbl2.noksChamsFillColor
        hl.OutlineColor = tbl2.noksChamsOutlineColor
        hl.FillTransparency = tbl2.noksChamsFillTransparency / 100
        hl.OutlineTransparency = tbl2.noksChamsOutlineTransparency / 100
        hl.DepthMode = tbl2.noksChamsOcclusion == "Always See" and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
        hl.Parent = character
    end
    local function getJointPosition(character, partName, targetName)
        local part = character:FindFirstChild(partName)
        if not part then return nil end
        local attName
        if partName == "UpperTorso" then
            if targetName == "Head" then attName = "NeckAttachment"
            elseif targetName == "LeftUpperArm" then attName = "LeftShoulderAttachment"
            elseif targetName == "RightUpperArm" then attName = "RightShoulderAttachment"
            elseif targetName == "LowerTorso" then attName = "WaistAttachment" end
        elseif partName == "LowerTorso" then
            if targetName == "UpperTorso" then attName = "WaistAttachment"
            elseif targetName == "LeftUpperLeg" then attName = "LeftHipAttachment"
            elseif targetName == "RightUpperLeg" then attName = "RightHipAttachment" end
        elseif partName == "LeftUpperArm" then
            if targetName == "UpperTorso" then attName = "LeftShoulderAttachment"
            elseif targetName == "LeftLowerArm" then attName = "LeftElbowAttachment" end
        elseif partName == "LeftLowerArm" then
            if targetName == "LeftUpperArm" then attName = "LeftElbowAttachment"
            elseif targetName == "LeftHand" then attName = "LeftWristAttachment" end
        elseif partName == "LeftHand" then
            if targetName == "LeftLowerArm" then attName = "LeftWristAttachment" end
        elseif partName == "RightUpperArm" then
            if targetName == "UpperTorso" then attName = "RightShoulderAttachment"
            elseif targetName == "RightLowerArm" then attName = "RightElbowAttachment" end
        elseif partName == "RightLowerArm" then
            if targetName == "RightUpperArm" then attName = "RightElbowAttachment"
            elseif targetName == "RightHand" then attName = "RightWristAttachment" end
        elseif partName == "RightHand" then
            if targetName == "RightLowerArm" then attName = "RightWristAttachment" end
        elseif partName == "LeftUpperLeg" then
            if targetName == "LowerTorso" then attName = "LeftHipAttachment"
            elseif targetName == "LeftLowerLeg" then attName = "LeftKneeAttachment" end
        elseif partName == "LeftLowerLeg" then
            if targetName == "LeftUpperLeg" then attName = "LeftKneeAttachment"
            elseif targetName == "LeftFoot" then attName = "LeftAnkleAttachment" end
        elseif partName == "LeftFoot" then
            if targetName == "LeftLowerLeg" then attName = "LeftAnkleAttachment" end
        elseif partName == "RightUpperLeg" then
            if targetName == "LowerTorso" then attName = "RightHipAttachment"
            elseif targetName == "RightLowerLeg" then attName = "RightKneeAttachment" end
        elseif partName == "RightLowerLeg" then
            if targetName == "RightUpperLeg" then attName = "RightKneeAttachment"
            elseif targetName == "RightFoot" then attName = "RightAnkleAttachment" end
        elseif partName == "RightFoot" then
            if targetName == "RightLowerLeg" then attName = "RightAnkleAttachment" end
        end
        if attName then
            local att = part:FindFirstChild(attName)
            if att and att:IsA("Attachment") then return att.WorldPosition end
        end
        return part.Position
    end
    local r15Bones = {
        { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" },
        { "UpperTorso", "LeftUpperArm" }, { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
        { "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" }, { "RightLowerArm", "RightHand" },
        { "LowerTorso", "LeftUpperLeg" }, { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
        { "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" }, { "RightLowerLeg", "RightFoot" },
    }
    local r6Bones = {
        { "Head", "Torso" }, { "Torso", "Left Arm" }, { "Torso", "Right Arm" },
        { "Torso", "Left Leg" }, { "Torso", "Right Leg" },
    }
    local function createNoksESP(character)
        if noksPlayers[character] then return end
        local name = character.Name
        local data = { CharModel = character, LastHealthRatio = 1, LastDistanceText = "" }
        noksAnimState[character] = { offset = 0, direction = 1, active = false }
        local gui = Instance.new("ScreenGui")
        gui.Name = "Noks_Engine_" .. name
        gui.IgnoreGuiInset = true
        gui.Parent = CoreGui
        local canvas = Instance.new("CanvasGroup")
        canvas.Size = UDim2.new(1, 0, 1, 0)
        canvas.BackgroundTransparency = 1
        canvas.Parent = gui
        local box = Instance.new("Frame")
        box.Name = "Noks_Box"
        box.BackgroundTransparency = 1
        box.BorderSizePixel = 0
        box.BackgroundColor3 = Color3.new(1, 1, 1)
        box.Parent = canvas
        local boxCorner = Instance.new("UICorner")
        boxCorner.Parent = box
        local mainStroke = Instance.new("UIStroke")
        mainStroke.LineJoinMode = Enum.LineJoinMode.Round
        mainStroke.Color = tbl2.noksBoxColor1
        mainStroke.Parent = box
        local mainGrad = Instance.new("UIGradient")
        mainGrad.Enabled = false
        mainGrad.Parent = mainStroke
        local outline = Instance.new("Frame")
        outline.Size = UDim2.new(1, 2, 1, 2)
        outline.Position = UDim2.new(0, -1, 0, -1)
        outline.BackgroundTransparency = 1
        outline.BorderSizePixel = 0
        outline.Parent = box
        local outlineCorner = Instance.new("UICorner")
        outlineCorner.Parent = outline
        local outlineStroke = Instance.new("UIStroke")
        outlineStroke.LineJoinMode = Enum.LineJoinMode.Round
        outlineStroke.Color = tbl2.noksBoxOutlineColor1
        outlineStroke.Parent = outline
        local outlineGrad = Instance.new("UIGradient")
        outlineGrad.Enabled = false
        outlineGrad.Parent = outlineStroke
        local fillGrad = Instance.new("UIGradient")
        fillGrad.Name = "Noks_FillGrad"
        fillGrad.Enabled = false
        fillGrad.Parent = box
        local healthBg = Instance.new("Frame")
        healthBg.Name = "Noks_HealthBg"
        healthBg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        healthBg.BorderSizePixel = 0
        healthBg.BackgroundTransparency = 0.4
        healthBg.Visible = false
        healthBg.Parent = canvas
        local healthBgStroke = Instance.new("UIStroke")
        healthBgStroke.Thickness = 1
        healthBgStroke.Color = Color3.fromRGB(0, 0, 0)
        healthBgStroke.Transparency = 0.5
        healthBgStroke.Parent = healthBg
        local healthContainer = Instance.new("Frame")
        healthContainer.Name = "Noks_HealthContainer"
        healthContainer.BackgroundTransparency = 1
        healthContainer.BorderSizePixel = 0
        healthContainer.ClipsDescendants = true
        healthContainer.Size = UDim2.new(1, 0, 1, 0)
        healthContainer.AnchorPoint = Vector2.new(0, 1)
        healthContainer.Position = UDim2.new(0, 0, 1, 0)
        healthContainer.Parent = healthBg
        local healthBar = Instance.new("Frame")
        healthBar.BorderSizePixel = 0
        healthBar.AnchorPoint = Vector2.new(0, 1)
        healthBar.Position = UDim2.new(0, 0, 1, 0)
        healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
        healthBar.Parent = healthContainer
        local healthGrad = Instance.new("UIGradient")
        healthGrad.Rotation = 270
        healthGrad.Enabled = false
        healthGrad.Parent = healthBar
        local hpLabel = Instance.new("TextLabel")
        hpLabel.Name = "Noks_HpLabel"
        hpLabel.BackgroundTransparency = 1
        hpLabel.TextColor3 = Color3.new(1, 1, 1)
        hpLabel.Visible = false
        hpLabel.Parent = canvas
        local hpStroke = Instance.new("UIStroke")
        hpStroke.Color = Color3.new(0, 0, 0)
        hpStroke.Parent = hpLabel
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(0, 200, 0, 20)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name:upper()
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.Parent = canvas
        local nameStroke = Instance.new("UIStroke")
        nameStroke.Color = Color3.fromRGB(0, 0, 0)
        nameStroke.Parent = nameLabel
        local nameGrad = Instance.new("UIGradient")
        nameGrad.Enabled = false
        nameGrad.Parent = nameLabel
        local distLabel = Instance.new("TextLabel")
        distLabel.Name = "Noks_Dist"
        distLabel.Size = UDim2.new(0, 200, 0, 20)
        distLabel.BackgroundTransparency = 1
        distLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
        distLabel.Parent = canvas
        local distStroke = Instance.new("UIStroke")
        distStroke.Color = Color3.fromRGB(0, 0, 0)
        distStroke.Parent = distLabel
        local lineFrame = Instance.new("Frame")
        lineFrame.Name = "Noks_Line"
        lineFrame.BorderSizePixel = 0
        lineFrame.BackgroundColor3 = Color3.fromRGB(0, 230, 255)
        lineFrame.Parent = canvas
        local lineStroke = Instance.new("UIStroke")
        lineStroke.LineJoinMode = Enum.LineJoinMode.Round
        lineStroke.Parent = lineFrame
        local lineGrad = Instance.new("UIGradient")
        lineGrad.Enabled = false
        lineGrad.Parent = lineFrame
        local flagContainer = Instance.new("Frame")
        flagContainer.Name = "Noks_Flags"
        flagContainer.BackgroundTransparency = 1
        flagContainer.BorderSizePixel = 0
        flagContainer.Parent = canvas
        local flagLayout = Instance.new("UIListLayout")
        flagLayout.SortOrder = Enum.SortOrder.LayoutOrder
        flagLayout.Padding = UDim.new(0, 2)
        flagLayout.Parent = flagContainer
        local flagName = Instance.new("TextLabel")
        flagName.BackgroundTransparency = 1
        flagName.TextXAlignment = Enum.TextXAlignment.Left
        flagName.TextColor3 = Color3.fromRGB(220, 220, 220)
        flagName.Visible = false
        flagName.Parent = flagContainer
        local flagNameStroke = Instance.new("UIStroke")
        flagNameStroke.Color = Color3.new(0, 0, 0)
        flagNameStroke.Parent = flagName
        local flagWeapon = Instance.new("TextLabel")
        flagWeapon.BackgroundTransparency = 1
        flagWeapon.TextXAlignment = Enum.TextXAlignment.Left
        flagWeapon.TextColor3 = Color3.fromRGB(200, 200, 200)
        flagWeapon.Visible = false
        flagWeapon.Parent = flagContainer
        local flagWeaponStroke = Instance.new("UIStroke")
        flagWeaponStroke.Color = Color3.new(0, 0, 0)
        flagWeaponStroke.Parent = flagWeapon
        local flagState = Instance.new("TextLabel")
        flagState.BackgroundTransparency = 1
        flagState.TextXAlignment = Enum.TextXAlignment.Left
        flagState.TextColor3 = Color3.fromRGB(255, 150, 50)
        flagState.Visible = false
        flagState.Parent = flagContainer
        local flagStateStroke = Instance.new("UIStroke")
        flagStateStroke.Color = Color3.new(0, 0, 0)
        flagStateStroke.Parent = flagState
        local flagTeam = Instance.new("TextLabel")
        flagTeam.BackgroundTransparency = 1
        flagTeam.TextXAlignment = Enum.TextXAlignment.Left
        flagTeam.TextColor3 = Color3.fromRGB(150, 255, 150)
        flagTeam.Visible = false
        flagTeam.Parent = flagContainer
        local flagTeamStroke = Instance.new("UIStroke")
        flagTeamStroke.Color = Color3.new(0, 0, 0)
        flagTeamStroke.Parent = flagTeam
        local skeletonContainer = Instance.new("Frame")
        skeletonContainer.Name = "Noks_Skeleton"
        skeletonContainer.Size = UDim2.new(1, 0, 1, 0)
        skeletonContainer.BackgroundTransparency = 1
        skeletonContainer.Visible = false
        skeletonContainer.Parent = canvas
        local boneFrames = {}
        for i = 1, 14 do
            local bone = Instance.new("Frame")
            bone.Name = "Bone_" .. i
            bone.BorderSizePixel = 0
            bone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            bone.Visible = false
            bone.Parent = skeletonContainer
            local boneGrad = Instance.new("UIGradient")
            boneGrad.Enabled = false
            boneGrad.Parent = bone
            local boneStroke = Instance.new("UIStroke")
            boneStroke.Thickness = 1
            boneStroke.Color = Color3.fromRGB(0, 0, 0)
            boneStroke.Transparency = 0.5
            boneStroke.Parent = bone
            boneFrames[i] = { Frame = bone, Grad = boneGrad, Stroke = boneStroke }
        end
        data.Gui = gui
        data.Canvas = canvas
        data.Box = box
        data.MainStroke = mainStroke
        data.BoxMainGrad = mainGrad
        data.OutlineStroke = outlineStroke
        data.BoxOutlineGrad = outlineGrad
        data.FillGrad = fillGrad
        data.NameLabel = nameLabel
        data.NameGrad = nameGrad
        data.LineFrame = lineFrame
        data.LineStroke = lineStroke
        data.LineGrad = lineGrad
        data.HealthBarBg = healthBg
        data.HealthContainer = healthContainer
        data.HealthBarVisual = healthBar
        data.HealthBarGrad = healthGrad
        data.HpLabel = hpLabel
        data.DistLabel = distLabel
        data.TextStroke = nameStroke
        data.DistStroke = distStroke
        data.HpLabelStroke = hpStroke
        data.BoxCorner = boxCorner
        data.OutlineCorner = outlineCorner
        data.FlagContainer = flagContainer
        data.FlagLayout = flagLayout
        data.FlagName = flagName
        data.FlagNameStroke = flagNameStroke
        data.FlagWeapon = flagWeapon
        data.FlagWeaponStroke = flagWeaponStroke
        data.FlagState = flagState
        data.FlagStateStroke = flagStateStroke
        data.FlagTeam = flagTeam
        data.FlagTeamStroke = flagTeamStroke
        data.SkeletonContainer = skeletonContainer
        data.BoneFrames = boneFrames
        noksPlayers[character] = data
    end
    local function removeNoksESP(character)
        if noksPlayers[character] then
            pcall(function()
                local h = character:FindFirstChild("Noks_Highlight")
                if h then h:Destroy() end
            end)
            noksPlayers[character].Gui:Destroy()
            noksPlayers[character] = nil
        end
        noksAnimState[character] = nil
    end
    local function applyNoksBoxStrokeColor(data)
        data.MainStroke.Color = tbl2.noksBoxColor1
        if tbl2.noksBoxGradient then
            data.BoxMainGrad.Color = ColorSequence.new(tbl2.noksBoxColor1, tbl2.noksBoxColor2)
            data.BoxMainGrad.Enabled = true
        else
            data.BoxMainGrad.Enabled = false
        end
    end
    local function applyNoksOutlineStrokeColor(data)
        data.OutlineStroke.Color = tbl2.noksBoxOutlineColor1
        if tbl2.noksBoxOutlineGradient then
            data.OutlineStroke.Color = Color3.new(1, 1, 1)
            data.BoxOutlineGrad.Color = ColorSequence.new(tbl2.noksBoxOutlineColor1, tbl2.noksBoxOutlineColor2)
            data.BoxOutlineGrad.Enabled = true
        else
            data.BoxOutlineGrad.Enabled = false
        end
    end
    local function applyNoksBoxFillColor(data)
        local t1 = (100 - tbl2.noksBoxFillOpacity1) / 100
        local t2 = (100 - tbl2.noksBoxFillOpacity2) / 100
        if tbl2.noksBoxFill then
            data.Box.BackgroundColor3 = tbl2.noksGradientColor1
            data.Box.BackgroundTransparency = t1
            if tbl2.noksGradientFill then
                data.FillGrad.Color = ColorSequence.new(tbl2.noksGradientColor1, tbl2.noksGradientColor2)
                data.FillGrad.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, t1),
                    NumberSequenceKeypoint.new(1, t2),
                })
                if tbl2.noksGradientRotate then
                    data.FillGrad.Rotation = (data.FillGrad.Rotation + tbl2.noksRotateSpeed) % 360
                end
                data.FillGrad.Enabled = true
            else
                data.FillGrad.Enabled = false
            end
        else
            data.FillGrad.Enabled = false
            data.Box.BackgroundTransparency = 1
        end
    end
    local function applyNoksLineColor(data)
        data.LineFrame.BackgroundColor3 = tbl2.noksLineColor1
        if tbl2.noksLineGradient then
            data.LineFrame.BackgroundColor3 = Color3.new(1, 1, 1)
            data.LineGrad.Color = ColorSequence.new(tbl2.noksLineColor1, tbl2.noksLineColor2)
            data.LineGrad.Enabled = true
        else
            data.LineGrad.Enabled = false
        end
    end
    local function applyNoksHealthBarColor(data)
        local r = data.LastHealthRatio
        data.HealthBarVisual.BackgroundColor3 = Color3.fromRGB(255, 40, 40):Lerp(Color3.fromRGB(0, 255, 120), r)
        if tbl2.noksHealthGradient then
            data.HealthBarGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, tbl2.noksHealthGrad3),
                ColorSequenceKeypoint.new(0.5, tbl2.noksHealthGrad2),
                ColorSequenceKeypoint.new(1, tbl2.noksHealthGrad1),
            })
            data.HealthBarGrad.Enabled = true
        else
            data.HealthBarGrad.Enabled = false
        end
    end
    local function triggerNoksFadeOut(character, data, now, worldPos)
        if tbl2.noksFadeOutEnable and data.Gui.Enabled then
            local clone = data.Gui:Clone()
            clone.Name = "Noks_FadeInstance_" .. character.Name
            clone.Parent = CoreGui
            local c = clone:FindFirstChildOfClass("CanvasGroup")
            table.insert(noksFadeInstances, {
                Gui = clone, Canvas = c,
                Snapshot = snapshotTransparencies(clone),
                FadeStartTime = now, WorldPosition = worldPos,
                DeathHeight = data.LastSize and data.LastSize.Y.Offset or 60,
                DeathWidth = data.LastSize and data.LastSize.X.Offset or 40,
                CloneBox = c and c:FindFirstChild("Noks_Box"),
                CloneHealthBg = c and c:FindFirstChild("Noks_HealthBg"),
                CloneNameLabel = c and c:FindFirstChild("NameLabel"),
                CloneHpLabel = c and c:FindFirstChild("Noks_HpLabel"),
                CloneDist = c and c:FindFirstChild("Noks_Dist"),
                CloneLine = c and c:FindFirstChild("Noks_Line"),
                CloneFlags = c and c:FindFirstChild("Noks_Flags"),
                LastHealthRatio = data.LastHealthRatio,
                BoxFillGradRotation = data.FillGrad.Rotation,
                LastUpdate = now,
            })
        end
        data.Gui.Enabled = false
    end
    local noksRenderConn = runService.RenderStepped:Connect(function()
        local cam = workspace.CurrentCamera
        if not cam then return end
        local now = tick()
        local vp = cam.ViewportSize
        local font = getNoksFont()
        local activeSet = {}
        if tbl2.noksEspEnabled then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= localPlayer and p.Character then
                    local c = p.Character
                    local hrp = c:FindFirstChild("HumanoidRootPart")
                    local hum = c:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.Health > 0 then activeSet[c] = true end
                end
            end
        end
        for c in pairs(activeSet) do if not noksPlayers[c] then createNoksESP(c) end end
        local origin = Vector2.new(vp.X / 2, vp.Y)
        if tbl2.noksLineOrigin == "Top" then origin = Vector2.new(vp.X / 2, 0)
        elseif tbl2.noksLineOrigin == "Center" then origin = Vector2.new(vp.X / 2, vp.Y / 2)
        elseif tbl2.noksLineOrigin == "Mouse" then origin = userInputService:GetMouseLocation() end
        local toRemove = {}
        for char, data in pairs(noksPlayers) do
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not activeSet[char] then
                table.insert(toRemove, char)
                local lastPos = data.LastWorldPosition
                if not lastPos then
                    local pp = char.PrimaryPart or char:FindFirstChild("HumanoidRootPart")
                    lastPos = pp and pp.Position or Vector3.zero
                end
                if hum and hum.Health <= 0 then
                    data.LastHealthRatio = 0
                    if data.HealthContainer then data.HealthContainer.Size = UDim2.new(1, 0, 0, 0) end
                    if data.HpLabel then data.HpLabel.Visible = false end
                    applyNoksHealthBarColor(data)
                end
                triggerNoksFadeOut(char, data, now, lastPos)
                pcall(function()
                    local h = char:FindFirstChild("Noks_Highlight")
                    if h then h:Destroy() end
                end)
            elseif hrp and hum then
                data.LastWorldPosition = hrp.Position
                local dist = (cam.CFrame.Position - hrp.Position).Magnitude
                if dist > tbl2.noksMaxDistance then
                    data.Gui.Enabled = false
                    pcall(function()
                        local h = char:FindFirstChild("Noks_Highlight")
                        if h then h:Destroy() end
                    end)
                else
                    local sp, onScreen = cam:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        data.Gui.Enabled = true
                        applyNoksChams(char)
                        local topY = cam:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0)).Y
                        local botY = cam:WorldToViewportPoint(hrp.Position + Vector3.new(0, -3.5, 0)).Y
                        local h = math.clamp(math.abs(topY - botY), 25, tbl2.noksMaxBoxHeight or 350)
                        local w = h / 1.6
                        data.LastPosition = UDim2.new(0, sp.X - w / 2, 0, sp.Y - h / 2)
                        data.LastSize = UDim2.new(0, w, 0, h)
                        data.LastNamePos = UDim2.new(0, sp.X - 100, 0, sp.Y - h / 2 - tbl2.noksTextSize + 7)
                        if tbl2.noksLineAttachment == "Top" then
                            data.LastLineTarget = Vector2.new(sp.X, sp.Y - h / 2)
                        elseif tbl2.noksLineAttachment == "Center" then
                            data.LastLineTarget = Vector2.new(sp.X, sp.Y)
                        else
                            data.LastLineTarget = Vector2.new(sp.X, sp.Y + h / 2)
                        end
                        data.LastHealthRatio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                        data.LastDistanceText = string.format("%d STUDS", math.floor(dist))
                        data.LastDistancePos = UDim2.new(0, sp.X - 100, 0, sp.Y + h / 2 + 4)
                        data.Box.Position = data.LastPosition
                        data.Box.Size = data.LastSize
                        data.Box.Visible = true
                        data.BoxCorner.CornerRadius = UDim.new(0, tbl2.noksBoxCornerRadius)
                        data.OutlineCorner.CornerRadius = UDim.new(0, tbl2.noksBoxCornerRadius)
                        data.NameLabel.Font = font
                        data.NameLabel.TextSize = tbl2.noksTextSize
                        data.NameLabel.Position = data.LastNamePos
                        data.DistLabel.Font = font
                        data.DistLabel.TextSize = tbl2.noksTextSize - 1
                        data.TextStroke.Thickness = tbl2.noksTextStrokeThickness
                        data.TextStroke.Transparency = tbl2.noksTextStrokeTrans / 100
                        data.DistStroke.Thickness = tbl2.noksTextStrokeThickness
                        data.DistStroke.Transparency = tbl2.noksTextStrokeTrans / 100
                        data.MainStroke.Enabled = tbl2.noksBoxEnable
                        data.MainStroke.Thickness = tbl2.noksBoxStrokeThickness
                        applyNoksBoxStrokeColor(data)
                        data.OutlineStroke.Enabled = tbl2.noksBoxEnable and tbl2.noksBoxOutline
                        data.OutlineStroke.Thickness = tbl2.noksBoxStrokeThickness
                        data.OutlineStroke.Transparency = tbl2.noksBoxStrokeTrans / 100
                        applyNoksOutlineStrokeColor(data)
                        applyNoksBoxFillColor(data)
                        if tbl2.noksHealthBarEnable then
                            data.HealthBarBg.Visible = true
                            data.HealthBarBg.Position = UDim2.new(0, sp.X - w / 2 - tbl2.noksHealthBarOffset, 0, sp.Y - h / 2)
                            data.HealthBarBg.Size = UDim2.new(0, tbl2.noksHealthBarWidth, 0, h)
                            data.HealthContainer.Size = UDim2.new(1, 0, data.LastHealthRatio, 0)
                            data.HealthBarVisual.Size = UDim2.new(1, 0, 0, h)
                            applyNoksHealthBarColor(data)
                            if tbl2.noksHealthTextEnable and data.LastHealthRatio < 0.98 then
                                data.HpLabel.Visible = true
                                data.HpLabel.Font = font
                                data.HpLabel.TextSize = tbl2.noksTextSize - 2
                                data.HpLabel.Text = string.format("%d", math.floor(hum.Health))
                                data.HpLabel.Position = UDim2.new(0, sp.X - w / 2 - tbl2.noksHealthBarOffset + 16, 0, sp.Y - h / 2 + h * (1 - data.LastHealthRatio) - 4)
                                data.HpLabelStroke.Thickness = tbl2.noksTextStrokeThickness
                                data.HpLabelStroke.Transparency = tbl2.noksTextStrokeTrans / 100
                            else
                                data.HpLabel.Visible = false
                            end
                        else
                            data.HealthBarBg.Visible = false
                            data.HpLabel.Visible = false
                        end
                        data.NameLabel.Visible = tbl2.noksNameEnable
                        if tbl2.noksNameGradient then
                            data.NameGrad.Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, tbl2.noksTextGradColor1),
                                ColorSequenceKeypoint.new(0.5, tbl2.noksTextGradColor2),
                                ColorSequenceKeypoint.new(1, tbl2.noksTextGradColor1),
                            })
                            data.NameGrad.Enabled = true
                        else
                            data.NameGrad.Enabled = false
                        end
                        data.NameLabel.TextColor3 = tbl2.noksNameColor
                        if tbl2.noksDistanceEnable then
                            data.DistLabel.Visible = true
                            data.DistLabel.Text = data.LastDistanceText
                            data.DistLabel.TextColor3 = tbl2.noksDistanceColor
                            data.DistLabel.Position = data.LastDistancePos
                        else
                            data.DistLabel.Visible = false
                        end
                        if tbl2.noksLineEnable then
                            data.LineFrame.Visible = true
                            updateNoksLine(data.LineFrame, origin, data.LastLineTarget, tbl2.noksLineThickness)
                            data.LineStroke.Enabled = tbl2.noksLineOutline
                            data.LineStroke.Color = tbl2.noksLineOutlineColor
                            data.LineStroke.Thickness = tbl2.noksLineStrokeThickness
                            applyNoksLineColor(data)
                        else
                            data.LineFrame.Visible = false
                        end
                        data.FlagContainer.Position = UDim2.new(0, sp.X + w / 2 + 5, 0, sp.Y - h / 2)
                        data.FlagContainer.Size = UDim2.new(0, 150, 0, h)
                        if data.FlagLayout then data.FlagLayout.Padding = UDim.new(0, tbl2.noksFlagSpacing) end
                        if tbl2.noksFlagsEnable then
                            local player = Players:FindFirstChild(char.Name)
                            local uid = player and tostring(player.UserId) or "?"
                            data.FlagName.Visible = tbl2.noksFlagNameEnable
                            data.FlagName.Font = font
                            data.FlagName.TextSize = tbl2.noksFlagTextSize
                            data.FlagName.TextColor3 = tbl2.noksFlagNameColor
                            data.FlagName.Text = string.format("[%s]", uid)
                            data.FlagNameStroke.Thickness = tbl2.noksTextStrokeThickness
                            data.FlagNameStroke.Transparency = tbl2.noksTextStrokeTrans / 100
                            local tool = char:FindFirstChildOfClass("Tool")
                            local toolName = tool and tool.Name or "FISTS"
                            data.FlagWeapon.Visible = tbl2.noksFlagWeaponEnable
                            data.FlagWeapon.Font = font
                            data.FlagWeapon.TextSize = tbl2.noksFlagTextSize
                            data.FlagWeapon.TextColor3 = tbl2.noksFlagWeaponColor
                            data.FlagWeapon.Text = string.format("[%s]", toolName:upper())
                            data.FlagWeaponStroke.Thickness = tbl2.noksTextStrokeThickness
                            data.FlagWeaponStroke.Transparency = tbl2.noksTextStrokeTrans / 100
                            if tbl2.noksFlagStateEnable then
                                if hum.FloorMaterial == Enum.Material.Air then
                                    data.FlagState.Visible = true
                                    data.FlagState.Text = "AIR"
                                elseif hum.MoveDirection.Magnitude > 0 then
                                    data.FlagState.Visible = true
                                    data.FlagState.Text = "RUN"
                                else
                                    data.FlagState.Visible = false
                                end
                                data.FlagState.Font = font
                                data.FlagState.TextSize = tbl2.noksFlagTextSize
                                data.FlagState.TextColor3 = tbl2.noksFlagStateColor
                                data.FlagStateStroke.Thickness = tbl2.noksTextStrokeThickness
                                data.FlagStateStroke.Transparency = tbl2.noksTextStrokeTrans / 100
                            else
                                data.FlagState.Visible = false
                            end
                            data.FlagTeam.Visible = false
                        else
                            data.FlagName.Visible = false
                            data.FlagWeapon.Visible = false
                            data.FlagState.Visible = false
                            data.FlagTeam.Visible = false
                        end
                        data.Canvas.GroupTransparency = 0
                        if tbl2.noksSkeletonEnable then
                            data.SkeletonContainer.Visible = true
                            local bones = hum.RigType == Enum.HumanoidRigType.R15 and r15Bones or r6Bones
                            local scroll = 0
                            if tbl2.noksSkeletonScroll then scroll = -(tick() * (tbl2.noksSkeletonScrollSpeed / 10)) % 1 end
                            for i = 1, 14 do
                                local bd = data.BoneFrames[i]
                                local bone = bones[i]
                                if bone then
                                    local p1 = getJointPosition(char, bone[1], bone[2])
                                    local p2 = getJointPosition(char, bone[2], bone[1])
                                    if p1 and p2 then
                                        local s1, on1 = cam:WorldToViewportPoint(p1)
                                        local s2, on2 = cam:WorldToViewportPoint(p2)
                                        if on1 or on2 then
                                            bd.Frame.Visible = true
                                            updateNoksLine(bd.Frame, s1, s2, tbl2.noksSkeletonThickness)
                                            if tbl2.noksSkeletonGradient then
                                                bd.Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                                bd.Grad.Color = ColorSequence.new(tbl2.noksSkeletonColor1, tbl2.noksSkeletonColor2)
                                                bd.Grad.Offset = Vector2.new(scroll, 0)
                                                bd.Grad.Enabled = true
                                            else
                                                bd.Grad.Enabled = false
                                                bd.Frame.BackgroundColor3 = tbl2.noksSkeletonColor1
                                            end
                                        else
                                            bd.Frame.Visible = false
                                        end
                                    else
                                        bd.Frame.Visible = false
                                    end
                                else
                                    bd.Frame.Visible = false
                                end
                            end
                        else
                            data.SkeletonContainer.Visible = false
                        end
                    else
                        data.Gui.Enabled = false
                        pcall(function()
                            local h = char:FindFirstChild("Noks_Highlight")
                            if h then h:Destroy() end
                        end)
                    end
                end
            else
                data.Gui.Enabled = false
                pcall(function()
                    local h = char:FindFirstChild("Noks_Highlight")
                    if h then h:Destroy() end
                end)
            end
        end
        for _, char in ipairs(toRemove) do removeNoksESP(char) end
        for i = #noksFadeInstances, 1, -1 do
            local fade = noksFadeInstances[i]
            local elapsed = now - fade.FadeStartTime
            if elapsed >= tbl2.noksFadeDuration then
                fade.Gui:Destroy()
                table.remove(noksFadeInstances, i)
            else
                local alpha = elapsed / tbl2.noksFadeDuration
                local sp, onScreen = cam:WorldToViewportPoint(fade.WorldPosition)
                if onScreen then
                    fade.Gui.Enabled = true
                    local h = fade.DeathHeight
                    local w = fade.DeathWidth
                    if fade.CloneBox then
                        fade.CloneBox.Position = UDim2.new(0, sp.X - w / 2, 0, sp.Y - h / 2)
                        fade.CloneBox.Size = UDim2.new(0, w, 0, h)
                    end
                    if fade.CloneHealthBg then
                        fade.CloneHealthBg.Position = UDim2.new(0, sp.X - w / 2 - tbl2.noksHealthBarOffset, 0, sp.Y - h / 2)
                        fade.CloneHealthBg.Size = UDim2.new(0, tbl2.noksHealthBarWidth, 0, h)
                    end
                    if fade.CloneNameLabel then
                        fade.CloneNameLabel.Position = UDim2.new(0, sp.X - 100, 0, sp.Y - h / 2 - tbl2.noksTextSize + 7)
                    end
                    if fade.CloneHpLabel and fade.CloneHpLabel.Visible then
                        fade.CloneHpLabel.Position = UDim2.new(0, sp.X - w / 2 - tbl2.noksHealthBarOffset + 16, 0, sp.Y - h / 2 + h * (1 - fade.LastHealthRatio) - 4)
                    end
                    if fade.CloneDist then
                        fade.CloneDist.Position = UDim2.new(0, sp.X - 100, 0, sp.Y + h / 2 + 4)
                    end
                    if fade.CloneLine and fade.CloneLine.Visible then
                        updateNoksLine(fade.CloneLine, origin, Vector2.new(sp.X, sp.Y + h / 2), tbl2.noksLineThickness)
                    end
                    if fade.CloneFlags then
                        fade.CloneFlags.Position = UDim2.new(0, sp.X + w / 2 + 5, 0, sp.Y - h / 2)
                        fade.CloneFlags.Size = UDim2.new(0, 150, 0, h)
                    end
                else
                    fade.Gui.Enabled = false
                end
                applyFadeTransparency(fade.Snapshot, alpha)
                if fade.CloneBox then
                    local fg = fade.CloneBox:FindFirstChild("Noks_FillGrad")
                    if fg and tbl2.noksGradientFill and tbl2.noksGradientRotate then
                        fg.Rotation = (fade.BoxFillGradRotation + tbl2.noksRotateSpeed * elapsed) % 360
                    end
                end
            end
        end
    end)
    table.insert(tbl3.visualConnections, noksRenderConn)

    -- Location ESP (PCLD)
    local locationESPActive = nil
    local function setupPlayerLocationVisual()
        if not tbl2.playerLocationVisualEnabled then return end
        local targetName = "PlayerCharacterLocationDetector"
        local cam = workspace.CurrentCamera
        local existing = CoreGui:FindFirstChild("PoophubLocationEsp")
        if existing then pcall(function() existing:Destroy() end) end
        local exParts = workspace:FindFirstChild("PoophubLocationParts")
        if exParts then pcall(function() exParts:Destroy() end) end
        local sGui = Instance.new("ScreenGui")
        sGui.Name = "PoophubLocationEsp"
        sGui.ResetOnSpawn = false
        sGui.IgnoreGuiInset = true
        sGui.Parent = CoreGui
        local folder = Instance.new("Folder")
        folder.Name = "PoophubLocationParts"
        folder.Parent = workspace
        local partList = {}
        local espData = {}
        local function createEspForPart(part)
            local container = Instance.new("Frame")
            container.Size = UDim2.fromOffset(0, 0)
            container.AnchorPoint = Vector2.new(0.5, 0.5)
            container.BackgroundTransparency = 1
            container.Visible = false
            container.Parent = sGui
            local glow = Instance.new("ImageLabel")
            glow.Name = "Glow"
            glow.Image = "rbxassetid://110204605000367"
            glow.ScaleType = Enum.ScaleType.Slice
            glow.SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
            glow.AnchorPoint = Vector2.new(0.5, 0.5)
            glow.Position = UDim2.fromScale(0.5, 0.5)
            glow.Size = UDim2.fromOffset(80, 80)
            glow.ImageTransparency = 0.5
            glow.ResampleMode = Enum.ResamplerMode.Pixelated
            glow.BackgroundTransparency = 1
            glow.BorderSizePixel = 0
            glow.ZIndex = 0
            glow.Visible = false
            glow.Parent = container
            local canvas = Instance.new("CanvasGroup")
            canvas.Name = "CanvasGroup"
            canvas.Size = UDim2.fromOffset(0, 0)
            canvas.AnchorPoint = Vector2.new(0.5, 0.5)
            canvas.Position = UDim2.fromScale(0.5, 0.5)
            canvas.BackgroundTransparency = 1
            canvas.Parent = container
            local cc = Instance.new("Frame")
            cc.Name = "CornersContainer"
            cc.Size = UDim2.fromOffset(0, 0)
            cc.AnchorPoint = Vector2.new(0.5, 0.5)
            cc.Position = UDim2.fromScale(0.5, 0.5)
            cc.BackgroundTransparency = 1
            cc.Parent = canvas
            local corners = {}
            for i = 1, 4 do
                local corner = Instance.new("Frame")
                corner.AnchorPoint = Vector2.new(0.5, 0.5)
                corner.BackgroundTransparency = 1
                corner.Size = UDim2.fromOffset(0, 0)
                corner.Rotation = (i - 1) * 90
                corner.Parent = cc
                local horiz = Instance.new("Frame", corner)
                horiz.Name = "Horiz"
                horiz.BorderSizePixel = 0
                horiz.Size = UDim2.fromOffset(0, 0)
                horiz.BackgroundTransparency = 1
                local hs = Instance.new("UIStroke", horiz)
                hs.Name = "OutlineStroke"
                hs.Enabled = false
                local vert = Instance.new("Frame", corner)
                vert.Name = "Vert"
                vert.BorderSizePixel = 0
                vert.Size = UDim2.fromOffset(0, 0)
                vert.BackgroundTransparency = 1
                local vs = Instance.new("UIStroke", vert)
                vs.Name = "OutlineStroke"
                vs.Enabled = false
                table.insert(corners, corner)
            end
            local boxPart = Instance.new("Part")
            boxPart.Name = "PCLD_BoxPart"
            boxPart.Anchored = true
            boxPart.CanCollide = false
            boxPart.CastShadow = false
            boxPart.CanQuery = false
            boxPart.CanTouch = false
            boxPart.Locked = true
            boxPart.Transparency = 1
            boxPart.Parent = folder
            local selBox = Instance.new("SelectionBox")
            selBox.Name = "PCLD_SelectionBox"
            selBox.Adornee = boxPart
            selBox.Visible = false
            selBox.SurfaceTransparency = 1
            selBox.Parent = folder
            local att0 = Instance.new("Attachment", boxPart)
            local att1 = Instance.new("Attachment", boxPart)
            local trail = Instance.new("Trail", boxPart)
            trail.Attachment0 = att0
            trail.Attachment1 = att1
            trail.Enabled = false
            trail.FaceCamera = true
            espData[part] = {
                part = part, container = container, cornersContainer = cc,
                corners = corners, boxPart = boxPart, selBox = selBox, trail = trail,
                att0 = att0, att1 = att1, canvasGroup = canvas, glow = glow,
                estimatedCFrame = part.CFrame, rotAngle = 0,
            }
        end
        local function removeEspForPart(part)
            local d = espData[part]
            if d then
                pcall(function() d.container:Destroy() end)
                pcall(function() d.boxPart:Destroy() end)
                pcall(function() d.selBox:Destroy() end)
                espData[part] = nil
            end
        end
        local function addPart(part)
            if not table.find(partList, part) then
                table.insert(partList, part)
                createEspForPart(part)
            end
        end
        local function removePart(part)
            local idx = table.find(partList, part)
            if idx then
                table.remove(partList, idx)
                removeEspForPart(part)
            end
        end
        for _, d in ipairs(workspace:GetDescendants()) do
            if d.Name == targetName and d:IsA("BasePart") then addPart(d) end
        end
        local c1 = workspace.DescendantAdded:Connect(function(d)
            if d.Name == targetName and d:IsA("BasePart") then addPart(d) end
        end)
        local c2 = workspace.DescendantRemoving:Connect(function(d)
            if d.Name == targetName and d:IsA("BasePart") then removePart(d) end
        end)
        local rc = runService.RenderStepped:Connect(function(dt)
            if not tbl2.playerLocationVisualEnabled then return end
            local now = tick()
            local baseColor
            if tbl2.locationESPGradientEnabled then
                baseColor = tbl2.locationESPGradientColor1:Lerp(tbl2.locationESPGradientColor2, 0.5 + 0.5 * math.sin(now * tbl2.locationESPGradientSpeed * math.pi))
            else
                baseColor = tbl2.locationESPColor
            end
            local gAngle = tbl2.locationESPUIGradientAngle or 0
            if tbl2.locationESPUIGradientAutoRotate then
                gAngle = now * (tbl2.locationESPUIGradientAutoSpeed or 20) * 10 % 360
            end
            for part, data in pairs(espData) do
                if not part or not part.Parent then
                    removePart(part)
                else
                    local pos = part.Position
                    if math.abs(pos.X) < 0.01 and math.abs(pos.Y) < 0.01 and math.abs(pos.Z) < 0.01 then
                        data.container.Visible = false
                        data.boxPart.Transparency = 1
                        data.selBox.Visible = false
                    else
                        if tbl2.locationESPSmoothingEnabled then
                            data.estimatedCFrame = data.estimatedCFrame:Lerp(part.CFrame, 1 - math.exp(-tbl2.locationESPSmoothingSpeed * dt))
                        else
                            data.estimatedCFrame = part.CFrame
                        end
                        local partColor = tbl2.locationESPGradientEnabled and baseColor or tbl2.locationESPPartColor
                        if tbl2.locationESPPartEnabled then
                            data.boxPart.CFrame = data.estimatedCFrame
                            data.boxPart.Size = part.Size
                            local mat = Enum.Material[tbl2.locationESPPartMaterial]
                            if mat then data.boxPart.Material = mat end
                            data.boxPart.Color = partColor
                            data.boxPart.Transparency = tbl2.locationESPPartTransparency
                            if tbl2.locationESPBoxOutlineEnabled then
                                data.selBox.Visible = true
                                data.selBox.Color3 = tbl2.locationESPBoxOutlineColor
                                data.selBox.LineThickness = tbl2.locationESPBoxOutlineThickness
                            else
                                data.selBox.Visible = false
                            end
                        else
                            data.boxPart.Transparency = 1
                            data.selBox.Visible = false
                        end
                        if tbl2.locationESPTrailEnabled then
                            data.trail.Enabled = true
                            data.trail.Color = ColorSequence.new(tbl2.locationESPTrailColor or Color3.new(1, 1, 1))
                            data.trail.Lifetime = tbl2.locationESPTrailLifetime or 0.5
                        else
                            data.trail.Enabled = false
                        end
                        local sp, onScreen = cam:WorldToViewportPoint(data.estimatedCFrame.Position)
                        if onScreen then
                            data.container.Visible = true
                            data.container.Position = UDim2.fromOffset(sp.X, sp.Y)
                            if tbl2.locationESPCornerEnabled then
                                data.cornersContainer.Visible = true
                                data.rotAngle = (data.rotAngle + dt * tbl2.locationESPRotationSpeed) % 360
                                data.cornersContainer.Rotation = data.rotAngle
                                local radius = tbl2.locationESPMinRadius + (tbl2.locationESPMaxRadius - tbl2.locationESPMinRadius) * (0.5 + 0.5 * math.sin(now * tbl2.locationESPExpandSpeed))
                                local len = tbl2.locationESPLength
                                local thick = math.min(tbl2.locationESPThickness, len)
                                data.corners[1].Position = UDim2.fromOffset(-radius, -radius)
                                data.corners[2].Position = UDim2.fromOffset(radius, -radius)
                                data.corners[3].Position = UDim2.fromOffset(radius, radius)
                                data.corners[4].Position = UDim2.fromOffset(-radius, radius)
                                local cSize = (radius + len) * 3
                                data.canvasGroup.Size = UDim2.fromOffset(cSize, cSize)
                                for i, corner in ipairs(data.corners) do
                                    corner.Size = UDim2.fromOffset(len, len)
                                    local rot = gAngle + (i - 1) * 90
                                    for _, child in ipairs(corner:GetChildren()) do
                                        if child.Name == "Horiz" then
                                            child.Position = UDim2.fromOffset(0, 0)
                                            child.Size = UDim2.fromOffset(len, thick)
                                            child.BackgroundTransparency = 0
                                            if tbl2.locationESPGradientEnabled then
                                                child.BackgroundColor3 = Color3.new(1, 1, 1)
                                                local g = child:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient", child)
                                                g.Color = ColorSequence.new(tbl2.locationESPGradientColor1, tbl2.locationESPGradientColor2)
                                                g.Rotation = rot
                                            else
                                                child.BackgroundColor3 = baseColor
                                                local g = child:FindFirstChildOfClass("UIGradient")
                                                if g then g:Destroy() end
                                            end
                                            local cr = child:FindFirstChildOfClass("UICorner") or Instance.new("UICorner", child)
                                            cr.CornerRadius = UDim.new(0, tbl2.locationESPCornerRoundness or 0)
                                            local o = child:FindFirstChild("OutlineStroke")
                                            if o then
                                                o.Enabled = tbl2.locationESPCornerOutlineEnabled
                                                o.Color = tbl2.locationESPCornerOutlineColor
                                                o.Thickness = tbl2.locationESPCornerOutlineThickness
                                            end
                                        elseif child.Name == "Vert" then
                                            child.Position = UDim2.fromOffset(0, 0)
                                            child.Size = UDim2.fromOffset(thick, len)
                                            child.BackgroundTransparency = 0
                                            if tbl2.locationESPGradientEnabled then
                                                child.BackgroundColor3 = Color3.new(1, 1, 1)
                                                local g = child:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient", child)
                                                g.Color = ColorSequence.new(tbl2.locationESPGradientColor1, tbl2.locationESPGradientColor2)
                                                g.Rotation = rot + 90
                                            else
                                                child.BackgroundColor3 = baseColor
                                                local g = child:FindFirstChildOfClass("UIGradient")
                                                if g then g:Destroy() end
                                            end
                                            local cr = child:FindFirstChildOfClass("UICorner") or Instance.new("UICorner", child)
                                            cr.CornerRadius = UDim.new(0, tbl2.locationESPCornerRoundness or 0)
                                            local o = child:FindFirstChild("OutlineStroke")
                                            if o then
                                                o.Enabled = tbl2.locationESPCornerOutlineEnabled
                                                o.Color = tbl2.locationESPCornerOutlineColor
                                                o.Thickness = tbl2.locationESPCornerOutlineThickness
                                            end
                                        end
                                    end
                                end
                            else
                                data.cornersContainer.Visible = false
                            end
                            if tbl2.locationESPGlowEnabled then
                                data.glow.Visible = true
                                local gs = (tbl2.locationESPGlowSize or 20) + math.sin(now * 2) * 10
                                data.glow.Size = UDim2.fromOffset(gs, gs)
                                if tbl2.locationESPGradientEnabled then
                                    data.glow.ImageColor3 = tbl2.locationESPGlowColor1:Lerp(tbl2.locationESPGlowColor2, 0.5 + 0.5 * math.sin(now * tbl2.locationESPGradientSpeed * math.pi))
                                    data.glow.ImageTransparency = tbl2.locationESPGlowTransparency or 0.5
                                else
                                    data.glow.ImageColor3 = tbl2.locationESPGlowColor1 or Color3.new(1, 1, 1)
                                    data.glow.ImageTransparency = tbl2.locationESPGlowTransparency or 0.5
                                end
                            else
                                data.glow.Visible = false
                            end
                        else
                            data.container.Visible = false
                        end
                    end
                end
            end
        end)
        table.insert(tbl3.visualConnections, rc)
        table.insert(tbl3.visualConnections, c1)
        table.insert(tbl3.visualConnections, c2)
        return function()
            c1:Disconnect()
            c2:Disconnect()
            pcall(function() sGui:Destroy() end)
            pcall(function() folder:Destroy() end)
            for _, d in pairs(espData) do
                pcall(function() d.container:Destroy() end)
                pcall(function() d.boxPart:Destroy() end)
                pcall(function() d.selBox:Destroy() end)
            end
            table.clear(espData)
            table.clear(partList)
        end
    end

    -- ESP GUI
    local ESPLeft = Tabs.ESP:AddLeftGroupbox("Toy ESP")
    ESPLeft:AddToggle("ShurikenESP", { Text = "Shuriken (AntiKick) ESP", Default = false,
        Callback = function(v) tbl2.shurikenESPEnabled = v end })
    ESPLeft:AddDropdown("ShurikenColorMode", { Text = "Shuriken Color Mode", Values = { "Rainbow", "Custom" }, Default = "Rainbow",
        Callback = function(v) tbl2.shurikenESPColorMode = v end })
    ESPLeft:AddLabel("Shuriken Custom Color"):AddColorPicker("ShurikenSolidColor", { Title = "Shuriken Custom Color",
        Default = Color3.fromRGB(0, 230, 255), Callback = function(c) tbl2.shurikenESPSolidColor = c end })
    ESPLeft:AddSlider("ShurikenESPTrans", { Text = "Shuriken Transparency", Default = 0.3, Min = 0, Max = 1, Rounding = 1,
        Callback = function(v) tbl2.shurikenESPTransparency = v end })
    ESPLeft:AddDivider()
    ESPLeft:AddToggle("BlobmanESP", { Text = "Blobman ESP", Default = false,
        Callback = function(v) tbl2.blobmanESPEnabled = v end })
    ESPLeft:AddDropdown("BlobmanColorMode", { Text = "Blobman Color Mode", Values = { "Rainbow", "Custom" }, Default = "Rainbow",
        Callback = function(v) tbl2.blobmanESPColorMode = v end })
    ESPLeft:AddLabel("Blobman Custom Color"):AddColorPicker("BlobmanSolidColor", { Title = "Blobman Custom Color",
        Default = Color3.fromRGB(160, 0, 255), Callback = function(c) tbl2.blobmanESPSolidColor = c end })
    ESPLeft:AddSlider("BlobmanESPTrans", { Text = "Blobman Transparency", Default = 0.3, Min = 0, Max = 1, Rounding = 1,
        Callback = function(v) tbl2.blobmanESPTransparency = v end })
    ESPLeft:AddSlider("ESPRainbowSpeed", { Text = "Rainbow ESP Speed", Default = 2, Min = 0.1, Max = 10, Rounding = 1,
        Callback = function(v) tbl2.rainbowSpeedESP = v end })

    local NoksMaster = Tabs.ESP:AddLeftGroupbox("Noks Premium ESP")
    NoksMaster:AddToggle("NoksEspMaster", { Text = "Enable Premium ESP", Default = false,
        Callback = function(v) tbl2.noksEspEnabled = v end })

    local NoksBox = Tabs.ESP:AddLeftGroupbox("Player Box Overlay")
    NoksBox:AddToggle("NoksBoxEnable", { Text = "Enable Box Render", Default = false, Callback = function(v) tbl2.noksBoxEnable = v end }):AddColorPicker("NoksBoxColor1", { Default = Color3.fromRGB(180, 140, 255), Title = "Box Color 1", Callback = function(c) tbl2.noksBoxColor1 = c end })
    NoksBox:AddToggle("NoksBoxGradient", { Text = "Enable Box Gradient", Default = false, Callback = function(v) tbl2.noksBoxGradient = v end }):AddColorPicker("NoksBoxColor2", { Default = Color3.fromRGB(100, 50, 200), Title = "Box Color 2", Callback = function(c) tbl2.noksBoxColor2 = c end })
    NoksBox:AddToggle("NoksBoxOutline", { Text = "Enable Box Outline", Default = false, Callback = function(v) tbl2.noksBoxOutline = v end }):AddColorPicker("NoksBoxOutlineColor1", { Default = Color3.fromRGB(10, 10, 10), Title = "Outline Color 1", Callback = function(c) tbl2.noksBoxOutlineColor1 = c end })
    NoksBox:AddToggle("NoksBoxOutlineGradient", { Text = "Enable Outline Gradient", Default = false, Callback = function(v) tbl2.noksBoxOutlineGradient = v end }):AddColorPicker("NoksBoxOutlineColor2", { Default = Color3.fromRGB(40, 40, 40), Title = "Outline Color 2", Callback = function(c) tbl2.noksBoxOutlineColor2 = c end })
    NoksBox:AddSlider("NoksBoxStrokeThickness", { Text = "Outline Thickness", Default = 1.5, Min = 1, Max = 5, Rounding = 1, Callback = function(v) tbl2.noksBoxStrokeThickness = v end })
    NoksBox:AddSlider("NoksBoxStrokeTrans", { Text = "Outline Transparency (%)", Default = 30, Min = 0, Max = 100, Rounding = 1, Callback = function(v) tbl2.noksBoxStrokeTrans = v end })
    NoksBox:AddSlider("NoksBoxCornerRadius", { Text = "Box Smooth Corners (px)", Default = 4, Min = 0, Max = 20, Rounding = 1, Callback = function(v) tbl2.noksBoxCornerRadius = v end })
    NoksBox:AddSlider("NoksMaxBoxHeight", { Text = "Max ESP Box Height (px)", Default = 350, Min = 50, Max = 1000, Rounding = 1, Callback = function(v) tbl2.noksMaxBoxHeight = v end })

    local NoksId = Tabs.ESP:AddLeftGroupbox("Player Identity Overlay")
    NoksId:AddToggle("NoksNameEnable", { Text = "Enable Text Name", Default = false, Callback = function(v) tbl2.noksNameEnable = v end }):AddColorPicker("NoksNameColor", { Default = Color3.fromRGB(255, 255, 255), Title = "Text Base Color", Callback = function(c) tbl2.noksNameColor = c end })
    local NoksNameGrad = NoksId:AddToggle("NoksNameGradient", { Text = "Use Seamless Gradient Loop", Default = false, Callback = function(v) tbl2.noksNameGradient = v end })
    NoksNameGrad:AddColorPicker("NoksTextGradColor1", { Default = Color3.fromRGB(255, 110, 110), Title = "Grad Left", Callback = function(c) tbl2.noksTextGradColor1 = c end })
    NoksNameGrad:AddColorPicker("NoksTextGradColor2", { Default = Color3.fromRGB(255, 230, 110), Title = "Grad Right", Callback = function(c) tbl2.noksTextGradColor2 = c end })
    NoksId:AddSlider("NoksNameScrollSpeed", { Text = "Chroma Wave Velocity", Default = 4, Min = 1, Max = 10, Rounding = 1, Callback = function(v) tbl2.noksNameScrollSpeed = v end })
    NoksId:AddDropdown("NoksTextFont", { Text = "Global Text Font", Default = "GothamBold", Values = { "GothamBold", "SourceSansBold", "Arcade", "Roboto" }, Callback = function(v) tbl2.noksTextFont = v end })
    NoksId:AddSlider("NoksTextSize", { Text = "Text Font Size", Default = 11, Min = 8, Max = 16, Rounding = 1, Callback = function(v) tbl2.noksTextSize = v end })
    NoksId:AddSlider("NoksTextStrokeThickness", { Text = "Text Shadow Thickness", Default = 1, Min = 0.5, Max = 3, Rounding = 1, Callback = function(v) tbl2.noksTextStrokeThickness = v end })
    NoksId:AddSlider("NoksTextStrokeTrans", { Text = "Text Shadow Trans (%)", Default = 30, Min = 0, Max = 100, Rounding = 1, Callback = function(v) tbl2.noksTextStrokeTrans = v end })

    local NoksLine = Tabs.ESP:AddLeftGroupbox("Target Tracer Lines")
    NoksLine:AddToggle("NoksLineEnable", { Text = "Enable Snaplines", Default = false, Callback = function(v) tbl2.noksLineEnable = v end }):AddColorPicker("NoksLineColor1", { Default = Color3.fromRGB(0, 230, 255), Title = "Line Color 1", Callback = function(c) tbl2.noksLineColor1 = c end })
    NoksLine:AddToggle("NoksLineGradient", { Text = "Enable Line Gradient", Default = false, Callback = function(v) tbl2.noksLineGradient = v end }):AddColorPicker("NoksLineColor2", { Default = Color3.fromRGB(255, 0, 150), Title = "Line Color 2", Callback = function(c) tbl2.noksLineColor2 = c end })
    NoksLine:AddSlider("NoksLineThickness", { Text = "Line Core Width", Default = 2, Min = 1, Max = 6, Rounding = 1, Callback = function(v) tbl2.noksLineThickness = v end })
    NoksLine:AddToggle("NoksLineOutline", { Text = "Enable Line Shadow", Default = false, Callback = function(v) tbl2.noksLineOutline = v end }):AddColorPicker("NoksLineOutlineColor", { Default = Color3.fromRGB(0, 0, 0), Title = "Line Shadow Color", Callback = function(c) tbl2.noksLineOutlineColor = c end })
    NoksLine:AddSlider("NoksLineStrokeThickness", { Text = "Line Shadow Thickness", Default = 1, Min = 1, Max = 4, Rounding = 1, Callback = function(v) tbl2.noksLineStrokeThickness = v end })
    NoksLine:AddDropdown("NoksLineOrigin", { Text = "Line Origin Position", Default = "Bottom", Values = { "Top", "Center", "Bottom", "Mouse" }, Callback = function(v) tbl2.noksLineOrigin = v end })
    NoksLine:AddDropdown("NoksLineAttachment", { Text = "Line Target Position", Default = "Bottom", Values = { "Top", "Center", "Bottom" }, Callback = function(v) tbl2.noksLineAttachment = v end })

    local NoksFlags = Tabs.ESP:AddRightGroupbox("Indicators & Flags")
    NoksFlags:AddToggle("NoksHealthBarEnable", { Text = "Enable Premium Health Bar", Default = false, Callback = function(v) tbl2.noksHealthBarEnable = v end })
    NoksFlags:AddSlider("NoksHealthBarWidth", { Text = "Health Bar Width", Default = 3, Min = 2, Max = 8, Rounding = 1, Callback = function(v) tbl2.noksHealthBarWidth = v end })
    NoksFlags:AddSlider("NoksHealthBarOffset", { Text = "Health Bar Offset", Default = 6, Min = 4, Max = 15, Rounding = 1, Callback = function(v) tbl2.noksHealthBarOffset = v end })
    NoksFlags:AddToggle("NoksHealthTextEnable", { Text = "Show Health Percentage Text", Default = false, Callback = function(v) tbl2.noksHealthTextEnable = v end })
    local NoksHealthGrad = NoksFlags:AddToggle("NoksHealthGradient", { Text = "Enable 3-Color Gradient", Default = false, Callback = function(v) tbl2.noksHealthGradient = v end })
    NoksHealthGrad:AddColorPicker("NoksHealthGrad1", { Default = Color3.fromRGB(50, 255, 100), Title = "High Health", Callback = function(c) tbl2.noksHealthGrad1 = c end })
    NoksHealthGrad:AddColorPicker("NoksHealthGrad2", { Default = Color3.fromRGB(255, 220, 50), Title = "Mid Health", Callback = function(c) tbl2.noksHealthGrad2 = c end })
    NoksHealthGrad:AddColorPicker("NoksHealthGrad3", { Default = Color3.fromRGB(255, 50, 50), Title = "Low Health", Callback = function(c) tbl2.noksHealthGrad3 = c end })
    NoksFlags:AddToggle("NoksDistanceEnable", { Text = "Show Distance (Studs)", Default = false, Callback = function(v) tbl2.noksDistanceEnable = v end }):AddColorPicker("NoksDistanceColor", { Default = Color3.fromRGB(240, 240, 240), Title = "Distance Color", Callback = function(c) tbl2.noksDistanceColor = c end })
    NoksFlags:AddSlider("NoksMaxDistance", { Text = "Max Render Distance", Default = 2000, Min = 100, Max = 5000, Rounding = 1, Callback = function(v) tbl2.noksMaxDistance = v end })
    NoksFlags:AddToggle("NoksFlagsEnable", { Text = "Enable Premium Flags ESP", Default = false, Callback = function(v) tbl2.noksFlagsEnable = v end })
    NoksFlags:AddSlider("NoksFlagSpacing", { Text = "Flag Spacing", Default = 2, Min = 0, Max = 10, Rounding = 1, Callback = function(v) tbl2.noksFlagSpacing = v end })
    NoksFlags:AddSlider("NoksFlagTextSize", { Text = "Flag Text Size", Default = 9, Min = 6, Max = 16, Rounding = 1, Callback = function(v) tbl2.noksFlagTextSize = v end })
    NoksFlags:AddToggle("NoksFlagNameEnable", { Text = "Show UserID Flag", Default = true, Callback = function(v) tbl2.noksFlagNameEnable = v end }):AddColorPicker("NoksFlagNameColor", { Default = Color3.fromRGB(220, 220, 220), Title = "UserID Color", Callback = function(c) tbl2.noksFlagNameColor = c end })
    NoksFlags:AddToggle("NoksFlagWeaponEnable", { Text = "Show Weapon Flag", Default = true, Callback = function(v) tbl2.noksFlagWeaponEnable = v end }):AddColorPicker("NoksFlagWeaponColor", { Default = Color3.fromRGB(200, 200, 200), Title = "Weapon Color", Callback = function(c) tbl2.noksFlagWeaponColor = c end })
    NoksFlags:AddToggle("NoksFlagStateEnable", { Text = "Show State Flag", Default = true, Callback = function(v) tbl2.noksFlagStateEnable = v end }):AddColorPicker("NoksFlagStateColor", { Default = Color3.fromRGB(255, 150, 50), Title = "State Color", Callback = function(c) tbl2.noksFlagStateColor = c end })

    local NoksFill = Tabs.ESP:AddRightGroupbox("Box Internal Fill")
    NoksFill:AddToggle("NoksBoxFill", { Text = "Use Translucent Fill", Default = false, Callback = function(v) tbl2.noksBoxFill = v end })
    local NoksGradFill = NoksFill:AddToggle("NoksGradientFill", { Text = "Use Gradient Fill", Default = false, Callback = function(v) tbl2.noksGradientFill = v end })
    NoksGradFill:AddColorPicker("NoksGradientColor1", { Default = Color3.fromRGB(140, 90, 255), Title = "Gradient Node 1", Callback = function(c) tbl2.noksGradientColor1 = c end })
    NoksGradFill:AddColorPicker("NoksGradientColor2", { Default = Color3.fromRGB(0, 230, 255), Title = "Gradient Node 2", Callback = function(c) tbl2.noksGradientColor2 = c end })
    NoksFill:AddSlider("NoksBoxFillOpacity1", { Text = "Node 1 Opacity (%)", Default = 25, Min = 0, Max = 100, Rounding = 1, Callback = function(v) tbl2.noksBoxFillOpacity1 = v end })
    NoksFill:AddSlider("NoksBoxFillOpacity2", { Text = "Node 2 Opacity (%)", Default = 5, Min = 0, Max = 100, Rounding = 1, Callback = function(v) tbl2.noksBoxFillOpacity2 = v end })
    NoksFill:AddToggle("NoksGradientRotate", { Text = "Auto Rotate Spectrum", Default = false, Callback = function(v) tbl2.noksGradientRotate = v end })
    NoksFill:AddSlider("NoksRotateSpeed", { Text = "Rotation Velocity", Default = 3, Min = 1, Max = 10, Rounding = 1, Callback = function(v) tbl2.noksRotateSpeed = v end })

    local NoksCinematic = Tabs.ESP:AddRightGroupbox("Cinematic Effects")
    NoksCinematic:AddToggle("NoksFadeOutEnable", { Text = "Player Death Fade Out", Default = false, Callback = function(v) tbl2.noksFadeOutEnable = v end })
    NoksCinematic:AddSlider("NoksFadeDuration", { Text = "Fade Out Speed (Seconds)", Default = 1.2, Min = 0.2, Max = 5, Rounding = 1, Callback = function(v) tbl2.noksFadeDuration = v end })

    local NoksChams = Tabs.ESP:AddRightGroupbox("Premium Glow Chams")
    local NoksChamsEnable = NoksChams:AddToggle("NoksChamsEnable", { Text = "Enable Character Chams", Default = false, Callback = function(v) tbl2.noksChamsEnable = v end })
    NoksChamsEnable:AddColorPicker("NoksChamsFillColor", { Default = Color3.fromRGB(140, 90, 255), Title = "Chams Fill", Callback = function(c) tbl2.noksChamsFillColor = c end })
    NoksChamsEnable:AddColorPicker("NoksChamsOutlineColor", { Default = Color3.fromRGB(255, 255, 255), Title = "Chams Outline", Callback = function(c) tbl2.noksChamsOutlineColor = c end })
    NoksChams:AddSlider("NoksChamsFillTransparency", { Text = "Fill Opacity (%)", Default = 50, Min = 0, Max = 100, Rounding = 1, Callback = function(v) tbl2.noksChamsFillTransparency = v end })
    NoksChams:AddSlider("NoksChamsOutlineTransparency", { Text = "Outline Opacity (%)", Default = 0, Min = 0, Max = 100, Rounding = 1, Callback = function(v) tbl2.noksChamsOutlineTransparency = v end })
    NoksChams:AddDropdown("NoksChamsOcclusion", { Text = "Occlusion Mode", Default = "Always See", Values = { "Always See", "Behind Wall Only" }, Callback = function(v) tbl2.noksChamsOcclusion = v end })

    local NoksSkel = Tabs.ESP:AddRightGroupbox("Skeleton Settings")
    NoksSkel:AddToggle("NoksSkeletonEnable", { Text = "Enable Skeleton ESP", Default = false, Callback = function(v) tbl2.noksSkeletonEnable = v end })
    NoksSkel:AddSlider("NoksSkeletonThickness", { Text = "Bone Width", Default = 2, Min = 1, Max = 5, Rounding = 1, Callback = function(v) tbl2.noksSkeletonThickness = v end })
    local NoksSkelGrad = NoksSkel:AddToggle("NoksSkeletonGradient", { Text = "Enable Bone Gradient", Default = false, Callback = function(v) tbl2.noksSkeletonGradient = v end })
    NoksSkelGrad:AddColorPicker("NoksSkeletonColor1", { Default = Color3.fromRGB(180, 140, 255), Title = "Bone Color 1", Callback = function(c) tbl2.noksSkeletonColor1 = c end })
    NoksSkelGrad:AddColorPicker("NoksSkeletonColor2", { Default = Color3.fromRGB(0, 230, 255), Title = "Bone Color 2", Callback = function(c) tbl2.noksSkeletonColor2 = c end })
    NoksSkel:AddToggle("NoksSkeletonScroll", { Text = "Chroma Wave Animation", Default = false, Callback = function(v) tbl2.noksSkeletonScroll = v end })
    NoksSkel:AddSlider("NoksSkeletonScrollSpeed", { Text = "Wave Speed", Default = 4, Min = 1, Max = 10, Rounding = 1, Callback = function(v) tbl2.noksSkeletonScrollSpeed = v end })

    local LocationESP = Tabs.ESP:AddLeftGroupbox("Location Detector ESP (PCLD)")
    LocationESP:AddToggle("LocationDetector", { Text = "Enable PCLD ESP", Default = false,
        Callback = function(enabled)
            tbl2.playerLocationVisualEnabled = enabled
            if enabled then
                locationESPActive = setupPlayerLocationVisual()
            elseif locationESPActive then
                locationESPActive()
                locationESPActive = nil
            end
            _NOTIFY(enabled and "PCLD ESP ON" or "PCLD ESP OFF", 3)
        end }):AddColorPicker("PCLD_Color", { Default = Color3.fromRGB(160, 0, 255), Title = "PCLD Color", Callback = function(c) tbl2.locationESPColor = c end })
    local PCLDGrad = LocationESP:AddToggle("PCLD_GradientEnabled", { Text = "Enable Gradient Color", Default = false, Callback = function(v) tbl2.locationESPGradientEnabled = v end })
    PCLDGrad:AddColorPicker("PCLD_GradientColor1", { Default = Color3.fromRGB(160, 0, 255), Title = "Gradient Color 1", Callback = function(c) tbl2.locationESPGradientColor1 = c end })
    PCLDGrad:AddColorPicker("PCLD_GradientColor2", { Default = Color3.fromRGB(0, 230, 255), Title = "Gradient Color 2", Callback = function(c) tbl2.locationESPGradientColor2 = c end })
    LocationESP:AddSlider("PCLD_GradientSpeed", { Text = "Gradient Cycle Speed", Default = 1, Min = 0.1, Max = 5, Rounding = 1, Callback = function(v) tbl2.locationESPGradientSpeed = v end })
    LocationESP:AddSlider("PCLD_UIGradientAngle", { Text = "Gradient Angle", Default = 0, Min = 0, Max = 360, Rounding = 1, Callback = function(v) tbl2.locationESPUIGradientAngle = v end })
    LocationESP:AddToggle("PCLD_UIGradientAutoRotate", { Text = "Gradient Auto Rotate", Default = false, Callback = function(v) tbl2.locationESPUIGradientAutoRotate = v end })
    LocationESP:AddSlider("PCLD_UIGradientAutoSpeed", { Text = "Auto Rotate Speed", Default = 20, Min = 1, Max = 100, Rounding = 1, Callback = function(v) tbl2.locationESPUIGradientAutoSpeed = v end })
    LocationESP:AddToggle("PCLD_CornerEnabled", { Text = "Enable Corner Render", Default = true, Callback = function(v) tbl2.locationESPCornerEnabled = v end })
    LocationESP:AddSlider("PCLD_Thickness", { Text = "Corner Line Thickness", Default = 2, Min = 1, Max = 10, Rounding = 1, Callback = function(v) tbl2.locationESPThickness = v end })
    LocationESP:AddSlider("PCLD_CornerRoundness", { Text = "Corner Roundness", Default = 0, Min = 0, Max = 50, Rounding = 1, Callback = function(v) tbl2.locationESPCornerRoundness = v end })
    LocationESP:AddSlider("PCLD_Length", { Text = "Corner Line Length", Default = 12, Min = 5, Max = 50, Rounding = 1, Callback = function(v) tbl2.locationESPLength = v end })
    LocationESP:AddSlider("PCLD_RotationSpeed", { Text = "Rotation Speed", Default = 90, Min = 0, Max = 360, Rounding = 1, Callback = function(v) tbl2.locationESPRotationSpeed = v end })
    LocationESP:AddSlider("PCLD_ExpandSpeed", { Text = "Breathing Expand Speed", Default = 3, Min = 0, Max = 10, Rounding = 1, Callback = function(v) tbl2.locationESPExpandSpeed = v end })
    LocationESP:AddSlider("PCLD_MinRadius", { Text = "Min Pulse Radius", Default = 15, Min = 5, Max = 100, Rounding = 1, Callback = function(v) tbl2.locationESPMinRadius = v end })
    LocationESP:AddSlider("PCLD_MaxRadius", { Text = "Max Pulse Radius", Default = 35, Min = 5, Max = 150, Rounding = 1, Callback = function(v) tbl2.locationESPMaxRadius = v end })
    LocationESP:AddToggle("PCLD_CornerOutline", { Text = "Corner Outline", Default = false, Callback = function(v) tbl2.locationESPCornerOutlineEnabled = v end }):AddColorPicker("PCLD_CornerOutlineColor", { Default = Color3.fromRGB(0, 0, 0), Title = "Corner Outline Color", Callback = function(c) tbl2.locationESPCornerOutlineColor = c end })
    LocationESP:AddSlider("PCLD_CornerOutlineThick", { Text = "Corner Outline Thickness", Default = 1, Min = 1, Max = 5, Rounding = 1, Callback = function(v) tbl2.locationESPCornerOutlineThickness = v end })
    LocationESP:AddToggle("PCLD_SmoothingEnabled", { Text = "Enable Smooth Lerp", Default = true, Callback = function(v) tbl2.locationESPSmoothingEnabled = v end })
    LocationESP:AddSlider("PCLD_SmoothingSpeed", { Text = "Smoothing Responsiveness", Default = 15, Min = 1, Max = 50, Rounding = 1, Callback = function(v) tbl2.locationESPSmoothingSpeed = v end })
    LocationESP:AddToggle("PCLD_PartEnabled", { Text = "Enable 3D Part Box", Default = false, Callback = function(v) tbl2.locationESPPartEnabled = v end }):AddColorPicker("PCLD_PartColor", { Default = Color3.fromRGB(160, 0, 255), Title = "Part Box Color", Callback = function(c) tbl2.locationESPPartColor = c end })
    LocationESP:AddSlider("PCLD_PartTransparency", { Text = "Part Transparency", Default = 70, Min = 0, Max = 100, Rounding = 1, Callback = function(v) tbl2.locationESPPartTransparency = v / 100 end })
    LocationESP:AddDropdown("PCLD_PartMaterial", { Text = "Part Material", Default = "Neon", Values = { "Neon", "ForceField", "Glass", "SmoothPlastic", "Metal", "Wood" }, Callback = function(v) tbl2.locationESPPartMaterial = v end })
    LocationESP:AddToggle("PCLD_BoxOutline", { Text = "Part Box Outline", Default = false, Callback = function(v) tbl2.locationESPBoxOutlineEnabled = v end }):AddColorPicker("PCLD_BoxOutlineColor", { Default = Color3.fromRGB(255, 255, 255), Title = "Box Outline Color", Callback = function(c) tbl2.locationESPBoxOutlineColor = c end })
    LocationESP:AddSlider("PCLD_BoxOutlineThick", { Text = "Box Outline Thickness", Default = 5, Min = 1, Max = 100, Rounding = 1, Callback = function(v) tbl2.locationESPBoxOutlineThickness = v / 100 end })
    LocationESP:AddToggle("PCLD_TrailEnabled", { Text = "Enable Box Trail", Default = false, Callback = function(v) tbl2.locationESPTrailEnabled = v end }):AddColorPicker("PCLD_TrailColor", { Default = Color3.fromRGB(160, 0, 255), Title = "Trail Color", Callback = function(c) tbl2.locationESPTrailColor = c end })
    LocationESP:AddSlider("PCLD_TrailLifetime", { Text = "Trail Lifetime", Default = 0.5, Min = 0.1, Max = 5, Rounding = 1, Callback = function(v) tbl2.locationESPTrailLifetime = v end })
    local PCLDGlow = LocationESP:AddToggle("PCLD_GlowEnabled", { Text = "Enable Glow", Default = false, Callback = function(v) tbl2.locationESPGlowEnabled = v end })
    PCLDGlow:AddColorPicker("PCLD_GlowColor1", { Default = Color3.fromRGB(160, 0, 255), Title = "Glow Color 1", Callback = function(c) tbl2.locationESPGlowColor1 = c end })
    PCLDGlow:AddColorPicker("PCLD_GlowColor2", { Default = Color3.fromRGB(0, 230, 255), Title = "Glow Color 2", Callback = function(c) tbl2.locationESPGlowColor2 = c end })
    LocationESP:AddSlider("PCLD_GlowTransparency", { Text = "Glow Transparency", Default = 50, Min = 0, Max = 100, Rounding = 1, Callback = function(v) tbl2.locationESPGlowTransparency = v / 100 end })
    LocationESP:AddSlider("PCLD_GlowSize", { Text = "Glow Size", Default = 20, Min = 0, Max = 100, Rounding = 1, Callback = function(v) tbl2.locationESPGlowSize = v end })
end

-- ============================================================
-- 無限ジャンプ
-- ============================================================
UserInputService.JumpRequest:Connect(function()
    if tbl2.characterInfJumpEnabled or tbl2.infjump then
        pcall(function()
            local character = getChar()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    end
end)

-- ============================================================
-- 初期化完了
-- ============================================================
_NOTIFY("strawberry maple sahur loaded!", 4)
