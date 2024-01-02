-- 
-- NUI Callbacks
-- 
RegisterNUICallback('removedialogue', function (data, cb)
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
