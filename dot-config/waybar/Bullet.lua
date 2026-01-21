local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LuanoidService = require(ReplicatedStorage.Services.LuanoidService)
local VehicleService = require(ReplicatedStorage.Services.VehicleService)
local RbxUtils = require(ReplicatedStorage.Libraries.RbxUtils)
local VectorUtils = RbxUtils.Vector3
local CFrameUtils = RbxUtils.CFrame

local BulletAsset = ReplicatedStorage.Assets.Effects.Bullet

local OSModules = require(script.Parent.Parent.OSModules)
local Terrain = workspace:FindFirstChildWhichIsA("Terrain")
local DefaultParams = RaycastParams.new()

--[[
    This method is based off of RbxUtils.Raycast.castCollideOnly it has been
    modified to allow certain instances with CanCollide disabled to be detected
    such as characters and vehicles. The second return argument is if the
    target was a character or vehicle.
]]
-- TODO: Implement RbxUtils.castWithFilter
local function cast(origin: Vector3, dir: Vector3, params: RaycastParams?): (RaycastResult, boolean)
    local originalFilter = params.FilterDescendantsInstances
    local tempFilter = params.FilterDescendantsInstances

    repeat
        local result = workspace:Raycast(origin, dir, params)
        if result then
            if result.Instance.CanCollide then
                params.FilterDescendantsInstances = originalFilter
                if result.Instance.Parent:IsA("Model") and LuanoidService:GetLuanoidFromCharacter(result.Instance.Parent) then
                    -- Check if target was a luanoid
                    return result, true
                elseif result.Instance.Parent:IsA("Model") and VehicleService:GetVehicleFromModel(result.Instance.Parent) then
                    return result, true
                else
                    -- Target was not a luanoid or vehicle
                    return result, false
                end
            else
                if result.Instance.Parent:IsA("Model") and LuanoidService:GetLuanoidFromCharacter(result.Instance.Parent) then
                    -- Check if target was a luanoid
                    params.FilterDescendantsInstances = originalFilter
                    return result, true
                elseif result.Instance.Parent:IsA("Model") and VehicleService:GetVehicleFromModel(result.Instance.Parent) then
                    return result, true
                else
                    -- Add target to IgnoreList
                    table.insert(tempFilter, result.Instance)
                    params.FilterDescendantsInstances = tempFilter
                    origin = result.Position
                    dir = dir.Unit * (dir.Magnitude - (origin - result.Position).Magnitude)
                end
            end
        else
            params.FilterDescendantsInstances = originalFilter
            return nil, false
        end
    until not result
end

local Bullet = OSModules.Class() do
    function Bullet:init(origin: Vector3, velocity: Vector3): nil
        origin = origin or Vector3.new()
        velocity = velocity or Vector3.new()

        self.Tick = 0
        self.Velocity = velocity
        self.Size = 0.2
        self.RaycastParams = DefaultParams
        self.Gravity = workspace.Gravity

        local attachment0 = BulletAsset.Attachment0:Clone()
        local attachment1 = BulletAsset.Attachment1:Clone()

        attachment0.Trail.Attachment1 = attachment1

        self._attachment0 = attachment0
        self._attachment1 = attachment1

        local dir = velocity.Unit
        local a = VectorUtils.angle(dir, Vector3.new(dir.X, 0, dir.Z).Unit)
        if dir.Y < 0 then
            self._angle = -a
        else
            self._angle = a
        end

        self:SetOrigin(origin)
    end

    function Bullet:Destroy()
        self._attachment0:Destroy()
        self._attachment1:Destroy()
    end

    function Bullet:GetVelocityComponents(): (number, number)
        local vel = self.Velocity.Magnitude
        local a = self.Angle
        return vel * math.cos(a), vel * math.sin(a)
    end

    function Bullet:GetPositionAtTick(tick: number): Vector3
        return CFrameUtils.fromOriginDir(self.Origin, self.Velocity.Unit) * CFrame.new(0, 0, -self.Velocity.Magnitude * tick).Position
        + Vector3.new(0, self.Gravity * -tick^2 / 2, 0)
    end

    function Bullet:GetCFrameAtTick(tick: number): CFrame
        return CFrame.lookAt(self:GetPositionAtTick(tick), self:GetPositionAtTick(tick + 0.001/self.Velocity.Magnitude))
    end

    function Bullet:Forward(delta: number): RaycastResult
        self.Tick += delta

        local offset = self.Size / 2
        local cframe = self:GetCFrameAtTick(self.Tick)

        local raycastResult = cast(self.CFrame.Position, (cframe.Position - self.CFrame.Position), self.RaycastParams)

        self.CFrame = cframe
        self._attachment0.WorldCFrame = cframe * CFrame.new(0, offset, 0)
        self._attachment1.WorldCFrame = cframe * CFrame.new(0, -offset, 0)

        return raycastResult
    end

    function Bullet:SetTick(tick: number)
        self.Tick = tick

        local offset = self.Size / 2
        local cframe = self:GetCFrameAtTick(self.Tick)
        self.CFrame = cframe
        self._attachment0.WorldCFrame = cframe * CFrame.new(0, offset, 0)
        self._attachment1.WorldCFrame = cframe * CFrame.new(0, -offset, 0)

        return self
    end

    function Bullet:SetOrigin(origin)
        self.Origin = origin
        self.CFrame = CFrame.new(origin)
        self._attachment0.WorldPosition = origin
        self._attachment1.WorldPosition = origin
    end

    function Bullet:Enable()
        self._attachment0.Parent = Terrain
        self._attachment1.Parent = Terrain

        return self
    end

    function Bullet:Disable()
        self._attachment0.Parent = nil
        self._attachment1.Parent = nil

        return self
    end

    function Bullet:SetColor3(color3: Color3): nil
        self._attachment0.Trail.Color = ColorSequence.new(color3)
        self._attachment0.PointLight.Color = color3
    end
end

return Bullet