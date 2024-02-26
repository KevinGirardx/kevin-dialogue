local Camera = nil

--- NUI Callbacks
---
RegisterNUICallback('closedialogue', function (data, cb)
    cb({})
    DestroyCamera()
end)

RegisterNUICallback('fireeventtrigger', function (data, cb)
    if data.type == nil then data.type = 'client' end
    if data.type == 'client' then
        TriggerEvent(data.event)
    elseif data.type == 'server' then
        TriggerServerEvent(data.event)
    elseif data.type == 'command' then
        ExecuteCommand(data.event)
    end

    cb('ok')
end)
---
---

function DoCameraPan(entity)
    if not entity then return end
    local coords = GetEntityCoords(entity)
    local entityHeading = GetEntityHeading(entity)
    local pacesInfront = GetEntityForwardVector(entity)
    local offset = vector3(pacesInfront.x * 0.8, pacesInfront.y * 1.5, pacesInfront.z * 1.5)
    Camera = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', coords.x + offset.x, coords.y + offset.y, coords.z + 0.2 , vector3(0.0, 0.0, entityHeading + 165), 70.0)
    SetCamActive(Camera, true)
    RenderScriptCams(true, true, 1000, false, false)
end

function DestroyCamera()
    if not Camera then return end
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(Camera, false)
    DestroyCam(Camera, true)
    DestroyAllCams(true)

    SetNuiFocus(false, false)
end

function SendDialogue(entity, data)
    if not entity then print('No entity specified for dialogue') return end
    if not data then print('No data specified for dialogue') return end
    if data.buttons == nil then print('No buttons specified for dialogue') return end
    data.menuId = data.menuId or 'default_menu'
    data.pedName = data.pedName or 'Unknown'
    data.dialogueName = data.dialogueName
    data.reputation = data.reputation or '0'
    data.dialogue = data.dialogue or 'Hello how can I help you?'

    if not Camera then DoCameraPan(entity) end
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'senddialogue',
        menuId = data.menuId,
        pedName = data.pedName,
        dialogueName = data.dialogueName,
        reputation = data.reputation,
        dialogue = data.dialogue,
        buttons = data.buttons,
    })
end

function UpdateButtons(data)
    if data.buttons == nil then print('No buttons specified for dialogue') return end
    SendNUIMessage({
        action = 'updatebuttons',
        buttons = data.buttons,
    })
end

function CloseDialogue()
    SendNUIMessage({
        action = 'closedialogue',
    })
    DestroyCamera()
end

exports('SendDialogue', SendDialogue)
exports('UpdateButtons', UpdateButtons)
exports('CloseDialogue', CloseDialogue)


