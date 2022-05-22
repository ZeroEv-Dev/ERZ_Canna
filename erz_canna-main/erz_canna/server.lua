ESX	= nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('cimetta', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('erz_canna:arrotolacanna', _source)
end)

RegisterNetEvent('erz_canna:rolla')
AddEventHandler('erz_canna:rolla', function(coord)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local object = xPlayer.getInventoryItem('cartine').count
    if object >= 1 then
     xPlayer.removeInventoryItem('cartine', 1)
     xPlayer.removeInventoryItem('cimetta', 1)   
     xPlayer.addInventoryItem('canna', 1) 
    else
        TriggerClientEvent('esx:showNotification', source, 'Non hai un pacco di ~r~Cartine~s~ !')
    end
end)
ESX.RegisterUsableItem('canna', function(source)     
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local object = xPlayer.getInventoryItem('accendino').count
    if object >= 1 then
     xPlayer.removeInventoryItem('canna', 1)
     TriggerClientEvent('erz_canna:canna', _source)
     if Config_ERZ.Stress then
     TriggerClientEvent('esx_status:remove', source, 'stress', 15000)--L'ULTIMO VALORE MODIFICALO IN BASE AL TUO SISTEMA DI STRESS
     end
    else
        TriggerClientEvent('esx:showNotification', _source, 'Non hai un ~r~Accendino~s~ !')
    end
end)

