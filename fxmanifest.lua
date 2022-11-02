fx_version "cerulean"
game "gta5"

author "alcapone"
description "ls-radio Modified by Plactrix"
version "1.0.0"
lua54 "yes"

files {
  "html/ui.html",
  "html/js/script.js",
  "html/css/style.css",
  "html/img/cursor.png",
  "html/img/radio.png"
}

ui_page "html/ui.html"

shared_scripts {
  "config.lua"
}

client_scripts {
  "client/cl_*.lua"
}

server_scripts {
  "server/server.lua"
}
