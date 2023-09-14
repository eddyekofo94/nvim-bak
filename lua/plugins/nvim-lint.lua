return {
  "mfussenegger/nvim-lint",
  event = "BufReadPost",
  config = function()
    require("lint").linters_by_ft = {
      markdown = { "vale" },
      go = { "golangcilint" },
    }
  end,
}
