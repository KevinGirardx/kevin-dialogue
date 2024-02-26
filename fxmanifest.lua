fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'kevin-dialogue'
version '1.0'

shared_scripts {
    '@ox_lib/init.lua',
}

client_script {
    'client/*.lua',
}

ui_page 'html/index.html'

files {
    'html/**',
	'ui/**',
}

