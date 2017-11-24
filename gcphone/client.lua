--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================
-- Configuration

ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


local KeyToucheCloseEvent = {
  { code = 172, event = 'ArrowUp' },
  { code = 173, event = 'ArrowDown' },
  { code = 174, event = 'ArrowLeft' },
  { code = 175, event = 'ArrowRight' },
  { code = 176, event = 'Enter' },
  { code = 177, event = 'Backspace' },
}
local KeyOpenClose = 168
local menuIsOpen = false
local contacts = {}
local messages = {}
local myPhoneNumber = ''
local isDead = false
--====================================================================================
--  
--====================================================================================
 
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    
    if IsControlJustPressed(1, KeyOpenClose) then
       ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
                                    if qtty > 0 then
                                        TooglePhone()
                                           TriggerServerEvent("gcphone:allUpdate")
                                    else
                                      ESX.ShowNotification("Vous n'avez pas d'~r~iPommeV ~w~.")

                                    end 
      end,'tel')
      
    end
    
    if menuIsOpen == true then
      DeadCheck()
      for _, value in ipairs(KeyToucheCloseEvent) do
        if IsControlJustPressed(1, value.code) then
          Citizen.Trace('Event: ' .. value.event)
          SendNUIMessage({keyUp = value.event})
        end
      end
    end
  end
end)
 
function DeadCheck() 
  local dead = IsEntityDead(GetPlayerPed(-1))
  if dead ~= isDead then 
    isDead = dead
    SendNUIMessage({event = 'updateDead', isDead = isDead})
  end
end

--====================================================================================
--  Events
--====================================================================================
RegisterNetEvent("gcphone:myPhoneNumber")
AddEventHandler("gcphone:myPhoneNumber", function(myPhoneNumber)
  myPhoneNumber = myPhoneNumber
  SendNUIMessage({event = 'updateYyPhoneNumber', myPhoneNumber = myPhoneNumber})
end)

RegisterNetEvent("gcphone:contactList")
AddEventHandler("gcphone:contactList", function(_contacts)
  Citizen.Trace('contactList')
  SendNUIMessage({event = 'updateContacts', contacts = _contacts})
  contacts = _contacts
end)

RegisterNetEvent("gcphone:allMessage")
AddEventHandler("gcphone:allMessage", function(allmessages)
  Citizen.Trace('allMessage')
  SendNUIMessage({event = 'updateMessages', messages = allmessages})
  messages = allmessages
end)

RegisterNetEvent("gcphone:receiveMessage")
AddEventHandler("gcphone:receiveMessage", function(message)
  table.insert(messages, message)
  SendNUIMessage({event = 'updateMessages', messages = messages})
  Citizen.Trace('sendMessage: ' .. json.encode(messages))
  -- Just For reload 
--TriggerServerEvent('gcphone:allUpdate')
if message.owner == 0 then 
    SetNotificationTextEntry("STRING")
    AddTextComponentString('~o~Nouveau message')
    DrawNotification(false, false)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    Citizen.Wait(300)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    Citizen.Wait(300)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
  end
end)

RegisterNetEvent("OpenTel")
AddEventHandler("OpenTel", function()
  
  menuIsOpen = true
  
  if menuIsOpen == true then 
    Citizen.Trace('open')
    ePhoneInAnim()
    Wait(1000)
    SendNUIMessage({show = menuIsOpen})
  else
    ePhoneOutAnim()
  end
  --ShowNotificationMenuCivil2("~h~~g~TooglePhone !")
end)

