local function git_blame()
	local blame = vim.b.gitsigns_blame_line

	if blame == nil or blame == "" then
		return ""
	end

	return blame
end
return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "tokyonight",
				globalstatus = true,
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						path = 1,
						symbols = {
							modified = " [+]",
							readonly = " [lock]",
							unnamed = "[No Name]",
						},
					},
				},
				lualine_x = { {
                    git_blame,
                    cond = function()
                        return vim.b.gitsigns_blame_line ~= nil and vim.b.gitsigns_blame_line ~= ""
                    end,
                }, "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		},
	},
}
