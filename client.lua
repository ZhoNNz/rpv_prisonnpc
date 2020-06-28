ESX = nil

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


local saticicoords = {x = 1790.35, y = 2577.31, z = 45.0}  		
local Olay =  {x = 1790.35, y = 2577.31, z = 45.8}  	
local level =   0







function PrisonMenu(level)
	local elements = {}
  
 
	table.insert(elements, {label = ('Maymuncuk Al | 300$'), value = 'maymunck'})
  
	if(level > 3 ) then
  
	  table.insert(elements, {label = ('Telefon | 400$'), value = 'telefon'})
	end

	if(level > 5 ) then
  
		table.insert(elements, {label = ('Telsiz | 400$'), value = 'telsiz'})
	  end

	  if(level > 7 ) then
  
		table.insert(elements, {label = ('Bıçak | 450$'), value = 'bıçak'})
	  end



	if(level > 80) then
	table.insert(elements, {label = ('📍 Cloud Fivem 📍'), value = 'location'})

	end
	table.insert(elements, {label = ('✖️ Menüyü Kapat ✖️'), value = 'kapat'})
  
  
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'action_menu',
		  {
			  title    = ('Güven '..level..'/100'),
			  align    = 'top-left',
			  elements = elements
		  },
	  function(data, menu)
  --
		  ESX.UI.Menu.CloseAll()	
	  		  
	if data.current.value == 'maymunck' then
		TriggerServerEvent("rpv_prisonnpc:maymuncuk")
		TriggerServerEvent("rpv_prisonnpc:LevelUpdate", 1)		
	ESX.UI.Menu.CloseAll()

	elseif data.current.value == 'telefon' then
		TriggerServerEvent("rpv_prisonnpc:telefon")
		TriggerServerEvent("rpv_prisonnpc:LevelUpdate", 1)		
	ESX.UI.Menu.CloseAll()    

	elseif data.current.value == 'telsiz' then
		TriggerServerEvent("rpv_prisonnpc:telsiz")
		TriggerServerEvent("rpv_prisonnpc:LevelUpdate", 1)		
	ESX.UI.Menu.CloseAll()  
		
		
	elseif data.current.value == 'bıçak' then
		TriggerServerEvent("rpv_prisonnpc:bıçak")
		TriggerServerEvent("rpv_prisonnpc:LevelUpdate", 2)		
	ESX.UI.Menu.CloseAll()    

  
	  end
  	end)
  end


---- NPC KISMI
  Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Olay.x, Olay.y, Olay.z)

			if dist <= 25.0  then
				if not DoesEntityExist(dealer) then
				RequestModel("csb_rashcosvki")   -- npcleri buradan değiştirebilirsiniz
				while not HasModelLoaded("csb_rashcosvki") do
				Wait(10)
				end
				dealer = CreatePed(26, "csb_rashcosvki", saticicoords.x, saticicoords.y, saticicoords.z, 83.65, false, false)
				SetEntityHeading(dealer, 1.8)
				SetBlockingOfNonTemporaryEvents(dealer, true)
				TaskStartScenarioInPlace(dealer, "WORLD_HUMAN_AA_SMOKE", 0, false) -- NPC 'nin hangi eylemi yapacagını gosterırsınız
				end
				
			-- DrawMarker(25, Olay.x, Olay.y, Olay.z-0.90, 0, 0, 0, 0, 0, 0, 1.301, 1.3001, 1.3001, 0, 205, 250, 200, 0, 0, 0, 0)   --- NPC altındaki daire istersin açarsın
			else
			Citizen.Wait(1500)
			end

            if dist <= 0.6 then
				DrawText3D(Olay.x, Olay.y, Olay.z, "[E] Konus")
				if IsControlJustPressed(0, Keys['E']) then
				-- NPCMenu()
				ESX.TriggerServerCallback('rpv_prisonnpc:GetLevel', function(prisonpoint) 
				PrisonMenu(tonumber(prisonpoint))
				end)
				Citizen.Wait(500)
				end
            end
        end
    end)



function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.2, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end





























































-- Düz kısımlar


-- NPCMenu = function()
-- 	local player = PlayerPedId()
-- 	FreezeEntityPosition(player,true)
	
-- 	local elements = {
-- 		{ label = "Satın al", action = "Satis_Buy_Menu" },	}
		
-- 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_Satis_main_menu",
-- 		{
-- 			title    = "Hapishane Kaçakcısı",
-- 			align    = "top-left",
-- 			elements = elements
-- 		},
-- 	function(data, menu)
-- 		local action = data.current.action

-- 		if action == "Satis_Buy_Menu" then
--             SatinAlmaMenu()
-- 		elseif action == "PawnShop_Sell_Menu" then
-- 			Kapat()
-- 		end	
-- 	end, function(data, menu)
-- 		menu.close()
-- 		insideMarker = false
-- 		FreezeEntityPosition(player,false)
-- 	end, function(data, menu)
-- 	end)
-- end

-- function SatinAlmaMenu()
-- 	local player = PlayerPedId()
-- 	FreezeEntityPosition(player,true)
-- 	local elements = {}
			
-- 	for k,v in pairs(Config.Satis) do
-- 		if v.BuyInPawnShop == true then
-- 			table.insert(elements,{label = v.label .. " | "..('<span style="color:green;">%s</span>'):format("$"..v.BuyPrice..""), itemName = v.itemName, BuyInPawnShop = v.BuyInPawnShop, BuyPrice = v.BuyPrice})
-- 		end
-- 	end
		
-- 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "PrisonBuyMenu",
-- 		{
-- 			title    = "Ne almak istiyorsun?",
-- 			align    = "top-left",
-- 			elements = elements
-- 		},
-- 	function(data, menu)
-- 			if data.current.itemName == data.current.itemName then
-- 				OpenBuyDialogMenu(data.current.itemName,data.current.BuyPrice)
-- 			end	
-- 	end, function(data, menu)
-- 		menu.close()
-- 		insideMarker = false
-- 		FreezeEntityPosition(player,false)
-- 	end, function(data, menu)
-- 	end)
-- end

-- function OpenBuyDialogMenu(itemName, BuyPrice)
-- 	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'PrisonDialog', {
-- 		title = "Satın Alacak Miktar?"
-- 	}, function(data, menu)
-- 		menu.close()
-- 		amountToBuy = tonumber(data.value)
-- 		totalBuyPrice = (BuyPrice * amountToBuy)
-- 		TriggerServerEvent("rpv_prisonnpc:BuyItem",amountToBuy,totalBuyPrice,itemName)
-- 	end,
-- 	function(data, menu)
-- 		menu.close()	
-- 	end)
-- end