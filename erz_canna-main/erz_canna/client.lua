--ESX

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
--ESX FINE

--ARROTOLARE CANNA
RegisterNetEvent('erz_canna:arrotolacanna')
AddEventHandler('erz_canna:arrotolacanna', function()
  TriggerServerEvent('erz_canna:rolla')
end)

RegisterNetEvent('erz_canna:canna')
AddEventHandler('erz_canna:canna', function()
	function loadAnimDict(dict)
		while (not HasAnimDictLoaded(dict)) do
			RequestAnimDict(dict)
			Citizen.Wait(5)
		end
	end

-- ANIMAZIONE
	local ad = "amb@world_human_aa_smoke@male@idle_a"
	loadAnimDict( ad )
	TaskPlayAnim( PlayerPedId(), ad, "idle_c", 3.0, -8, -1, 63, 0, 0, 0, 0 )

	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local erzcanna = math.random(1)
	if erzcanna == 1 then
		erzcanna = 'p_amb_joint_01'
		joint = CreateObject(GetHashKey(erzcanna), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(joint, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    Citizen.Wait(Config_ERZ.DurataFumo)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator6")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@DRUNK@VERYDRUNK", true)
    SetPedIsDrunk(playerPed, true)
    AnimpostfxPlay("ChopVision", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", Config_ERZ.Movimento)
    SetEntityHealth(GetPlayerPed(-1), 200)
    TriggerEvent('erz_canna:fine')
    Citizen.Wait(Config_ERZ.DurataEffetto)
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
	end
end)
RegisterNetEvent('erz_canna:fine')
AddEventHandler('erz_canna:fine', function()
	DetachEntity(erzcanna, 1, 1)
	DeleteObject(erzcanna)	
	maitem = false
	ClearPedSecondaryTask(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
end)