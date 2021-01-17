require('plenary.reload').reload_module("snippets")

local snip_plug = require('snippets')
local indent = require('snippets.utils').match_indentation

local snips = {}

snips._global = {
  ["todo"] = "TODO(eddyekofo): ",
  ["date"] = [[${=os.date("%Y-%m-%d")}]],
  ["rs"] = [[${=RandomString(25)}]],
}

snips.json = {
  testEntry = [[, {"text": "$1"}]],
  i = [["$1": "$2"]],
  e = [[, {"text": "$1: ${=RandomString(25)}", "score": $1}]],
}

snip_plug.snippets = snips
snip_plug.use_suggested_mappings()

-- TODO: Investigate this again.
require'snippets'.set_ux(require'snippets.inserters.floaty')

function RandomString(length)
    if not length or length <= 0 then return '' end
    math.randomseed(os.clock()^5)
    return RandomString(length - 1) .. charset[math.random(1, #charset)]
end
