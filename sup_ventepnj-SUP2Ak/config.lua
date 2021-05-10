--[[					__SUP2Ak__                            [ Laisse ces commentaires,]
 Discord SUP2Ak FiveM-Dev : https://discord.gg/hYCR2YKgxB     [   ils mangent rien et   ] 
 GitHub : https://github.com/SUP2Ak	                          [  c'est pas aussi chiant ]
 Youtube : https://www.youtube.com/SUPAAkHD					  [     que des print :p    ]
]]

Config             		= {}

--Config.Locale 			= 'fr' --si vous voulez ajoutez des langue ne pas oublié de faire le local rename les notif _U... et de rappeler les locale @es_extended les fxmanifest

Config.Wait = 0 			--Si vous voulez faire un anti-spam

Config.Item = {				--Liste d'item que que vous pouvez vendre
	'weed_pooch',
	'join',
}

Config.ItemResellChances = { --< server side/ erreur nil value car vous êtes inférieur a 100 totalité [Expliqué dans le client] (le fait que join est à 100 vs weed_pooch a 40, c'est que les ped rechercheront plus de join que de weed malgré que ce réglage n'est pas si abusé)
	weed_pooch   = 40,
	join   		 = 100,
	--coke_pooch	= 20,						--<< vous aurez ainsi plus de chance que le ped veuille dans l'ordre Join>Weed>Coke [ainsi plus il y aura d'item moins vous aurez de chance de vente aussi surtout avec par exemple join a 100 weed 40 et genre tout se qui se vends chère vous mettez  entre 1-10]
}

Config.ItemResellQuantity = {	--< server side/ dans la chance de vente le nombre aléatoire de quantité de vente en 1seul ped
	weed_pooch   = {min = 1, max = 3},
	join   		 = {min = 1, max = 5},
	--coke_pooch	= {min = 1, max = 2},	
}

Config.ItemPrices = {			--< server side/ Prix mini et Maxi c'est un math.random() donc sa choisira entre le min / max
	weed_pooch   = {min = 16, max = 22},
	join   		 = {min = 1, max = 3},
	--coke_pooch	= {min = 40, max = 60},
}

Config.ItemPricesHigh = {		--< server side/ si vous tombez sur la chance de vente plein tarif (en gros une chance suplémentaire de mettre des pillules, avec le même principe de vente normal [ItemPrices] xD)
	weed_pooch   = {min = 22, max = 25},
	join   		 = {min = 3, max = 6},
	--coke_pooch = {min = 60, max = 80},
}

--[[					__SUP2Ak__                            [ Laisse ces commentaires,]
 Discord SUP2Ak FiveM-Dev : https://discord.gg/hYCR2YKgxB     [   ils mangent rien et   ] 
 GitHub : https://github.com/SUP2Ak	                          [  c'est pas aussi chiant ]
 Youtube : https://www.youtube.com/SUPAAkHD					  [     que des print :p    ]
]]
