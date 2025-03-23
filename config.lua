Config = {}

-- Configuration Framework
Config.Framework = "ESX" -- "ESX" ou "QBCore"

-- Configuration ESX
Config.ESX = {
    Core = 'es_extended', -- Nom de la ressource ESX
    GetSharedObject = 'esx:getSharedObject', -- Événement pour récupérer l'objet ESX
    UseNewESX = true -- Mettre à true pour utiliser exports["es_extended"]:getSharedObject() au lieu de TriggerEvent
}

-- Configuration QBCore
Config.QBCore = {
    Core = 'qb-core', -- Nom de la ressource QBCore
}

-- Configuration des Society
Config.EnableSocietyPay = true -- Mettre à true pour activer le paiement via les sociétés
Config.SocietyAccount = 'society_' -- Préfixe du compte society (par défaut: society_)

-- Configuration de la base de données
Config.Database = {
    SaveTable = "owned_vehicles", -- Table où les véhicules personnalisés sont sauvegardés
    ColumnPlate = "plate", -- Colonne de la plaque d'immatriculation
    ColumnVehicle = "vehicle", -- Colonne contenant les propriétés JSON du véhicule
    ColumnOwner = "owner", -- Colonne contenant l'identifiant du propriétaire (ESX: identifier, QBCore: citizenid)
    SaveVehicleOnExit = true, -- Sauvegarder automatiquement les modifications à la sortie du custom shop
    SaveVehicleAfterMods = true -- Sauvegarder automatiquement après chaque modification
}

-- Configuration des positions des customs shops
Config.CustomShops = {
    { 
        pos = vector3(-333.64, -137.27, 38.57), 
        heading = 161.42, 
        blip = {
            enabled = true,
            sprite = 72,
            color = 0,
            scale = 0.8,
            name = "LS Customs - Centre Ville"
        },
        jobRestricted = false, 
        jobs = {} 
    },
    { 
        pos = vector3(-1155.53, -2007.18, 13.18), 
        heading = 342.5, 
        blip = {
            enabled = true,
            sprite = 72,
            color = 0,
            scale = 0.8,
            name = "LS Customs - Aéroport"
        },
        jobRestricted = false, 
        jobs = {} 
    },
    { 
        pos = vector3(731.81, -1088.82, 22.17), 
        heading = 270.11, 
        blip = {
            enabled = true,
            sprite = 72,
            color = 0,
            scale = 0.8,
            name = "LS Customs - Est"
        },
        jobRestricted = false, 
        jobs = {} 
    },
    { 
        pos = vector3(1175.04, 2640.22, 37.75), 
        heading = 1.5, 
        blip = {
            enabled = true,
            sprite = 72,
            color = 0,
            scale = 0.8,
            name = "LS Customs - Route 68"
        },
        jobRestricted = false, 
        jobs = {} 
    },
    { 
        pos = vector3(110.54, 6626.66, 31.79), 
        heading = 224.18, 
        blip = {
            enabled = true,
            sprite = 72,
            color = 0,
            scale = 0.8,
            name = "LS Customs - Paleto Bay"
        },
        jobRestricted = false, 
        jobs = {} 
    },
    -- Custom shop pour les mécaniciens
    { 
        pos = vector3(-211.55, -1324.55, 30.90), 
        heading = 320.0, 
        blip = {
            enabled = true,
            sprite = 446,
            color = 47,
            scale = 0.8,
            name = "Bennys Garage - Mécaniciens"
        },
        jobRestricted = true, 
        jobs = {'mechanic'} 
    }
}

-- Configuration des blips par défaut
Config.DefaultBlip = {
    Sprite = 72,
    Color = 0,
    Scale = 0.8,
    Name = 'LS Customs',
    Display = 4,
    ShortRange = true
}

