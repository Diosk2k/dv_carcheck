AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('Ressource ' .. resourceName .. ' started!')
end)

if alwaysCheck then
    Citizen.CreateThread(function()
        while true do
            local plateList = {}
            local allVeh = GetAllVehicles()
            for i=1, #allVeh do
                local vehicle = allVeh[i]
                if DoesEntityExist(vehicle) then
                    local plate = GetVehicleNumberPlateText(vehicle)
                    local model = GetEntityModel(vehicle)
                    if not plateList[plate] then 
                        plateList[plate] = model
                    elseif model == plateList[plate] then
                        DeleteEntity(vehicle)
                    end
                end
            end
            Citizen.Wait(2000)
        end
    end)
else
    AddEventHandler("checkifdouble", function(entity)
        if DoesEntityExist(entity) and GetEntityType(entity) == 2 then
            local myVehiclePlate = GetVehicleNumberPlateText(entity)
            local myVehicleModel = GetEntityModel(entity)
            local allVeh = GetAllVehicles()
            for i=1, #allVeh do
                local veh = allVeh[i]
                if DoesEntityExist(veh) then
                    if myVehiclePlate == GetVehicleNumberPlateText(veh) and myVehicleModel == GetEntityModel(veh) and entity ~= veh then
                        CancelEvent()
                        break
                    end
                end
            end
        end
    end)
end
