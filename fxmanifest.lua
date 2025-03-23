
-- YA RIEN A VOLER TOUT EST CRYPTER :)
-- MON DISCORD: so_213 & https://discord.gg/fshop

fx_version("cerulean")
game("gta5")

lua54 "yes"

escrow_ignore { 'config.lua' }

ui_page("ui.html")

files {"ui.html", "ui.js", "ui.css", "png/*.png",}

client_scripts {
	"client/*.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
	"server/*.lua",
}

shared_scripts {
    "config.lua",
}