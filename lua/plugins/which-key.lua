return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
  },
  config = function()
    require("which-key").setup({ plugins = { presets = { operators = false } } })
    local Util = require("utils")

    local wk = require("which-key")

    local leader_mappings = {
      b = {
        name = "+Buffers",

        b = {
          function()
            require("telescope.builtin").buffers({ sort_lastused = true })
          end,
          "list buffers",
        },
        x = { "<cmd>BufOnly<CR>", "Close all buffers but current" },
      },
      c = {
        name = "+Coding",
        b = { "<cmd>Build<cr>", "Build code" },
        r = { "<cmd>Run<cr>", "Run code" },
        R = { "<cmd>RunAll<cr>", "Build&Run" },
        a = { "<cmd>GoCodeAction<cr>", "Code action" },
        e = { "<cmd>GoIfErr<cr>", "Add if err" },
        h = {
          name = "Helper",
          a = { "<cmd>GoAddTag<cr>", "Add tags to struct" },
          r = { "<cmd>GoRMTag<cr>", "Remove tags to struct" },
          c = { "<cmd>GoCoverage<cr>", "Test coverage" },
          g = { "<cmd>lua require('go.comment').gen()<cr>", "Generate comment" },
          v = { "<cmd>GoVet<cr>", "Go vet" },
          t = { "<cmd>GoModTidy<cr>", "Go mod tidy" },
          i = { "<cmd>GoModInit<cr>", "Go mod init" },
        },
        i = { "<cmd>GoToggleInlay<cr>", "Toggle inlay" },
        j = { "<cmd>'<,'>GoJson2Struct<cr>", "Json to struct" },
        l = { "<cmd>GoLint<cr>", "Run linter" },
        o = { "<cmd>GoPkgOutline<cr>", "Outline" },
        s = { "<cmd>GoFillStruct<cr>", "Autofill struct" },
        t = {
          name = "Tests",
          r = { "<cmd>GoTest<cr>", "Run tests" },
          a = { "<cmd>GoAlt!<cr>", "Open alt file" },
          s = { "<cmd>GoAltS!<cr>", "Open alt file in split" },
          v = { "<cmd>GoAltV!<cr>", "Open alt file in vertical split" },
          u = { "<cmd>GoTestFunc<cr>", "Run test for current func" },
          f = { "<cmd>GoTestFile<cr>", "Run test for current file" },
        },
        x = {
          name = "Code Lens",
          l = { "<cmd>GoCodeLenAct<cr>", "Toggle Lens" },
          a = { "<cmd>GoCodeAction<cr>", "Code Action" },
        },
      },
      d = {
        name = "+diagnostics",
        d = { "<cmd>Telescope diagnostics<cr>", "diagnostics" },
        n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "diagnostics next" },
        p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "diagnostics prev" },
        t = { "<cmd>TroubleToggle<cr>", "trouble" },
        w = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
      },
      g = {
        name = "+Git",
      },
      l = {
        name = "+lsp",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" },
        A = { "<cmd>lua vim.lsp.buf.range_code_action()<cr>", "selected action" },
        d = {
          "<cmd>Glance definitions<cr>",
          "definitions",
        },
        D = { "<cmd>Glance type_definitions<cr>", "type definitions" },
        f = { "<cmd>lua vim.lsp.buf.format()<CR>", "format" },
        h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "signature help" },
        i = { "<cmd>Glance implementations<cr>", "implementations" },
        I = { "<cmd>LspInfo<cr>", "lsp info" },
        p = { "<cmd>lua vim.diagnostic.open_float()<cr>", "preview definition" },
        q = { "<cmd>Telescope quickfix<cr>", "quickfix" },
        r = { "Rename" },
        R = { "<cmd>Glance references<cr>", "References" },
        T = { "<cmd>LspTypeDefinition<cr>", "type definition" }, -- TODO: fix this in the future
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "document symbols" },
        S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "workspace symbols" },
      },
      s = {
        name = "search", -- normally using Telescope
        c = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "search current buffer" },
        d = { "<cmd>Telescope diagnostics<cr>", "diagnostics" },
        F = { "<cmd>Telescope frecency<cr>", "frecency" },
        n = { "<cmd>NoiceTelescope<cr>", "noice" },
        m = { "<cmd>Telescope marks<cr>", "marks" },
        M = { "<cmd>Telescope man_pages<cr>", "man_pages" },
        p = {
          -- TODO: learn how to create projects
          "<cmd>lua require'telescope'.extensions.project.project{}<cr>",
          "projects",
        },
        T = { "<cmd>TodoTelescope<cr>", "TODO" },
        u = { "<cmd>Telescope colorscheme<cr>", "colorschemes" },
        z = { "<cmd>Telescope zoxide list<cr>", "zoxide" },
      },
      S = {
        name = "+Session",
        s = {
          "<cmd>SessionSave<cr>",
          "Save Session",
        },
        r = {
          "<cmd>SessionLoad<cr>",
          "Restore Load",
        },
        l = {
          '<cmd>lua require("persistence").load({ last = true })<cr>',
          "Restore Last Session",
        },
        x = {
          "<cmd>SessionDelete<cr>",
          "Don't Save Current Session",
        },
      },
      t = {
        name = "+Terminal",
      },
      ["~"] = { "<cmd>NvimTreeRefresh<cr>", "refresh tree" },
      h = { ':let @/ = ""<cr>', "Clear Highlight" },
      M = { "<cmd>Mason<cr>", "Mason" },
      N = { "<cmd>Noice<cr>", "Noice" },
      F = { "<cmd>FormatWrite<cr>", "Format & Save File" },
      L = { "<cmd>Lazy<cr>", "Lazy" },
      o = {
        name = "Add line below",
        o = {
          ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>',
          "inset line",
        },
      },
      O = {
        name = "Add line above",
        O = {
          ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',
          "inset line",
        },
      },
      P = {
        "<cmd>lua require'telescope'.extensions.project.project{}<cr>",
        "Find Project",
      },
      U = { "<cmd>UndotreeShow<cr>", "Undotree show" },
      W = { "<C-W>q", "Close Window" },
      x = {
        name = "Debugger",
      },
      z = { "<cmd>ZenMode<cr>", "zen mode" },
    }

    wk.register(leader_mappings, { prefix = "<leader>" })
  end,
}
