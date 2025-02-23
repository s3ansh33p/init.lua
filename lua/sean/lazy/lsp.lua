return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "zbirenbaum/copilot.lua",
    "zbirenbaum/copilot-cmp",
  },

  config = function()
    require("conform").setup({
      formatters_by_ft = {
      }
    })

    require("copilot").setup({
      panel = {
        enaable = false,
      },
      suggestion = {
        enabled = false, -- use copilot-cmp instead
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        lua = true,
        javascript = true,
        typescript = true,
        html = true,
        markdown = true,
        go = true,
        ruby = true,
        python = true,
        svelte = true,
        css = true,
        ["*"] = false,
      },
    })

    local cmp = require('cmp')
    require("copilot_cmp").setup({
      mapping = {
        ["C-e"] = cmp.mapping.abort(),
      },
    })

    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",     -- Lua
        "gopls",      -- Golang
        "solargraph", -- Ruby
        "jdtls",      -- Java
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,

        ["jdtls"] = function()
          local jdtls = require("lspconfig").jdtls
          jdtls.setup {
            capabilities = capabilities,
            settings = {
              java = {
                format = {
                  settings = {
                    url = "file://" .. vim.fn.expand("~/.config/nvim/refs/java.xml"),
                  }
                }
              }
            }
          }
        end,
      }
    })
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<leader>['] = cmp.mapping.select_prev_item(cmp_select),
        ['<leader>]'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'copilot' },
      }, {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'cmdline' },
      })
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
  end
}
