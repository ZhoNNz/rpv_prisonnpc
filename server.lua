ESX = nil
aldi = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("rpv_prisonnpc:BuyItem")
AddEventHandler("rpv_prisonnpc:BuyItem", function(amountToBuy,totalBuyPrice,itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if xPlayer.getMoney() >= totalBuyPrice then
		xPlayer.removeMoney(totalBuyPrice)
		xPlayer.addInventoryItem(itemName, amountToBuy)
        -- TriggerClientEvent("esx:showNotification",source,"You paid ~g~$"..totalBuyPrice.."~s~ for "..amountToBuy.."x ~y~"..itemLabel.."~s~")
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = itemLabel .. amountToBuy .. 'x' ..totalBuyPrice.. '$ Ödedin'})
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli miktarda paran yok!'})
	end
end)

RegisterServerEvent("rpv_prisonnpc:LevelUpdate")
AddEventHandler("rpv_prisonnpc:LevelUpdate", function(point)
    local identifier = GetPlayerIdentifiers(source)[1]

    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT prisonpoint FROM prisonlevel WHERE identifier = @identifier', {
        ['@identifier'] =  xPlayer.identifier
    }, function(prisonpoint)
       local originalpoint =  tonumber(prisonpoint[1].prisonpoint)
       local updatedpoint = originalpoint + point
       if aldi == true then
       MySQL.Async.execute('UPDATE prisonlevel SET prisonpoint=@pointupdate WHERE identifier=@identifier ',
       {
           ['@identifier']   = xPlayer.identifier,
           ['@pointupdate']   = updatedpoint
          
       }, function(prisonpoint2)
        print(prisonpoint2)
       end)
    end
    end)   
end)


ESX.RegisterServerCallback('rpv_prisonnpc:GetLevel', function(source, cb)
    local _source = source
    
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifiers = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchAll('SELECT prisonpoint FROM prisonlevel WHERE identifier = @identifier', {
        ['@identifier'] =  xPlayer.identifier
    }, function(prisonpoint)
        if prisonpoint[1] ~= nil then
        cb(prisonpoint[1].prisonpoint)
        else
            MySQL.Async.execute('INSERT INTO prisonlevel (`identifier`,`prisonpoint`) VALUES (@identifier, 1)', {
                ['@identifier'] = xPlayer.identifier
            }, function(rowsChanged)
                TriggerClientEvent('esx:showNotification', source, '~g~Menüyü Tekrar Aç!')
            end)
        end
	end)
end)



RegisterServerEvent("rpv_prisonnpc:maymuncuk")
AddEventHandler("rpv_prisonnpc:maymuncuk", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.getMoney() >= 300 then
        xPlayer.removeMoney(300)
        aldi = true
		xPlayer.addInventoryItem('lockpick', 1)        -- TriggerClientEvent("esx:showNotification",source,"You paid ~g~$"..totalBuyPrice.."~s~ for "..amountToBuy.."x ~y~"..itemLabel.."~s~")
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '300$ a Maymuncuk aldın' })
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'STATUS :: Kişi sana olan güveni 1+'})
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli miktarda paran yok!'})		
	end
end)



RegisterServerEvent("rpv_prisonnpc:telefon")
AddEventHandler("rpv_prisonnpc:telefon", function()
	local xPlayer = ESX.GetPlayerFromId(source)	
	if xPlayer.getMoney() >= 400 then
        xPlayer.removeMoney(400)
        aldi = true
		xPlayer.addInventoryItem('phone', 1)        -- TriggerClientEvent("esx:showNotification",source,"You paid ~g~$"..totalBuyPrice.."~s~ for "..amountToBuy.."x ~y~"..itemLabel.."~s~")
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '400$ a Telefon aldın' })
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'STATUS :: Kişi sana olan güveni 1+'})
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli miktarda paran yok!'})			
	end
end)


RegisterServerEvent("rpv_prisonnpc:telsiz")
AddEventHandler("rpv_prisonnpc:telsiz", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.getMoney() >= 400 then
        xPlayer.removeMoney(400)
        aldi = true
		xPlayer.addInventoryItem('radio', 1)        -- TriggerClientEvent("esx:showNotification",source,"You paid ~g~$"..totalBuyPrice.."~s~ for "..amountToBuy.."x ~y~"..itemLabel.."~s~")
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '400$ a Telsiz aldın' })
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'STATUS :: Kişi sana olan güveni 1+'})
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli miktarda paran yok!'})			
	end
end)


RegisterServerEvent("rpv_prisonnpc:bıçak")
AddEventHandler("rpv_prisonnpc:bıçak", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= 450 then
        xPlayer.removeMoney(450)
        
        aldi = true
		xPlayer.addInventoryItem('WEAPON_KNIFE', 1)        -- TriggerClientEvent("esx:showNotification",source,"You paid ~g~$"..totalBuyPrice.."~s~ for "..amountToBuy.."x ~y~"..itemLabel.."~s~")
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '450$ a Bıçak aldın' })
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'STATUS :: Kişi sana olan güveni 2+'})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'KİŞİ :: 7 dakikada bir gardiyanlar geziyor bıçağı saklamayı unutma '})
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli miktarda paran yok!'})			
	end
end)
