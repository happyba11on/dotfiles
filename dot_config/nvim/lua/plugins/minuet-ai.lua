return {
	"milanglacier/minuet-ai.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Minuet",
	config = function()
		require("minuet").setup({
			provider = "openai_fim_compatible",

			virtualtext = {
				auto_trigger_ft = {},
				keymap = {
					accept = "<C-y>",
					accept_line = "<C-l>",
					dismiss = "<C-e>",
					next = "<C-n>",
					prev = "<C-p>",
				},
			},

			provider_options = {
				openai_fim_compatible = {
					api_key = "DEEPSEEK_API_KEY",
					name = "DeepSeek",
					model = "deepseek-v4-flash",
					end_point = "https://api.deepseek.com/beta/completions",
					stream = true,
					optional = {
						max_tokens = 256,
						top_p = 0.9,
						stop = { "\n\n" },
					},
				},
			},
		})
	end,
}
