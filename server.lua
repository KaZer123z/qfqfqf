-- Server side for vehicle customization
-- Framework: ESX/QBCore
-- Version: 2.0.0

-- Initialisation du framework (ESX ou QBCore)
local Framework = nil

if Config.Framework == "ESX" then
    Framework = exports[Config.ESX.Core]:getSharedObject()
elseif Config.Framework == "QBCore" then
    Framework = exports[Config.QBCore.Core]:GetCoreObject()
end

-- Fonction pour vérifier si un véhicule appartient à un job
local function IsVehicleOwnedByJob(plate, callback)
    if Config.Framework == "ESX" then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        }, function(result)
            if result[1] and result[1].job and result[1].job ~= "" and result[1].job ~= "civ" then
                callback(true, result[1].job)
            else
                callback(false, nil)
            end
        end)
    elseif Config.Framework == "QBCore" then
        MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        }, function(result)
            if result[1] and result[1].job and result[1].job ~= "" and result[1].job ~= "civ" then
                callback(true, result[1].job)
            else
                callback(false, nil)
            end
        end)
    else
        callback(false, nil)
    end
end

-- Fonction pour obtenir le job d'un joueur
local function GetPlayerJob(source)
    if Config.Framework == "ESX" then
        local xPlayer = Framework.GetPlayerFromId(source)
        return xPlayer.job.name
    elseif Config.Framework == "QBCore" then
        local Player = Framework.Functions.GetPlayer(source)
        return Player.PlayerData.job.name
    end
    return "unemployed"
end

-- Fonction pour vérifier si le joueur a assez d'argent
local function HasEnoughMoney(source, amount, type)
    type = type or "cash"
    
    if Config.Framework == "ESX" then
        local xPlayer = Framework.GetPlayerFromId(source)
        if type == "cash" then
            return xPlayer.getMoney() >= amount
        elseif type == "bank" then
            return xPlayer.getAccount('bank').money >= amount
        end
    elseif Config.Framework == "QBCore" then
        local Player = Framework.Functions.GetPlayer(source)
        if type == "cash" then
            return Player.PlayerData.money["cash"] >= amount
        elseif type == "bank" then
            return Player.PlayerData.money["bank"] >= amount
        end
    end
    
    return false
end

-- Fonction pour retirer de l'argent à un joueur
local function RemoveMoney(source, amount, type, reason)
    type = type or "cash"
    reason = reason or "Custom Shop Payment"
    
    if Config.Framework == "ESX" then
        local xPlayer = Framework.GetPlayerFromId(source)
        if type == "cash" then
            xPlayer.removeMoney(amount)
        elseif type == "bank" then
            xPlayer.removeAccountMoney('bank', amount)
        end
    elseif Config.Framework == "QBCore" then
        local Player = Framework.Functions.GetPlayer(source)
        Player.Functions.RemoveMoney(type, amount, reason)
    end
end

-- Fonction pour vérifier si une entreprise a assez d'argent
local function HasEnoughSocietyMoney(jobName, amount)
    local societyAccount = Config.SocietyAccount .. jobName
    local money = 0
    
    if Config.Framework == "ESX" then
        local result = MySQL.Sync.fetchScalar("SELECT money FROM addon_account_data WHERE account_name = @account_name", {
            ['@account_name'] = societyAccount
        })
        
        if result then
            money = result
        end
    elseif Config.Framework == "QBCore" then
        money = exports['qb-management']:GetAccount(jobName)
    end
    
    return money >= amount
end

-- Fonction pour retirer de l'argent à une entreprise
local function RemoveSocietyMoney(jobName, amount, reason)
    reason = reason or "Custom Shop Payment"
    local societyAccount = Config.SocietyAccount .. jobName
    
    if Config.Framework == "ESX" then
        TriggerEvent('esx_addonaccount:getSharedAccount', societyAccount, function(account)
            if account then
                account.removeMoney(amount)
            end
        end)
    elseif Config.Framework == "QBCore" then
        exports['qb-management']:RemoveMoney(jobName, amount)
    end
end

-- Fonction pour envoyer une notification au joueur
local function NotifyPlayer(source, message, type)
    if Config.Framework == "ESX" then
        TriggerClientEvent('esx:showNotification', source, message)
    elseif Config.Framework == "QBCore" then
        TriggerClientEvent('QBCore:Notify', source, message, type or "primary")
    end
end

