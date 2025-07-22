local selectedEntity = nil
local displayInfo = false

RegisterCommand("selectprop", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local allObjects = lib.getNearbyObjects(coords, 1)

    print(json.encode(allObjects, { indent = true }))
    for _, object in ipairs(allObjects) do
        if DoesEntityExist(object.object) then
            selectedEntity = object.object
            displayInfo = true
            print("Entity Hash: " .. GetEntityModel(selectedEntity))
        end
    end
end)

-- Dessin d'une bounding box (simplifiée)
function DrawEntityBoundingBox(entity, r, g, b, a)
    local min, max = GetModelDimensions(GetEntityModel(entity))
    local pos = GetEntityCoords(entity)
    local forward = GetEntityForwardVector(entity)
    local right = GetEntityRightVector(entity)
    local up = GetEntityUpVector(entity)

    for i = 0, 1 do
        for j = 0, 1 do
            for k = 0, 1 do
                local offset = vec3(
                    i == 0 and min.x or max.x,
                    j == 0 and min.y or max.y,
                    k == 0 and min.z or max.z
                )
                local worldPos = pos + right * offset.x + forward * offset.y + up * offset.z
                DrawMarker(28, worldPos.x, worldPos.y, worldPos.z, 0, 0, 0, 0, 0, 0, 0.05, 0.05, 0.05, r, g, b, a, false,
                    false, 2, false, nil, nil, false)
            end
        end
    end
end

-- Affichage 3D du texte
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextCentre(true)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y, z)
end