-- Configuration des prix pour les catégories de performance
Config.PriceConfig = {
    Performance = {
        engine = {
            name = "Amélioration moteur",
            maxLevel = 4,
            prices = {1000, 3500, 7000, 10000}
        },
        brakes = {
            name = "Amélioration freins",
            maxLevel = 3,
            prices = {1000, 3000, 5000}
        },
        transmission = {
            name = "Amélioration transmission",
            maxLevel = 3,
            prices = {1000, 3000, 5000}
        },
        suspension = {
            name = "Amélioration suspension",
            maxLevel = 4,
            prices = {1000, 2500, 5000, 7500}
        },
        turbo = {
            name = "Turbo",
            maxLevel = 1,
            prices = {8000}
        },
        armor = {
            name = "Armure",
            maxLevel = 5,
            prices = {1000, 3000, 5000, 7000, 9000}
        }
    },
    
    -- Prix pour les extras et catégories spéciales
    WindowTint = {
        {id = -1, name = "Stock", price = 0},
        {id = 0, name = "Aucune", price = 100},
        {id = 1, name = "Pure Black", price = 500},
        {id = 2, name = "Dark Smoke", price = 400},
        {id = 3, name = "Light Smoke", price = 300},
        {id = 4, name = "Limo", price = 600},
        {id = 5, name = "Green", price = 300}
    },
    
    WheelTypes = {
        {id = 0, name = "Sport", price = 1000},
        {id = 1, name = "Muscle", price = 1000},
        {id = 2, name = "Lowrider", price = 1200},
        {id = 3, name = "SUV", price = 1000},
        {id = 4, name = "Offroad", price = 1200},
        {id = 5, name = "Tuner", price = 1500},
        {id = 6, name = "Bike", price = 800},
        {id = 7, name = "High End", price = 1800}
    },
    
    Colors = {
        primary = {price = 1000},
        secondary = {price = 800},
        pearlescent = {price = 1200},
        interior = {price = 500},
        dashboard = {price = 500}
    },
    
    PaintTypes = {
        standard = {name = "Standard", price = 500},
        metallic = {name = "Métallique", price = 700},
        pearl = {name = "Nacré", price = 1000},
        matte = {name = "Mat", price = 900},
        metal = {name = "Métal brossé", price = 1200},
        chrome = {name = "Chrome", price = 1500}
    },
    
    Neons = {
        installation = {price = 3000}, -- Prix pour l'installation de néons
        color = {price = 1000}        -- Prix pour changer la couleur des néons
    },
    
    Xenons = {
        installation = {price = 1500}, -- Prix pour l'installation de phares xenon
        color = {price = 1000}         -- Prix pour changer la couleur des xenons
    },
    
    Wheels = {
        color = {price = 300},         -- Prix pour changer la couleur des jantes
        smoke = {price = 500}          -- Prix pour activer/changer la fumée des pneus
    },
    
    Exterior = {
        basePriceMultiplier = 150      -- Prix de base = 500 + (niveau * basePriceMultiplier)
    },
    
    Interior = {
        basePriceMultiplier = 100      -- Prix de base = 300 + (niveau * basePriceMultiplier)
    },
    
    Discount = {
        -- Remises pour certains jobs
        mechanic = 0.25,               -- 25% de réduction pour les mécaniciens
        police = 0.10,                 -- 10% de réduction pour la police
        ambulance = 0.10               -- 10% de réduction pour les ambulanciers
    }
}