-- Callback pour gérer le paiement des modifications
if Config.Framework == "ESX" then
    Framework.RegisterServerCallback('custom:payModifications', function(source, cb, price)
        local playerJob = GetPlayerJob(source)
        local finalPrice = Config.PaymentFunctions.ApplyDiscount(source, price, playerJob)
        
        IsVehicleOwnedByJob(plate, function(isJobVehicle, vehicleJob)
            if isJobVehicle and playerJob == vehicleJob and Config.EnableSocietyPay then
                -- C'est un véhicule de service et le joueur a le même job
                if HasEnoughSocietyMoney(vehicleJob, finalPrice) then
                    RemoveSocietyMoney(vehicleJob, finalPrice, "Vehicle Customization")
                    NotifyPlayer(source, 'Société a payé: $' .. finalPrice)
                    cb(true)
                else
                    NotifyPlayer(source, 'La société n\'a pas assez de fonds')
                    cb(false)
                end
            else
                -- Paiement personnel
                if HasEnoughMoney(source, finalPrice) then
                    RemoveMoney(source, finalPrice, "cash", "Vehicle Customization")
                    NotifyPlayer(source, 'Vous avez payé: $' .. finalPrice)
                    cb(true)
                else
                    NotifyPlayer(source, 'Vous n\'avez pas assez d\'argent')
                    cb(false)
                end
            end
        end)
    end)
elseif Config.Framework == "QBCore" then
    Framework.Functions.CreateCallback('custom:payModifications', function(source, cb, price)
        local playerJob = GetPlayerJob(source)
        local finalPrice = Config.PaymentFunctions.ApplyDiscount(source, price, playerJob)
        
        IsVehicleOwnedByJob(plate, function(isJobVehicle, vehicleJob)
            if isJobVehicle and playerJob == vehicleJob and Config.EnableSocietyPay then
                -- C'est un véhicule de service et le joueur a le même job
                if HasEnoughSocietyMoney(vehicleJob, finalPrice) then
                    RemoveSocietyMoney(vehicleJob, finalPrice, "Vehicle Customization")
                    NotifyPlayer(source, 'Société a payé: $' .. finalPrice)
                    cb(true)
                else
                    NotifyPlayer(source, 'La société n\'a pas assez de fonds')
                    cb(false)
                end
            else
                -- Paiement personnel
                if HasEnoughMoney(source, finalPrice) then
                    RemoveMoney(source, finalPrice, "cash", "Vehicle Customization")
                    NotifyPlayer(source, 'Vous avez payé: $' .. finalPrice)
                    cb(true)
                else
                    NotifyPlayer(source, 'Vous n\'avez pas assez d\'argent')
                    cb(false)
                end
            end
        end)
    end)
end

-- Événement pour sauvegarder les modifications du véhicule dans la base de données
RegisterServerEvent('custom:updateVehicle')
AddEventHandler('custom:updateVehicle', function(plate, props)
    local source = source
    plate = plate:gsub("%s+", "") -- Supprimer les espaces
    
    if Config.Framework == "ESX" then
        MySQL.Async.execute('UPDATE ' .. Config.Database.SaveTable .. ' SET ' .. Config.Database.ColumnVehicle .. ' = @props WHERE ' .. Config.Database.ColumnPlate .. ' = @plate', {
            ['@plate'] = plate,
            ['@props'] = json.encode(props)
        }, function(rowsChanged)
            if rowsChanged > 0 then
                NotifyPlayer(source, 'Véhicule mis à jour')
            end
        end)
    elseif Config.Framework == "QBCore" then
        MySQL.Async.execute('UPDATE ' .. Config.Database.SaveTable .. ' SET ' .. Config.Database.ColumnVehicle .. ' = @props WHERE ' .. Config.Database.ColumnPlate .. ' = @plate', {
            ['@plate'] = plate,
            ['@props'] = json.encode(props)
        }, function(rowsChanged)
            if rowsChanged > 0 then
                NotifyPlayer(source, 'Véhicule mis à jour')
            end
        end)
    end
    
    -- Synchroniser les modifications pour tous les joueurs
    TriggerClientEvent('custom:syncVehicle', -1, NetworkGetNetworkIdFromEntity(GetVehiclePedIsIn(GetPlayerPed(source), false)), props)
end)

-- Événement pour synchroniser les modifications entre tous les joueurs
RegisterServerEvent('custom:syncVehicle')
AddEventHandler('custom:syncVehicle', function(netId, props)
    TriggerClientEvent('custom:syncVehicle', -1, netId, props)
end)