function ShowNotificationMenuCivil2(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end
--====================================================================================
--  Function client | Contacts
--====================================================================================
function addContact(display, num) 
  TriggerServerEvent('gcphone:addContact', display, num)
end

function deleteContact(num) 
  TriggerServerEvent('gcphone:deleteContact', num)
end
--====================================================================================
--  Function client | Messages
--====================================================================================
function sendMessage(num, message)
  TriggerServerEvent('gcphone:sendMessage', num, message)
end

function deleteMessage(msgId)
  Citizen.Trace('deleteMessage' .. msgId)
  TriggerServerEvent('gcphone:deleteMessage', msgId)
  for k, v in ipairs(messages) do 
    if v.id == msgId then
      table.remove(messages, k)
      SendNUIMessage({event = 'updateMessages', messages = messages})
      return
    end
  end
end

function deleteMessageContact(num)
  TriggerServerEvent('gcphone:deleteMessageNumber', num)
end

function deleteAllMessage()
  TriggerServerEvent('gcphone:deleteAllMessage')
end

function setReadMessageNumber(num)
  TriggerServerEvent('gcphone:setReadMessageNumber', num)
  for k, v in ipairs(messages) do 
    if v.transmitter == num then
      v.isRead = true
    end
  end
end

function requestAllMessages()
  TriggerServerEvent('gcphone:requestAllMessages')
end

function requestAllContact()
  TriggerServerEvent('gcphone:requestAllContact')
end
--====================================================================================
--  Gestion des evenements NUI
--==================================================================================== 
RegisterNUICallback('log', function(data, cb)
  Citizen.Trace('NUI Log | ' .. json.encode(data))
  cb()
end)
RegisterNUICallback('focus', function(data, cb)
  cb()
end)

RegisterNUICallback('blur', function(data, cb)
  cb()
end)

RegisterNUICallback('reponseText', function(data, cb)
Citizen.Trace('call reponseText | ' .. json.encode(data))
  local limit = data.limit or 255
  local text = data.text or ''
  
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", text, "", "", "", limit)
  while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
      text = GetOnscreenKeyboardResult()
  end
  cb(json.encode({text = text}))
end)
--====================================================================================
--  Event - Messages
--====================================================================================
RegisterNUICallback('getMessages', function(data, cb)
  Citizen.Trace('call getMessages | ' .. json.encode(messages))
  cb(json.encode(messages))
end)

RegisterNUICallback('sendMessage', function(data, cb)
  if data.message == '%pos%' then
    local myPos = GetEntityCoords(GetPlayerPed(-1))
    data.message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('gcphone:sendMessage', data.phoneNumber, data.message)
end)

RegisterNUICallback('deleteMessage', function(data, cb)
  deleteMessage(data.id)
  cb()
end)

RegisterNUICallback('deleteMessageNumber', function (data, cb)
Citizen.Trace('deleteMessageNumber' .. data.number)
  deleteMessageContact(data.number)
  cb()
end)
RegisterNUICallback('deleteAllMessage', function (data, cb)
  deleteAllMessage()
  cb()
end)

RegisterNUICallback('setReadMessageNumber', function (data, cb)
  setReadMessageNumber(data.number)
  cb()
end)
--====================================================================================
--  Event - Contacts
--====================================================================================
RegisterNUICallback('addContact', function(data, cb)
  Citizen.Trace('addContact: ' .. json.encode(data))
  TriggerServerEvent('gcphone:addContact', data.display, data.phoneNumber)
end)

RegisterNUICallback('updateContact', function(data, cb)
  TriggerServerEvent('gcphone:updateContact', data.id, data.display, data.phoneNumber)
end)

RegisterNUICallback('deleteContact', function(data, cb)
  TriggerServerEvent('gcphone:deleteContact', data.id)
end)

RegisterNUICallback('getContacts', function(data, cb)
  cb(json.encode(contacts))
end)

RegisterNUICallback('setGPS', function(data, cb)
  SetNewWaypoint(tonumber(data.x), tonumber(data.y))
  cb()
end)
RegisterNUICallback('callEvent', function(data, cb)
  local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
  if data.eventName ~= 'cancel' then
    if data.data ~= nil then 
      --TriggerServerEvent("call:makeCall", "police", {x=plyPos.x,y=plyPos.y,z=plyPos.z},ResultMotifAdd,GetPlayerServerId(player))
      TriggerServerEvent("call:makeCall", data.eventName, {x=plyPos.x,y=plyPos.y,z=plyPos.z}, data.data, GetPlayerServerId(player))
      if data.eventName == "police" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé la ~b~POLICE")
      elseif data.eventName == "taxi" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~TAXI")
      elseif data.eventName == "tow" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~DEPANNEUR")
      elseif data.eventName == "CNN" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~JOURNALISTE")
      elseif data.eventName == "medic" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~AMBULANCIER")
      elseif data.eventName == "brinks" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~agent de la BRINKS")
      end




    else
      local limit = data.limit or 255
      local text = data.text or ''
      if data.eventName ~= "RESPAWN" then
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", text, "", "", "", limit)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            text = GetOnscreenKeyboardResult()
        end
        TriggerServerEvent("call:makeCall", data.eventName, {x=plyPos.x,y=plyPos.y,z=plyPos.z}, text, GetPlayerServerId(player))
        if data.eventName == "police" then
          ShowNotificationMenuCivil2("~h~Vous avez appelé la ~b~POLICE")
        elseif data.eventName == "taxi" then
          ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~TAXI")
        elseif data.eventName == "tow" then
          ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~DEPANNEUR")
        elseif data.eventName == "CNN" then
          ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~JOURNALISTE")
        elseif data.eventName == "medic" then
          ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~AMBULANCIER")
        elseif data.eventName == "brinks" then
          ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~agent de la BRINKS")
        end
      else
        TriggerEvent('es_em:cl_respawn')
      end
    end
    cb()
  end
end)

RegisterNUICallback('deleteALL', function(data, cb)
  TriggerServerEvent('gcphone:deleteALL')
  cb()
end)

function TooglePhone() 
  menuIsOpen = not menuIsOpen
  SendNUIMessage({show = menuIsOpen})
  if menuIsOpen == true then 
    Citizen.Trace('open')
    ePhoneInAnim()
  else
    ePhoneOutAnim()
  end
end


RegisterNUICallback('closePhone', function(data, cb)
  menuIsOpen = false
  SendNUIMessage({show = false})
  ePhoneOutAnim()
  cb()
end)

-- Just For reload 
--TriggerServerEvent('gcphone:allUpdate')
