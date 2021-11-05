TriggerEvent("esx:getSharedObject", function(obj)   ESX = obj   end)

RegisterServerEvent("glowpawnshop:buy")
AddEventHandler("glowpawnshop:buy", function(item, price)
	local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local money = xPlayer.getMoney()
    if money >= price then 
            xPlayer.removeMoney(price)
            xPlayer.addInventoryItem(item, 1) 
             TriggerClientEvent("esx:showNotification", _src, "<C>Pawn Shop</C>\n~g~Achat effectué")
    else 
            TriggerClientEvent("esx:showNotification", _src, "<C>Pawn Shop</C>\n~r~Vous n\'avez pas asser d\'argent")
            end
        
end)
