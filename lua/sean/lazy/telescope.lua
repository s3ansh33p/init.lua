return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.8",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
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
      extentions = {
        live_grep_args = {
          auto_quoting = true,
        },
      },
    })

    require('telescope').load_extension('live_grep_args')

    local builtin = require('telescope.builtin')
    local live_grep_args = require('telescope').extensions.live_grep_args

    vim.keymap.set('n', '<C-f>', builtin.find_files, {})
    vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    -- vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>pg', live_grep_args.live_grep_args, {})
  end
}
