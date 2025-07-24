return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text", -- Optional: for inline variable display
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    -- Automatically install and set up adapters
    require("mason-nvim-dap").setup({
      ensure_installed = { -- Add other languages here
	"lua-dap", -- Lua
	"debugpy", -- Python
        "delve", -- Go
        "codelldb", -- C++, Rust
        "js-debug-adapter", -- TypeScript, JavaScript
        "netcoredbg", -- C#
      },
      automatic_setup = true,
    })
    -- Configure the DAP UI
    dapui.setup({
      layouts = {
        {
          elements = { "scopes", "breakpoints", "stacks", "watches" },
          size = 40,
          position = "left",
        },
        {
          elements = { "repl", "console" },
          size = 10,
          position = "bottom",
        },
      },
    })
    -- Configure nvim-dap-virtual-text
    require("nvim-dap-virtual-text").setup()
    -- Automatically open and close the UI when a debug session starts/ends
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
