local alwaysCheck = true

if alwaysCheck then
	CreateThread(function()
		while true do
			local plateList = {}
			local allVeh = GetAllVehicles()
			for i=1, #allVeh do
				if DoesEntityExist(allVeh[i]) then
					local plate = GetVehicleNumberPlateText(allVeh[i])
					local model = GetEntityModel(allVeh[i])
					if not plateList[plate] then 
						plateList[plate] = model
					elseif model == plateList[plate] then
						DeleteEntity(allVeh[i])
					end
				end
			end
			Wait(5000)
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
