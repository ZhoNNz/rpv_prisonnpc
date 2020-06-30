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


local sellermancoords = {x = 1790.35, y = 2577.31, z = 45.0}  		
local Event =  {x = 1790.35, y = 2577.31, z = 45.8}  	
local level =   0







function PrisonMenu(level)
	local elements = {}
  
 
	table.insert(elements, {label = ('lockpick buy | 300$'), value = 'lockpick'})
  
	if(level > 3 ) then
  
	  table.insert(elements, {label = ('phone | 400$'), value = 'phone'})
	end

	if(level > 5 ) then
  
		table.insert(elements, {label = ('radio | 400$'), value = 'radio'})
	  end

	  if(level > 7 ) then
  
		table.insert(elements, {label = ('knife | 450$'), value = 'knife'})
	  end



	if(level > 80) then
	table.insert(elements, {label = ('📍 ZhoNNz 📍'), value = 'location'})

	end
	table.insert(elements, {label = ('✖️ Close the Menu ✖️'), value = 'kapat'})
  
  
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'action_menu',
		  {
			  title    = ('Trust '..level..'/100'),
			  align    = 'top-left',
			  elements = elements
		  },
	  function(data, menu)
  --
		  ESX.UI.Menu.CloseAll()	
	  		  
	if data.current.value == 'lockpick' then
		TriggerServerEvent("rpv_prisonnpc:lockpick")
		TriggerServerEvent("rpv_prisonnpc:LevelUpdate", 1)		
	ESX.UI.Menu.CloseAll()

	elseif data.current.value == 'phone' then
		TriggerServerEvent("rpv_prisonnpc:phone")
		TriggerServerEvent("rpv_prisonnpc:LevelUpdate", 1)		
	ESX.UI.Menu.CloseAll()    

	elseif data.current.value == 'radio' then
		TriggerServerEvent("rpv_prisonnpc:radio")
		TriggerServerEvent("rpv_prisonnpc:LevelUpdate", 1)		
	ESX.UI.Menu.CloseAll()  
		
		
	elseif data.current.value == 'knife' then
		TriggerServerEvent("rpv_prisonnpc:knife")
		TriggerServerEvent("rpv_prisonnpc:LevelUpdate", 2)		
	ESX.UI.Menu.CloseAll()    

  
	  end
  	end)
  end


---- NPC AREA
  Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false) 
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Event.x, Event.y, Event.z)

			if dist <= 25.0  then
				if not DoesEntityExist(dealer) then
					RequestModel("csb_rashcosvki") --for npc change
					while not HasModelLoaded("csb_rashcosvki") do
						Wait(10)
					end
					dealer = CreatePed(26, "csb_rashcosvki", sellermancoords.x, sellermancoords.y, sellermancoords.z, 83.65, false, false)
					SetEntityHeading(dealer, 1.8)
					SetBlockingOfNonTemporaryEvents(dealer, true)
					TaskStartScenarioInPlace(dealer, "WORLD_HUMAN_AA_SMOKE", 0, false) 
				end		
			else
			Citizen.Wait(1500)
			end

            if dist <= 0.6 then
				DrawText3D(Event.x, Event.y, Event.z, "[E] Talk")
				if IsControlJustPressed(0, Keys['E']) then
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
