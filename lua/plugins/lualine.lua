return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    -- dump object contents
    local function dump(o)
      if type(o) == "table" then
        local s = ""
        for k, v in pairs(o) do
          if type(k) ~= "number" then
            k = '"' .. k .. '"'
          end
          s = s .. dump(v) .. ","
        end
        return s
      else
        return tostring(o)
      end
    end

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width_first = function()
        return vim.fn.winwidth(0) > 80
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 70
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }
    -- local get_hlgroup = require("core.utils").get_hlgroup
    local assets = O.icons
    local mocha = O.catppuccin_colors
    local colours = {
      bg = mocha.mantle.hex,
      black = mocha.crust.hex,
      orange = mocha.peach.hex,
      grey = mocha.overlay1.hex,
      red = mocha.red.hex,
      green = mocha.green.hex,
      yellow = mocha.yellow.hex,
      blue = mocha.blue.hex,
      mauve = mocha.mauve.hex,
      cyan = mocha.sapphire.hex,
      white = mocha.text.hex,
    }

    local mode_color = {
      n = colours.mauve,
      i = colours.green,
      v = colours.orange,
      [""] = colours.yellow,
      V = colours.yellow,
      c = colours.orange,
      no = colours.red,
      s = colours.orange,
      S = colours.orange,
      [""] = colours.red,
      ic = colours.yellow,
      R = colours.yellow,
      Rv = colours.yellow,
      cv = colours.yellow,
      ce = colours.yellow,
      r = colours.cyan,
      rm = colours.cyan,
      ["r?"] = colours.cyan,
      ["!"] = colours.red,
      t = colours.red,
    }
    return {
      options = {
        component_separators = { left = " ", right = " " },
        theme = {
          normal = {
            a = { fg = colours.fg, bg = colours.bg },
            b = { fg = colours.cyan, bg = colours.bg },
            c = { fg = colours.fg, bg = colours.bg },
            x = { fg = colours.fg, bg = colours.bg },
            y = { fg = colours.mauve, bg = colours.bg },
            z = { fg = colours.grey, bg = colours.bg },
          },
          insert = {
            a = { fg = colours.green, bg = colours.bg },
            -- a = { fg = mode_color[vim.fn.mode()], bg = colours.bg },
            z = { fg = colours.grey, bg = colours.bg },
          },
          visual = {
            a = { fg = colours.orange, bg = colours.bg },
            z = { fg = colours.grey, bg = colours.bg },
          },
          terminal = {
            a = { fg = colours.orange, bg = colours.bg },
            z = { fg = colours.grey, bg = colours.bg },
          },
        },
        globalstatus = true,
        disabled_filetypes = {
          statusline = {
            "neo-tree",
            "dashboard",
            "alpha",
            "telescope",
            "TelescopePrompt",
            "noice",
            "lazy",
            "mason",
            "qf",
            "help",
            "nofile",
            "prompt",
            "popup",
            "term",
            "toggleterm",
            "undotree",
          },
        },
      },
      sections = {
        lualine_a = {
          -- { "mode", icon = "" },
          {
            function()
              local icon
              local ok, devicons = pcall(require, "nvim-web-devicons")
              if ok then
                icon = devicons.get_icon(vim.fn.expand("%:t"))
                if icon == nil then
                  icon = devicons.get_icon_by_filetype(vim.bo.filetype)
                end
              else
                if vim.fn.exists("*WebDevIconsGetFileTypeSymbol") > 0 then
                  icon = vim.fn.WebDevIconsGetFileTypeSymbol()
                end
              end
              if icon == nil then
                icon = ""
              end
              return icon:gsub("%s+", "")
            end,
            color = function()
              return { bg = mode_color[vim.fn.mode()], fg = colours.black }
            end,
            padding = { left = 1, right = 2 },
            separator = { right = "▓▒░" },
          },
          -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ",
              readonly = " ",
              unnamed = " ",
              newfile = " ",
            },
          },
        },
        lualine_b = {
          {
            "diagnostics",
            symbols = {
              error = " " .. assets.lsp.error .. " ",
              warn = " " .. assets.lsp.warning .. " ",
              info = " " .. assets.lsp.info .. " ",
              hint = " " .. assets.lsp.hint .. " ",
            },
            colored = true,
          },
        },
        lualine_c = {
          { "searchcount", color = { bg = colours.bg, fg = colours.grey } },
        },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = colours.green },
          },
          {
            function()
              local clients = vim.lsp.get_clients()
              local clients_list = {}
              for _, client in pairs(clients) do
                if not clients_list[client.name] then
                  table.insert(clients_list, client.name)
                end
              end
              local lsp_lbl = dump(clients_list):gsub("(.*),", "%1")
              return lsp_lbl:gsub(",", ", ")
            end,
            icon = " ",
            color = { fg = colours.grey },
            padding = { left = 1, right = 1 },
            cond = conditions.hide_in_width_first,
            -- separator = { right = "▓▒░", left = "░▒▓" },
          },
          {
            "branch",
            color = { fg = colours.blue },
            icon = { assets.git.branch },
          },
          { "diff" },
        },
        lualine_y = {
          {
            "progress",
          },
          {
            "location",
            color = { fg = colours.cyan, bg = colours.bg },
          },
        },
        lualine_z = {
          function()
            return "  " .. os.date("%X") .. " 📎"
          end,
        },
      },

      extensions = { "lazy" },
    }
  end,
}
