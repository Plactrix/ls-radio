fx_version "cerulean"
game "gta5"

author "alcapone"
description "ls-radio Modified by Plactrix"
version "1.0.1"
lua54 "yes"

dependencies {
  "tokovoip_script",
  "mythic_notify"
}

files {
  "html/ui.html",
  "html/js/script.js",
  "html/css/style.css",
  "html/img/cursor.png",
  "html/img/radio.png"
}

ui_page "html/ui.html"

client_scripts {
  "config.lua",
  "client/cl_*.lua"
}
