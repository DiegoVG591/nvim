return {
  {
    "ThePrimeagen/harpoon",
    -- This is the crucial part: it tells lazy.nvim to use the new version.
    branch = "harpoon2",
    -- Harpoon needs this utility plugin to work correctly.
    dependencies = { "nvim-lua/plenary.nvim" },

    -- This config function runs after harpoon2 is loaded
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED: This sets up harpoon with the defaults
      harpoon.setup()

      -- --- Basic Keymaps ---
      -- These are the essential keymaps for adding marks and navigating them.
      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon quick menu" })

      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon to file 1" })
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "Harpoon to file 2" })
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Harpoon to file 3" })
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Harpoon to file 4" })

      -- --- Optional: Telescope Integration ---
      -- This allows you to use Telescope's fuzzy finder UI to view your harpoon marks.
      -- To use this, you must also have the telescope.nvim plugin installed.
      local telescope = require("telescope")
      telescope.load_extension("harpoon")

      vim.keymap.set("n", "<leader>h", function()
        telescope.extensions.harpoon.marks()
      end, { desc = "Show harpoon marks in Telescope" })
    end,
  },
}
