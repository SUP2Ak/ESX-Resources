--[[	__SUP2Ak__                                            [ Laisse ces commentaires,]
 Discord SUP2Ak FiveM-Dev : https://discord.gg/hYCR2YKgxB     [   ils mangent rien et   ] 
 GitHub : https://github.com/SUP2Ak	                          [  c'est pas aussi chiant ]
 Youtube : https://www.youtube.com/SUPAAkHD					  [     que des print :p    ]
]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


----------------ACHAT PNJ---------------

function randomFloat(lower, greater)
	return lower + math.random()  * (greater - lower);
end
  
RegisterServerEvent('esx_drugs:pedBuyItem')
AddEventHandler('esx_drugs:pedBuyItem', function(highPrice)
	
	local _source                 = source
	local xPlayer                 = ESX.GetPlayerFromId(_source)
	local resellChances           = {}
	local ItemType			      = math.random(0, 100)
	local chosenItem          	  = nil
	local prices                  = nil
  
	if highPrice then
	  prices = Config.ItemPricesHigh
	else
	  prices = Config.ItemPrices
	end
  
	for k,v in pairs(Config.ItemResellChances) do
	  table.insert(resellChances, {item = k, chance = v})
	end
  
	table.sort(resellChances, function(a, b)
	  return a.chance < b.chance
	end)
  
	local count = 0
  
	for i=1, #resellChances, 1 do
	  
	  count = count + resellChances[i].chance
  
	  if ItemType <= count then
		chosenItem = resellChances[i].item
		break
	  end
  
	end
  
	local pricePerUnit = math.random(prices[chosenItem].min, prices[chosenItem].max)
	local quantity     = math.random(Config.ItemResellQuantity[chosenItem].min, Config.ItemResellQuantity[chosenItem].max)
	local item         = xPlayer.getInventoryItem(chosenItem)
  
  
	if item.count >= 1 then
  
	  	if item.count < quantity then
  
			local price = math.floor(item.count * pricePerUnit)
			--Si la chance de vendre en quantité de l'item choisit est supérieur par rapport a ce vous avez dans l'inventaire alors vous allez vendre que ce qui vous reste
		  	xPlayer.removeInventoryItem(chosenItem, item.count)
		  	TriggerClientEvent('esx:showNotification', _source, '~o~Je te prends ce qui reste...')
		  	xPlayer.addMoney(price)
		  	TriggerClientEvent('esx:showNotification', _source, 'Vous avez gagné ~g~$' .. price .. '~s~ pour ~y~x' .. item.count .. ' ' .. item.label)
			
	  	else
			--Vente classique quand vous avez large la quantité d'item
			local price = math.floor(quantity * pricePerUnit)
  
		  	xPlayer.removeInventoryItem(chosenItem, quantity)
		  	TriggerClientEvent('esx:showNotification', _source, 'Vous avez gagné ~g~$' .. price .. '~s~ pour ~y~x' .. quantity .. ' ' .. item.label)
		  	xPlayer.addMoney(price)
			
	  	end
  
	else
		--Quand vous n'avez pas l'item qu'il recheche
	  TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas ce que demande le ~o~client~s~ (~b~' .. item.label .. '~s~)')
	end
  
end)

--[[					__SUP2Ak__                            [ Laisse ces commentaires,]
 Discord SUP2Ak FiveM-Dev : https://discord.gg/hYCR2YKgxB     [   ils mangent rien et   ] 
 GitHub : https://github.com/SUP2Ak	                          [  c'est pas aussi chiant ]
 Youtube : https://www.youtube.com/SUPAAkHD					  [     que des print :p    ]
]]
