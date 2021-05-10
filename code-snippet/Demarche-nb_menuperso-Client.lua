

							{label = 'Demarche',  value = 'menuperso_demarche'},
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
							if data2.current.value == 'menuperso_demarche' then
                                ESX.UI.Menu.Open(
                                    'default', GetCurrentResourceName(), 'menuperso_actions_18',
                                    {
                                        title    = 'Démarche',
                                        align    = 'top-left',
                                        elements = {
											{label = 'Normal H', value = 'menuperso_actions_demarch_normoh'},
											{label = 'Normal F', value = 'menuperso_actions_demarch_normof'},
                                            {label = 'Homme effiminer',  value = 'menuperso_actions_demarch_normalh'},
                                            {label = 'Bouffiasse',  value = 'menuperso_actions_demarch_normalf'},
                                            {label = 'Depressif',  value = 'menuperso_actions_demarch_depressif'},
                                            {label = 'Depressif F',  value = 'menuperso_actions_demarch_depressiff'},
                                            {label = 'Muscle',  value = 'menuperso_actions_demarch_muscle'},
                                            {label = 'Hipster',  value = 'menuperso_actions_demarch_hipster'},
                                            {label = 'Business',  value = 'menuperso_actions_demarch_business'},
                                            {label = 'Intimide',  value = 'menuperso_actions_demarch_intimide'},
                                            {label = 'Bourrer',  value = 'menuperso_actions_demarch_hobo'},
											{label = 'Malheureux(se)',  value = 'menuperso_actions_demarch_malheureux'},
												--{label = 'Triste', value == 'menuperso_actions_demarch_triste'},
                                            {label = 'Choc',  value = 'menuperso_actions_demarch_choc'},
                                            {label = 'Sombre',  value = 'menuperso_actions_demarch_sombre'},
                                            {label = 'Fatiguer',  value = 'menuperso_actions_demarch_fatigue'},
                                            {label = 'Presser',  value = 'menuperso_actions_demarch_pressee'},
											{label = 'Frimeur(se)', value = 'menuperso_actions_demarch_frim'},
                                            {label = 'Fier(e)',  value = 'menuperso_actions_demarch_fier'},
                                            {label = 'Petite course',  value = 'menuperso_actions_demarch_course'},
                                            {label = 'Pupute',  value = 'menuperso_actions_demarch_nom'},
                                            {label = 'Impertinent(e)',  value = 'menuperso_actions_demarch_impertinent'},
                                            {label = 'Arrogant(e)',  value = 'menuperso_actions_demarch_arrogant'}, 
											{label = 'Blesser', value = 'menuperso_actions_demarch_blesse'},
											{label = 'Trop manger', value = 'menuperso_actions_demarch_tropm'},
											{label = 'Casual', value = 'menuperso_actions_demarch_casual'},
											{label = 'Determiner', value = 'menuperso_actions_demarch_deter'},
											{label = 'Peureux(se)', value = 'menuperso_actions_demarch_peur'},
											{label = 'Trop Swag', value = 'menuperso_actions_demarch_swagy'},
											{label = 'Travailleur(se)', value = 'menuperso_actions_demarch_taf'},
											{label = 'Brute', value = 'menuperso_actions_demarch_brute'},
											{label = 'Rando', value = 'menuperso_actions_demarch_rando'},
											{label = 'Gangster F', value = 'menuperso_actions_demarch_gg'},
											{label = 'Gangster', value = 'menuperso_actions_demarch_g1'},

                                        },
                                    },
                                    function(data3, menu3)
									
										if data3.current.value == 'menuperso_actions_demarch_normoh' then
											startAttitude("move_m@multiplayer","move_m@multiplayer")
										end

										if data3.current.value == 'menuperso_actions_demarch_normof' then
											startAttitude("move_f@multiplayer","move_f@multiplayer")
										end
										
										if data3.current.value == 'menuperso_actions_demarch_gg' then
											startAttitude("move_m@gangster@ng","move_m@gangster@ng")
										end
										
										if data3.current.value == 'menuperso_actions_demarch_g1' then
											startAttitude("move_m@gangster@generic","move_m@gangster@generic")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_rando' then
											startAttitude("move_m@hiking","move_m@hiking")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_brute' then
											startAttitude("move_m@tough_guy@","move_m@tough_guy@")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_taf' then
											startAttitude("move_m@tool_belt@a","move_m@tool_belt@a")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_triste' then
											startAttitude("move_m@leaf_blower","move_m@leaf_blower")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_swagy' then
											startAttitude("move_m@swagger@b","move_m@swagger@b")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_peur' then
											startAttitude("move_m@scared","move_m@scared")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_deter' then
											startAttitude("move_m@brave@a","move_m@brave@a")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_casual' then
											startAttitude("move_m@casual@a","move_m@casual@a")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_tropm' then
											startAttitude("move_m@fat@a","move_m@fat@a")
										end
									
										if data3.current.value == 'menuperso_actions_demarch_blesse' then
											startAttitude("move_m@injured","move_m@injured")
										end
										
                                        if data3.current.value == 'menuperso_actions_demarch_arrogant' then
                                            startAttitude("move_f@arrogant@a","move_f@arrogant@a")
                                        end
 										
                                        if data3.current.value == 'menuperso_actions_demarch_impertinent' then
                                            startAttitude("move_f@sassy","move_f@sassy")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_nom' then
                                            startAttitude("move_f@maneater","move_f@maneater")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_course' then
                                            startAttitude("move_m@quick","move_m@quick")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_frim' then
                                            startAttitude("move_m@money","move_m@money")
                                        end
										
										if data3.current.value == 'menuperso_actions_demarch_fier' then
											startAttitude("move_m@posh@","move_m@posh@")
										end
 
                                        if data3.current.value == 'menuperso_actions_demarch_pressee' then
                                            startAttitude("move_m@hurry_butch@a","move_m@hurry_butch@a")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_fatigue' then
                                            startAttitude("move_m@buzzed","move_m@buzzed")
                                        end
  
                                        if data3.current.value == 'menuperso_actions_demarch_sombre' then
                                            startAttitude("move_m@shadyped@a","move_m@shadyped@a")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_malheureux' then
                                            startAttitude("move_m@sad@a","move_m@sad@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_choc' then
                                            startAttitude("move_m@shocked@a","move_m@shocked@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_hobo' then
                                            startAttitude("move_m@hobo@a","move_m@hobo@a")
                                        end
 
                                        if data3.current.value == 'menuperso_actions_demarch_intimide' then
                                            startAttitude("move_m@hurry@a","move_m@hurry@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_business' then
                                            startAttitude("move_m@business@a","move_m@business@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_depressiff' then
                                            startAttitude("move_f@depressed@a","move_f@depressed@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_depressif' then
                                            startAttitude("move_m@depressed@a","move_m@depressed@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_normalh' then
                                            startAttitude("move_m@confident","move_m@confident")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_normalf' then
                                            startAttitude("move_f@heels@c","move_f@heels@c")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_muscle' then
                                            startAttitude("move_m@muscle@a","move_m@muscle@a")
                                        end
										
                                        if data3.current.value == 'menuperso_actions_demarch_hipster' then
                                            startAttitude("move_m@hipster@a","move_m@hipster@a")
                                        end
                                   
                                       
 
                                    end,
                                    function(data3, menu3)
                                        menu3.close()
                                    end
                                )
                               
                            end
							
-------------------------------------------------------------
-------------------------------------------------------------

local playAnim = false
local dataAnim = {}

function startAttitude(lib, anim)
    Citizen.CreateThread(function()
   
        local playerPed = GetPlayerPed(-1)
   
        RequestAnimSet(anim)
         
        while not HasAnimSetLoaded(anim) do
            Citizen.Wait(1)
        end
		SetPedMotionBlur(playerPed, false)
        SetPedMovementClipset(playerPed, anim, true)
    end)
 
end 
