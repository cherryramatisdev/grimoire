return {
  'nvim-telescope/telescope.nvim',
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = "close",
          ["<c-l>"] = "to_fuzzy_refine",
          ["<C-h>"] = "which_key"
        }
      }
    },
  },
  keys = {
    { "<c-p>", ":Telescope find_files<cr>" },
    { "<c-f>", ":Telescope live_grep<cr>" },
    { "<c-b>", ":Telescope buffers<cr>" },
  }
}
