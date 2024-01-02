local QBCore = exports['qb-core']:GetCoreObject()

local Camera = nil
function DoCameraPan(data)
    local pos = GetEntityCoords(data.entity, true)
    local camX = pos.x
    local camY = pos.y + 4
    local camZ = pos.z + 1.3
    Camera = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', camX, camY, camZ, 0.0, 0.0, 0.0, 10.0, true, 2)
    PointCamAtEntity(Camera, data.entity, 0.0, 0.0, 0.5, true)
    RenderScriptCams(true, true, 1000, true, true)
end

function DestroyCamera()
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(Camera, false)
    DestroyCam(Camera, true)
    DestroyAllCams(true)

    SetNuiFocus(false, false)
end

function SendDialogue(data)
    DoCameraPan(data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'senddialogue',
        pedName = data.pedName,
        jobName = data.job,
        reputation = data.reputation,
        dialogue = data.dialogue,
        buttons = data.buttons,
    })
end

exports('SendDialogue', SendDialogue)