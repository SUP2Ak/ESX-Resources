--[[					          __SUP2Ak__                            [ Laisse ces commentaires,]
 Discord SUP2Ak FiveM-Dev : https://discord.gg/hYCR2YKgxB     [   ils mangent rien et   ] 
 GitHub : https://github.com/SUP2Ak	                          [  c'est pas aussi chiant ]
 Youtube : https://www.youtube.com/SUPAAkHD	        				  [     que des print :p    ]
]]

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

ESX 			    			    = nil
local GUI           		= {}
GUI.Time            		= 0
--local myJob 					  = nil
local PlayerData 				= {}
--Pnj
local PedBlacklist      = {}
local PedAttacking      = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


-------------------------------------------------------------------Debut Vente PNJ------------------------------------------------------------------
----anim pnj
function StartWalking(ped)
    Citizen.CreateThread(function()
      RequestAnimDict('move_m@generic_variations@walk')
      while not HasAnimDictLoaded('move_m@generic_variations@walk') do
        Citizen.Wait(0)
      end
      TaskPlayAnim(ped,  'move_m@generic_variations@walk',  'walk_a',  1.0,  -1.0,  -1,  0,  1,  false,  false,  false)
    end)
end
----Vente pnj 
function SellItem() 
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    
    local closestPed, closestDistance = ESX.Game.GetClosestPed({
      x = coords.x,
      y = coords.y,
      z = coords.z
    }, {playerPed})
    if closestDistance == -1 then
      
      local success, ped = GetClosestPed(coords.x,  coords.y,  coords.z,  6.0, 1, 0, 0, 0,  26) --voir la Native sur le site FiveM "GetClosestPed" si vous trouvez des meilleurs paramètre [ne pas toucher a 26 à la fin elle sert a detecter ce qui est humain uniquement (sinon vous pourrez vendre a des animaux xD)]
      if DoesEntityExist(ped) then
        local pedCoords = GetEntityCoords(ped)
        closestPed      = ped
        closestDistance = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  pedCoords.x,  pedCoords.y,  pedCoords.z,  true)
      end
    end
    if closestPed ~= -1 and closestDistance <= 4.0 then
      print('pnj détecter')
      if IsPedInAnyVehicle(closestPed,  false) then
        ESX.ShowNotification('~r~La personne est dans un véhicule.')
        print('ped dans un vehicule')
      elseif IsPedInAnyVehicle(playerPed,  false) then
        ESX.ShowNotification('~r~Vous êtes dans un véhicule.')
        print('vous êtes dans un véhicule')
      else
        local playerData    = ESX.GetPlayerData()
        local isBlacklisted = false
        for i=1, #PedBlacklist, 1 do
          if PedBlacklist[i] == closestPed then
            isBlacklisted = true
          end
        end
        if isBlacklisted then
          print('pnj blacklist')
          ESX.ShowNotification('Vous ne pouvez pas lui ~r~vendre!')
        else
          table.insert(PedBlacklist, closestPed)
          local hasItem = {}
          for i=1, #playerData.inventory, 1 do
            for j=1, #Config.Item, 1 do
              if playerData.inventory[i].name == Config.Item[j] and playerData.inventory[i].count > 0 then
                table.insert(hasItem,  Config.Item[j])
              end
            end
          end
          if #hasItem > 0 then
  
            local magic = GetRandomIntInRange(1, 100)
            TaskStandStill(closestPed,  -1)
            TaskLookAtEntity(closestPed,  playerPed,  -1,  2048,  3)
  
            if magic <= 5 then
              print('vente louper + police 1') --Les appels police sont quelque chose facile a changer en système d'alerte si vous voulez améliorer se script et qui sait je pourrai vous tease le résultat final pour vous donnez des idées ou même vous aidez a contribué si vous en avez que j'ai pas pensé xD
  
              ESX.ShowNotification('~o~J\'en veux pas de ta merde, ~r~lache-moi!')
              TaskStandStill(closestPed,  -1)
              --ESX.SetTimeout(5000, function()
                StartWalking(closestPed)
                --ESX.SetTimeout(20000, function()
                  TaskStartScenarioInPlace(closestPed, 'WORLD_HUMAN_STAND_MOBILE', 0, true);
                  local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
                  -->>>>>>>>TriggerServerEvent("call:makeCall", "police", {x=plyPos.x,y=plyPos.y,z=plyPos.z}, '~o~Une personne ~g~vends~o~ des trucs ~r~suspects à cette position.') <<<<<<<--appel police via gcphone 
                  --ESX.SetTimeout(20000, function()
                    StartWalking(closestPed)
                  --end)
                --end)
              --end)
            elseif magic <= 10 then
  
              ESX.ShowNotification('~o~Tsss..., ~r~non merci!')
              print('vente louper + poolice 2')
              TaskStandStill(closestPed,  -1)
              --ESX.SetTimeout(5000, function()
                StartWalking(closestPed)
                --ESX.SetTimeout(20000, function()
                  TaskStartScenarioInPlace(closestPed, 'WORLD_HUMAN_STAND_MOBILE', 0, true);
                  local plyPos = GetEntityCoords(GetPlayerPed(-1), true) --Sert a récuperer la position du joueur pour l'appel police [c'est la v0.1] dans les versions supérieur c'est un système d'alert plus avancé sans passer par le gcphone mais tout le monde à le gcphone généralement donc je laisse sa pour la v0
                  -->>>>>>>>>>>TriggerServerEvent("call:makeCall", "police", {x=plyPos.x,y=plyPos.y,z=plyPos.z}, '~o~Une personne ~g~vends~o~ des trucs ~r~suspects à cette position.') <<<<<<<<<--appel police via gcphone
                  --ESX.SetTimeout(20000, function()
                    StartWalking(closestPed)
                  --end)
                --end)
              --end)
  
            elseif magic <= 30 then
              
              ESX.ShowNotification('~o~Je suis pas intéressé, ~r~aurevoir!')
              StartWalking(closestPed)
              print('vente loupé 12')
  
            elseif magic <= 70 then
              print('vente réussit 1')
              TriggerServerEvent('esx_drugs:pedBuyItem', true)
              ESX.ShowNotification('~g~Merci, ~o~à la prochaine.')
              --ESX.SetTimeout(5000, function()
                StartWalking(closestPed)
              --end)
  
            elseif magic <= 90 then
  
              PedAttacking = closestPed
              print('vente loupé')
              ESX.ShowNotification('~o~Désolé, cela est trop ~r~chère ~o~pour moi...')
              SetPedAlertness(closestPed,  3)
              SetPedCombatAttributes(closestPed,  46,  false)
              --ESX.SetTimeout(120000, function()
              --  PedAttacking = nil
              --end)
  
            else
              --C'est False est ca vends, oui j'ai concu se script comme un system de Va et Vient en elec x)
              TriggerServerEvent('esx_drugs:pedBuyItem', false)
              print('vente réussit') --Si dans le config.lua vous avez un item < à 100 vous pourrez avoir une erreur côté serveur en attente du valeur nil là par rapport à la ou j'ai commenté dans le config.lua faite attention (même si sa fait pas de drop de fps ni de ping de conso se n'est pas jolie de voir une ligne rouge apparaitre dans le cmd xD)
              ESX.ShowNotification('~g~Merci, ~o~en espérant qu\'on se recapte.')
              TaskStandStill(closestPed,  -1)
              --ESX.SetTimeout(5000, function()
                --StartWalking(closestPed)
              --end)
            
            end
          else
              ESX.ShowNotification('~r~Vous n\'avez plus rien à vendre!')
              print('vous avez pu ditem 0')
          end
        end
      end
    else
      --ESX.ShowNotification('~r~Personne aux alentours pour vendre!')
      print('impossible/no target') 
    end  
end

---------------------------------------------Fin vente PNJ----------------------------------------------------

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(Config.Wait)
    if IsControlJustReleased(1, Keys['H']) then
      SellItem()
    end
  end
end)
--Jouer animation 
--[[
function PlayEmote(name, duration) 
  Citizen.CreateThread(function()
      TaskStartScenarioInPlace(GetPlayerPed(-1), name, 0, true)
      Citizen.Wait(duration)
      ClearPedTasks(GetPlayerPed(-1))
  end)
end]]

--[[					          __SUP2Ak__                            [ Laisse ces commentaires,]
 Discord SUP2Ak FiveM-Dev : https://discord.gg/hYCR2YKgxB     [   ils mangent rien et   ] 
 GitHub : https://github.com/SUP2Ak	                          [  c'est pas aussi chiant ]
 Youtube : https://www.youtube.com/SUPAAkHD	        				  [     que des print :p    ]
]]