-- Configuration des fonctions de paiement
Config.PaymentFunctions = {
    -- Fonction pour vérifier si le joueur peut payer
    CanPlayerPay = function(playerId, amount, jobName)
        local xPlayer = ESX.GetPlayerFromId(playerId)
        
        -- Vérifier si c'est un véhicule de service et si on utilise society_pay
        if Config.EnableSocietyPay and jobName and jobName ~= 'unemployed' then
            -- Vérifier si le joueur est dans un véhicule de son job
            if xPlayer.job.name == jobName then
                -- Vérifier l'argent de la société
                local societyAccount = Config.SocietyAccount .. jobName
                
                -- Vérifier les fonds de la société
                local societyMoney = 0
                TriggerEvent('esx_addonaccount:getSharedAccount', societyAccount, function(account)
                    if account then
                        societyMoney = account.money
                    end
                end)
                
                -- Retourne true si la société peut payer
                return societyMoney >= amount
            end
        end
        
        -- Sinon, vérifier l'argent du joueur
        return xPlayer.getMoney() >= amount
    end,
    
    -- Fonction pour effectuer le paiement
    ProcessPayment = function(playerId, amount, jobName, plate)
        local xPlayer = ESX.GetPlayerFromId(playerId)
        
        -- Vérifier si c'est un véhicule de service et si on utilise society_pay
        if Config.EnableSocietyPay and jobName and jobName ~= 'unemployed' then
            -- Vérifier si le joueur est dans un véhicule de son job
            if xPlayer.job.name == jobName then
                -- Paiement via la société
                local societyAccount = Config.SocietyAccount .. jobName
                
                -- Retirer l'argent de la société
                TriggerEvent('esx_addonaccount:getSharedAccount', societyAccount, function(account)
                    if account then
                        account.removeMoney(amount)
                    end
                end)
                
                -- Informer le joueur
                TriggerClientEvent('esx:showNotification', playerId, 'Paiement effectué via la société: $' .. amount)
                return true
            end
        end
        
        -- Si ce n'est pas un véhicule de service ou society_pay est désactivé
        -- Paiement personnel
        if xPlayer.getMoney() >= amount then
            xPlayer.removeMoney(amount)
            TriggerClientEvent('esx:showNotification', playerId, 'Vous avez payé $' .. amount)
            return true
        else
            TriggerClientEvent('esx:showNotification', playerId, 'Vous n\'avez pas assez d\'argent')
            return false
        end
    end,
    
    -- Fonction pour appliquer une remise basée sur le job
    ApplyDiscount = function(playerId, amount)
        local xPlayer = ESX.GetPlayerFromId(playerId)
        local job = xPlayer.job.name
        
        -- Vérifier si le job a droit à une remise
        if Config.PriceConfig.Discount[job] then
            local discount = Config.PriceConfig.Discount[job]
            -- Calcul du montant après remise
            local discountedAmount = math.floor(amount * (1 - discount))
            
            -- Informer le joueur de la remise
            TriggerClientEvent('esx:showNotification', playerId, 'Remise de ' .. (discount * 100) .. '% appliquée')
            
            return discountedAmount
        end
        
        -- Aucune remise, retourne le montant original
        return amount
    end,
    
    -- Fonction pour calculer les prix des pièces d'extérieur
    CalculateExteriorPrice = function(level)
        return 500 + (level * Config.PriceConfig.Exterior.basePriceMultiplier)
    end,
    
    -- Fonction pour calculer les prix des pièces d'intérieur
    CalculateInteriorPrice = function(level)
        return 300 + (level * Config.PriceConfig.Interior.basePriceMultiplier)
    end
}

-- Fonction pour initialiser le framework
Config.InitFramework = function()
    if Config.Framework == "ESX" then
        if Config.ESX.UseNewESX then
            return exports[Config.ESX.Core]:getSharedObject()
        else
            local ESX = nil
            while ESX == nil do
                TriggerEvent(Config.ESX.GetSharedObject, function(obj) ESX = obj end)
                Citizen.Wait(0)
            end
            return ESX
        end
    elseif Config.Framework == "QBCore" then
        return exports[Config.QBCore.Core]:GetCoreObject()
    end
    
    print("[ERROR] Framework non pris en charge: " .. Config.Framework)
    return nil
end

-- Configuration des couleurs de l'UI
Config.UI = {
    Colors = {
        primary = "#398d75", -- Couleur principale (boutons, accents)
        secondary = "#2874a6", -- Couleur secondaire
        danger = "#c03036", -- Couleur d'annulation/erreur
        background = "rgba(2, 2, 2, .7)", -- Couleur de fond principal
        backgroundSecondary = "rgba(2, 2, 2, .4)", -- Couleur de fond secondaire
        text = "#ffffff", -- Couleur du texte principal
        textSecondary = "#e7e7e7cb", -- Couleur du texte secondaire
        border = "#fdfdfe", -- Couleur des bordures
        highlight = "#2874a680", -- Couleur de surbrillance pour les éléments sélectionnés
        success = "#388c5a" -- Couleur de succès (prix, validation)
    },
    Icons = {
        type = "image", -- "fontawesome" ou "image"
        performance = "nui://custom/png/fshop.png",
        interior = "nui://custom/png/fshop.png",
        exterior = "fa-car",
        color = "fa-palette",
        wheels = "fa-dharmachakra", -- Notez que dans le JS c'est "roues-btn" qui utilise cette icône
        extras = "fa-plus",
        doors = "nui://custom/png/fshop.png", -- Notez que dans le JS c'est "portes-btn" qui utilise cette icône
        confirm = "fa-check",
        cancel = "fa-times"
    },
    Animations = {
        enable = true, -- Activer/désactiver les animations
        duration = 200 -- Durée des animations en ms
    },
    Logo = {
        enabled = true,
        url = "nui://custom/png/fshop.png", -- URL de votre logo
        width = 53,
        height = 53
    }
}