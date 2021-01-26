local format  = require('format')

format.setup {
    ["*"] = {
        {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
    },
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
