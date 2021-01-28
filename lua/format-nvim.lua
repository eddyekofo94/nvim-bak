local format  = require('format')

format.setup {
    fish = {
        {
            cmd = {"fish_indent -w"}
        }
    },
    json = {
        {
            cmd = {"execute '%!python -m json.tool' | w  "}
        }
    },
    rust = {
        {
            cmd = {"rustfmt"}
        }
    }
}
