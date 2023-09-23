--  INFO: 2023-09-23 - not sure if this is working
--  INFO: 2023-09-23 - https://github.com/mfussenegger/nvim-lint

return {
  "mfussenegger/nvim-lint",
  config = function()
    require("lint").linters_by_ft = {
      markdown = { "vale" },
      go = { "golint" },
      lua = { "luacheck" },
      cpp = { "clang-tidy" },
      sh = { "shellcheck" },
      yaml = { "yamllint" },
    }
  end,
}
