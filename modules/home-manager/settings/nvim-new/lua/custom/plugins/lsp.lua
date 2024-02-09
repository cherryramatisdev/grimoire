return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "folke/neodev.nvim",       opts = {} },
    { "williamboman/mason.nvim", opts = {} },
    {
      "jose-elias-alvarez/null-ls.nvim",
      opts = function()
        local null_ls = require "null-ls"
        return {
          sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.formatting.prettierd,
          },
        }
      end,
    },
  },
  config = function()
    local lspconfig = require "lspconfig"
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    }

    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })
  end,
}
