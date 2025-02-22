return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.8",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".git",
          ".cache",
        },
      },
    })

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<C-f>', builtin.find_files, {})
    vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
  end
}

