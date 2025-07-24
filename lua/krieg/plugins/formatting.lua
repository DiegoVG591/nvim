return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      go = { "gofumpt" },
      csharp = { "csharpier" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      python = { "isort", "black" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
    }, 
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback", -- Fallback to LSP formatter if no conform formatter is found
    },
  },
}
