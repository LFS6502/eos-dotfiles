--[[
    Explosion objects can be reused multiple times by calling the Explode()
    method.
]]

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = require(ReplicatedStorage.Services.SoundService)
local LuanoidService = require(ReplicatedStorage.Services.LuanoidService)

local Terrain = workspace:FindFirstChildWhichIsA("Terrain")

local Adornee = require(ReplicatedStorage.Libraries.Adornee)
local Promise = require(ReplicatedStorage.Libraries.Promise)
local RbxUtils = require(ReplicatedStorage.Libraries.RbxUtils)
local RaycastUtils = RbxUtils.Raycast

local OSModules = require(script.Parent.Parent.OSModules)

local EXPLOSION_SOUNDS = {
    "rbxassetid://456319028",
    "rbxassetid://456319085",
    "rbxassetid://456319118",
}
local HITSCAN_CONE_RADIUS = 6
local NUM_RAYS = 512

local Explosion = OSModules.Class() do
    function Explosion:init()
        self:wrapinstance(ReplicatedStorage.Assets.Effects.Misc.Explosion:Clone(), {
            "Position",
            "Size",
        })

        self._debug = false

        -- Position attribute is simply for ease of access
        self.Position = Vector3.new()
        self.Size = 1

        self.Hit = OSModules.Event()
        self.Exploded = OSModules.Event()
        self.Finished = OSModules.Event()
        self.Active = false
    end

    function Explosion:Explode(explosionParams)
        if not self.Active then
            local pos = explosionParams.Position or Vector3.new()
            local size = explosionParams.Size or 1

            self.Position = pos
            self.Size = size

            return Promise.new(function(resolve)
                self.Exploded:Fire()

                self.Active = true
                local fx = self.__baseinstance
                fx.WorldPosition = pos
                fx.Parent = Terrain

                SoundService:Play3DSound(EXPLOSION_SOUNDS[math.random(1, #EXPLOSION_SOUNDS)], pos, {
                    PlaybackSpeed = 1 + ((math.random() - 0.5) / 10),
                    Volume = 3,
                })

                fx.Fire.Size = NumberSequence.new(size * 10)
                fx.Fire.Speed = NumberRange.new(size * 20)
                fx.SittingSmoke.Size = NumberSequence.new(size * 10)
                fx.SittingSmoke.Speed = NumberRange.new(size * 10)
                fx.SphereSmoke.Size = NumberSequence.new(size * 10)
                fx.SphereSmoke.Speed = NumberRange.new(size * 100)
                fx.StandingSmoke.Size = NumberSequence.new(size * 3)
                fx.StandingSmoke.Speed = NumberRange.new(size * 20, size * 50)
                fx.PointLight.Range = size * 30
                fx.Wave.Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 150 * size),
                })
                fx.Wave:Emit(1)
                fx.SphereSmoke:Emit(20 * size)
                fx.StandingSmoke:Emit(10 * size)
                fx.SittingSmoke:Emit(20 * size)
                fx.Fire:Emit(50 * size)
                fx.PointLight.Enabled = true
                task.wait(0.1)
                fx.PointLight.Enabled = false
                task.wait(5)
                fx.Parent = nil
                self.Active = false

                --[[
                    Set to false for explosions that should not deal damage, useful
                    for cinematic explosions
                ]]
                if explosionParams.Hitscan == true then
                    -- TODO: Implement EntityService
                    for _,luanoid in ipairs(LuanoidService:GetLuanoids()) do
                        local rootPart = luanoid.RootPart
                        local rootPos = rootPart.Position

                        local distance = (rootPos - pos).Magnitude
                        if distance < self:GetBlastRadius() then
                            if self._debug then
                                Debris:AddItem(Adornee.Cone.new(workspace.CurrentCamera, {
                                    Color3 = Color3.new(math.random(), math.random(), math.random()),
                                    Transparency = 0.85,
                                    Adornee = Terrain,
                                    Height = distance,
                                    Radius = HITSCAN_CONE_RADIUS,
                                    CFrame = CFrame.lookAt(rootPos, pos),
                                }), 1)
                            end

                            local maxAngle = math.atan2(HITSCAN_CONE_RADIUS, distance)
                            local numRays = math.floor((math.pi * HITSCAN_CONE_RADIUS^2) / (4 * math.pi * distance^2) * NUM_RAYS)
                            local raycastPromises = {}

                            for _ = 1, numRays do
                                local lookAt = CFrame.lookAt(pos, rootPos) * CFrame.Angles(
                                    0,
                                    (math.random() - 0.5) * maxAngle,
                                    0
                                ) * CFrame.Angles(
                                    (math.random() - 0.5) * maxAngle,
                                    0,
                                    0
                                )

                                table.insert(raycastPromises, RaycastUtils.castCollideOnly(pos, lookAt.LookVector * (distance + HITSCAN_CONE_RADIUS)))

                                if self._debug then
                                    Debris:AddItem(Adornee.Cylinder.new(workspace.CurrentCamera, {
                                        Color3 = Color3.new(math.random(), math.random(), math.random()),
                                        Adornee = Terrain,
                                        Start = lookAt.Position,
                                        Radius = 0.1,
                                        End = pos + lookAt.LookVector * (distance + HITSCAN_CONE_RADIUS),
                                    }), 1)
                                end
                            end
                        end
                    end
                end

                self.Finished:Fire()

                -- TODO: Resolve with hits
                resolve()
            end)
        else
            return Promise.reject("Explosion already active")
        end
    end

    function Explosion:GetBlastRadius()
        return self.Size * 15
    end

    function Explosion:GetFireballRadius()
        return self.Size * 20
    end

    function Explosion:GetBlastWaveRadius()
        return self.Size * 150
    end

    function Explosion:DEBUG(enabled)
        self._debug = enabled
    end
end

return Explosion