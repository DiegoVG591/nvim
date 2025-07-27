return {
  "neovim/nvim-lspconfig",
  dependencies = {
  "stevearc/conform.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "j-hui/fidget.nvim",
  },

  config = function()
    -- Keymaps and other buffer-local settings.
    local on_attach = function(client, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: '.. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
      end

      -- Keymaps for LSP actions
      nmap('<leader>rn', vim.lsp.buf.rename, 'e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      nmap('gd', vim.lsp.buf.definition, '[G]otoefinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]otoeferences')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Typeefinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'ocumentymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'orkspaceymbols')
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Keymaps for diagnostics
      nmap('g[', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
      nmap('g]', vim.diagnostic.goto_next, 'Go to next diagnostic')
      nmap('<leader>e', vim.diagnostic.open_float, 'Show diagnostic [e]rror messages')
      nmap('<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [q]uickfix list')

      -- Create a command to format the buffer on demand
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end
    
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend("force", {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("fidget").setup({}) 
    require("mason").setup() 
    require("mason-lspconfig").setup({ 
      ensure_installed = { 
        "lua_ls", 
        "rust_analyzer", 
       	"gopls", 
       	"clangd", 
    	"pyright",
        "html",
        "cssls",
        "jsonls",
      },
      handlers = {
      	function(server_name)
      	  require("lspconfig")[server_name].setup {
      	    on_attach = on_attach,       -- Pass your keymaps
            capabilities = capabilities  -- Pass the cmp capabilities
      	  } 
        -- This provides the special settings needed for Unity
      	end,
        ["omnisharp"] = function()
          require("lspconfig").omnisharp.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
          }
        end,
      }
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
      	focusable = false,
      	style = "minimal",
      	border = "rounded",
      	source = "always",
      	header = "",
      	prefix = "",
      },
    })
  end,
}
