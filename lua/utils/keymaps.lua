local M = {}
local cmd = vim.api.nvim_create_user_command

cmd('Reconfuse', function()
    _G.confusing_maps = true
end, { desc = 'Remove confusing map', force = true })

cmd('Unconfuse', function()
    _G.confusing_maps = false
end, { desc = 'Remove confusing map', force = true })

M.confusing = function(modes, k, v, opts)
    _G.confusing_maps_set = _G.confusing_maps_set or {}
    _G.confusing_maps_set[k] = { map = vim.inspect(v), desc = opts.desc }
    if type(opts.desc) == 'string' then
        opts.desc = 'confusing: ' .. opts.desc
    end
    vim.keymap.set(modes, k, function()
        if _G.confusing_maps ~= false then
            if type(v) == 'function' then
                local ok, val = pcall(v)
                return opts.expr and ok and val or ''
            else
                return v
            end
        else
            return k
        end
    end, opts)
end
return M
