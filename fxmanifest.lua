fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'kevin-dialogue'
version '1.0'

-- shared_scripts {
--     'config.lua',
--     '@ox_lib/init.lua',
-- }

client_script {
    'client/*.lua',
}

ui_page 'ui/html/index.html'

files {
    'ui/html/*',
    'ui/html/index.html',
    'ui/html/index.css',
    'ui/html/index.js',
}
