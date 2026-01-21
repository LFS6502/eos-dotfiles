local CAMERA_SHOULDER_OFFSET = 3

local CameraHandler = {} do
    function CameraHandler:Start(client)
        local RunService = client.Services.RunService
        local LuanoidService = client.Services.LuanoidService
        local ExplosionService = client.Services.ExplosionService

        local LocalPlayer = require(client.Services.Shared.Classes.LocalPlayer)

        local Context = require(client.Libraries.Context)
        local Enum = require(client.Libraries.Enum)

        local Mouse = client.Mouse

        self.Client = client
        do
            self.Camera = client.Camera

            do
                -- Camera control handling
                local CameraContext = Context:WaitForContext("Camera")
                local CameraMode = Enum.CameraMode

                local cameraDistances = {0, 10, 20}
                local currentViewNum = 2

                CameraContext["Cycle View"].ActionBegin:Connect(function()
                    currentViewNum += 1
                    if currentViewNum > #cameraDistances then
                        currentViewNum = 1
                    end

                    local cameraDistance = cameraDistances[currentViewNum]
                    self.Camera:SetCameraMode(CameraMode.Default)
                    local offset = self.Camera.Offset
                    self.Camera.Offset = Vector3.new(offset.X, offset.Y, cameraDistance)

                    local luanoid = LuanoidService:GetLocalLuanoid()
                    if luanoid then
                        if cameraDistance > 0 then
                            luanoid:SetLocalTransparencyModifier(0)
                        else
                            luanoid:SetLocalTransparencyModifier(1)
                        end
                    end
                end)

                LocalPlayer.LuanoidAdded:Connect(function(luanoid)
                    local cameraDistance = cameraDistances[currentViewNum]
                    if cameraDistance > 0 then
                        luanoid:SetLocalTransparencyModifier(0)
                    else
                        luanoid:SetLocalTransparencyModifier(1)
                    end
                end)

                CameraContext["Free Look"].ActionBegin:Connect(function()
                    Mouse.Behavior = Enum.MouseBehavior.Default
                    Mouse.IconEnabled = true
                end)

                CameraContext["Free Look"].ActionEnd:Connect(function()
                    Mouse.Behavior = Enum.MouseBehavior.LockCenter
                    Mouse.IconEnabled = false
                end)

                CameraContext["Change Shoulder"].ActionBegin:Connect(function()
                    local offset = self.Camera.Offset

                    self.Camera.Offset = offset.X == CAMERA_SHOULDER_OFFSET
                    and Vector3.new(-CAMERA_SHOULDER_OFFSET, offset.Y, offset.Z)
                    or Vector3.new(CAMERA_SHOULDER_OFFSET, offset.Y, offset.Z)
                end)

                Mouse.Behavior = Enum.MouseBehavior.LockCenter
                Mouse.IconEnabled = false
                RunService.RenderStepped:Connect(function()
                    self.Camera.Delta = Mouse:GetDelta()
                end)

                self.Camera.Offset = Vector3.new(CAMERA_SHOULDER_OFFSET, 1.75, 10)
            end

            do
                -- Camera shaking from explosions
                ExplosionService.Exploded:Connect(function(explosion)
                    local luanoid = LuanoidService:GetLocalLuanoid()
                    if luanoid then
                        local distance = (explosion.Position - luanoid.RootPart.Position).Magnitude
                        local blastWaveRadius = explosion:GetBlastWaveRadius()
                        if distance < blastWaveRadius then
                            local shakeScale = (blastWaveRadius - distance) / blastWaveRadius * explosion.Size
                            for _ = 1, math.random(1, 3) do
                                self.Camera:ImpulseOrientation(Vector3.new(
                                    0,
                                    math.random(-100, 100) * shakeScale,
                                    math.random(-100, 100) * shakeScale
                                ))
                                task.wait(math.random())
                            end
                        end
                    end
                end)
            end
        end
    end
end

return CameraHandler