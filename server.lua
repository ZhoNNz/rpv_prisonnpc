ESX = nil
took = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent("rpv_prisonnpc:BuyItem")
AddEventHandler("rpv_prisonnpc:BuyItem", function(amountToBuy,totalBuyPrice,itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if xPlayer.getMoney() >= totalBuyPrice then
		xPlayer.removeMoney(totalBuyPrice)
		xPlayer.addInventoryItem(itemName, amountToBuy)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = itemLabel .. amountToBuy .. 'x' ..totalBuyPrice.. '$ Paid'})

	else

        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough money!'})

	end
end)



RegisterServerEvent("rpv_prisonnpc:LevelUpdate")
AddEventHandler("rpv_prisonnpc:LevelUpdate", function(point)
    local identifier = GetPlayerIdentifiers(source)[1]

    local xPlayer        = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT prisonpoint FROM prisonlevel WHERE identifier = @identifier', {
        ['@identifier'] =  xPlayer.identifier

    }, function(prisonpoint)
       local originalpoint =  tonumber(prisonpoint[1].prisonpoint)
       local updatedpoint = originalpoint + point
       if took == true then
       MySQL.Async.execute('UPDATE prisonlevel SET prisonpoint=@pointupdate WHERE identifier=@identifier ',
       {
           ['@identifier']   = xPlayer.identifier,
           ['@pointupdate']   = updatedpoint
          
       }, function(prisonpoint2)
       end)
    end
    end)
    
    
end)


ESX.RegisterServerCallback('rpv_prisonnpc:GetLevel', function(source, cb)
    
    local _source    = source
    
    local xPlayer        = ESX.GetPlayerFromId(source)
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
                TriggerClientEvent('esx:showNotification', source, '~g~Again Talking to man')
            end)
        end
	end)
end)



RegisterServerEvent("rpv_prisonnpc:lockpick")
AddEventHandler("rpv_prisonnpc:lockpick", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	


	if xPlayer.getMoney() >= 300 then
        xPlayer.removeMoney(300)
        
        took = true
		xPlayer.addInventoryItem('lockpick', 1)      
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got a $ 300 lockpick' })
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'STATUS :: One s trust in you 1+'})


	else

        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough money!'})
				
	end
end)



RegisterServerEvent("rpv_prisonnpc:telefon")
AddEventHandler("rpv_prisonnpc:telefon", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	


	if xPlayer.getMoney() >= 400 then
        xPlayer.removeMoney(400)
        
        took = true
		xPlayer.addInventoryItem('phone', 1)        -- TriggerClientEvent("esx:showNotification",source,"You paid ~g~$"..totalBuyPrice.."~s~ for "..amountToBuy.."x ~y~"..itemLabel.."~s~")
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got a phone for $ 400' })
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'STATUS :: One s trust in you 1++'})


	else

        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough money!'})
				
	end
end)


RegisterServerEvent("rpv_prisonnpc:telsiz")
AddEventHandler("rpv_prisonnpc:telsiz", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	


	if xPlayer.getMoney() >= 400 then
        xPlayer.removeMoney(400)
        
        took = true
		xPlayer.addInventoryItem('radio', 1)        -- TriggerClientEvent("esx:showNotification",source,"You paid ~g~$"..totalBuyPrice.."~s~ for "..amountToBuy.."x ~y~"..itemLabel.."~s~")
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got a radio for $ 400' })
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'STATUS :: One s trust in you 1++'})


	else

        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough money!'})
				
	end
end)


RegisterServerEvent("rpv_prisonnpc:bıçak")
AddEventHandler("rpv_prisonnpc:bıçak", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	


	if xPlayer.getMoney() >= 450 then
        xPlayer.removeMoney(450)
        
        took = true
		xPlayer.addInventoryItem('WEAPON_KNIFE', 1)      
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got a knife for $ 450' })
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'STATUS :: One s trust in you 2+'})
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'MAN :: Guards walk every 7 minutes and dont forget to hide the knife '})



	else

        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough money!'})
				
	end
end)
