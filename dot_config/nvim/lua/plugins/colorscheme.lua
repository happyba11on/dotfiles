return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
      on_highlights = function(hl, c)
        hl.Function = { fg = c.blue, bold = true }
        hl.Method = { fg = c.blue, bold = true }
        hl.Type = { fg = c.yellow }
        hl.Keyword = { fg = c.magenta, italic = true }
        hl.String = { fg = c.green }
        hl.Comment = { fg = c.comment, italic = true }
        hl["@parameter"] = { fg = c.orange }
        hl["@property"] = { fg = c.teal }
        hl["@variable.member"] = { fg = c.teal }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
