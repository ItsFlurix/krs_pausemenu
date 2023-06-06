ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
	Citizen.Wait(500)
	apriMenu()
end)



RegisterCommand('_pauseMenu', function()
    print("Comando 'pausa' chiamato")
	apriMenu()
end)

function apriMenu()
	while true do
		Citizen.Wait(5)
		SetPauseMenuActive(false)
		if IsControlJustPressed(0, 200) then
			local playerPed = PlayerPedId()
			if not IsPedFalling(playerPed) then 
				if not IsPauseMenuActive() then 
					lib.showContext('menupause') 
				end
			end
		end
	end
end


lib.registerContext({
	id = 'menupause',
	title = 'Menu de pausa',
	onExit = function()
	end,
	options = {
		{
			title = 'Mapa',
			description = 'Abrir mapa (nombre ciudad o server)',
			icon = 'fa-solid fa-map-location-dot',  
			image = 'https://cdn.discordapp.com/attachments/1052910824865402892/1115560752795877436/Mappa.png', -- Ejemplo --
			arrow = false,
			onSelect = function(data)
				TriggerEvent("krs:aprimappa")
			end,
		},
		{
			title = 'Configuracion',
			description = 'Abrir ajustes del juego',
			icon = 'fa-solid fa-gear',
			-- image = '', -- Ejemplo --
			arrow = false,
			onSelect = function(data)
				TriggerEvent("krs:impostazioni")
			end,
		},
		{
			title = 'Salir',
			description = 'Salir del juego',
			icon = 'fa-solid fa-circle-xmark',
			-- image = '', -- Esempio --
			arrow = false,
			onSelect = function(data)
				TriggerEvent("krs:esci")
			end,
		},
	},
})


RegisterNetEvent('krs:aprimappa') 
AddEventHandler('krs:aprimappa', function()
	ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 0, -1)
end)


RegisterNetEvent('krs:impostazioni') 
AddEventHandler('krs:impostazioni', function()
	ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), 0, -1)
end)

RegisterNetEvent('krs:esci') 
AddEventHandler('krs:esci', function()
	TriggerServerEvent("krs_pausemenu:escidalgioco")
end)
