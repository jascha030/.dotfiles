local alpha = require('alpha')
local startify = require('alpha.themes.startify')

startify.section.header.val = {
    [[  ooooo      ooo oooooo     oooo ooooo ooo        ooooo  ]],
    [[  `888b.     `8'  `888.     .8'  `888' `88.       .888'  ]],
    [[   8 `88b.    8    `888.   .8'    888   888b     d'888   ]],
    [[   8   `88b.  8     `888. .8'     888   8 Y88. .P  888   ]],
    [[   8     `88b.8      `888.8'      888   8  `888'   888   ]],
    [[   8       `888       `888'       888   8    Y     888   ]],
    [[  o8o        `8        `8'       o888o o8o        o888o  ]],
}
-- layout =
--     {
--         { type = 'padding', val = 1 },
--         section.header,
--         { type = 'padding', val = 2 },
--         section.top_buttons,
--         section.mru_cwd,
--         section.mru,
--         { type = 'padding', val = 1 },
--         section.bottom_buttons,
--         section.footer,
--     },
alpha.setup(startify.opts)
