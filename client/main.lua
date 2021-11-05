
TriggerEvent("esx:getSharedObject", function(obj)   ESX = obj   end)

local pawnshopOpened = false
pawnshopmenu = RageUI.CreateMenu("Pawn Shop", "objets d'occasion", 10, 80)
pawnshopmenu.Closed = function()
    pawnshopOpened = false
    RageUI.CloseAll()
end

local OpenMenupawnshop = function(point)
    if pawnshopOpened then
        pawnshopOpened = false 
        RageUI.CloseAll()
        RageUI.Visible(pawnshopmenu, false)
        return
    else
        pawnshopOpened = true

        RageUI.Visible(pawnshopmenu, true)

        Citizen.CreateThread(function()
            while pawnshopOpened do
                 local pedcoord = GetEntityCoords(PlayerPedId())
                   if #(pedcoord - point.pos) < 1.5 then  
                        
                RageUI.IsVisible(pawnshopmenu, function()
                    
                    for k,v in pairs(point.object) do 
                               RageUI.Button(v.name, "Acheter "..v.name, {RightLabel = "~g~"..v.price.."$"}, true, {
                                	onSelected = function() 
                                    --    ESX.ShowNotification("<C>Pawn Shop</C>\nVous avez acheter "..v.name.." pour ~g~"..v.price.."$")
                                        TriggerServerEvent("glowpawnshop:buy", v.label, v.price)
                                end
                                }) 
                    end

                end, function() 
                end)
                 else       
                       pawnshopOpened = false
    RageUI.CloseAll()
                       end
                Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()

    while true do 
        local sleep = 500
        local pedcoord = GetEntityCoords(PlayerPedId())
        for k,v in pairs(config.shop) do   
            if #(pedcoord - v.pos) < 10 then 
                sleep = 0
                DrawMarker(23, v.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 170, 0, 0, 2, 0, nil, nil, 0)
                if #(pedcoord - v.pos) < 1.5 then 
                    Visual.Subtitle("<C>Appuyer sur ~g~E~s~ pour ouvrir</C>")
                    --ESX.ShowHelpNotification("Appuyer sur ~g~E~s~ pour ouvrir")
                    if IsControlJustPressed(0, 38) then 
                        OpenMenupawnshop(v)
                    end
                end
            end 
        end
        Wait(sleep)
    end

end)

CreateThread(function()
  blip = AddBlipForCoord(config.blip.x, config.blip.y, config.blip.z)
        SetBlipSprite(blip, config.blip.id)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, config.blip.scale)
        SetBlipColour(blip, config.blip.colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(config.blip.btitre)
        EndTextCommandSetBlipName(blip)      
        
        
    end)
