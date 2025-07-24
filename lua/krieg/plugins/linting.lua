return {
  "mfussenegger/nvim-lint",
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      lua = { "selene" },
      go = { "golangci-lint" },
      c = { "cppcheck" },
      cpp = { "cppcheck" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      python = { "flake8" },
      html = { "tidy" },
      css = { "stylelint" },
      json = { "jsonlint" },
    }

    -- Create an autocommand to run the linter on specified events
    local lint_augroup = vim.api.nvim_create_augroup("LinterGroup", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
