local maps = {
	i = {},
	n = {},
	v = {},
	t = {},
	[""] = {},
}

maps[""]["<Space>"] = "<Nop>"

-- Normal --
maps.n["<leader>e"] = {
	function()
		vim.cmd([[ e . ]])
	end,
	desc = "Open Netrw in split",
}

maps.n["<leader>vs"] = {
	function()
		vim.cmd([[ vsplit ]])
	end,
	desc = "Split window vertically",
}

maps.n["<leader>hs"] = {
	function()
		vim.cmd([[ split ]])
	end,
	desc = "Split window horizontally",
}

maps.n["<leader>c"] = {
	function()
		vim.cmd([[ close ]])
	end,
	desc = "Close window",
}

maps.n["<leader>h"] = {
	function()
		vim.cmd([[ nohlsearch ]])
	end,
	desc = "Clear highlight",
}

maps.n["<C-h>"] = {
	"<C-w>h",
	desc = "Move to left split",
}
maps.n["<C-j>"] = {
	"<C-w>j",
	desc = "Move to below split",
}
maps.n["<C-k>"] = {
	"<C-w>k",
	desc = "Move to above split",
}
maps.n["<C-l>"] = {
	"<C-w>l",
	desc = "Move to right split",
}

-- GitSigns
maps.n["<leader>gj"] = {
	function()
		require("gitsigns").next_hunk()
	end,
	desc = "Next git hunk",
}
maps.n["<leader>gk"] = {
	function()
		require("gitsigns").prev_hunk()
	end,
	desc = "Previous git hunk",
}
maps.n["<leader>gl"] = {
	function()
		require("gitsigns").blame_line()
	end,
	desc = "View git blame",
}
maps.n["<leader>gp"] = {
	function()
		require("gitsigns").preview_hunk()
	end,
	desc = "Preview git hunk",
}

-- Telescope
maps.n["<leader>fw"] = {
	function()
		require("telescope.builtin").live_grep()
	end,
	desc = "Search words",
}
maps.n["<leader>fW"] = {
	function()
		require("telescope.builtin").live_grep({
			additional_args = function(args)
				return vim.list_extend(args, { "--hidden", "--no-ignore" })
			end,
		})
	end,
	desc = "Search words in all files",
}
maps.n["<leader>gt"] = {
	function()
		require("telescope.builtin").git_status()
	end,
	desc = "Git status",
}
maps.n["<leader>gb"] = {
	function()
		require("telescope.builtin").git_branches()
	end,
	desc = "Git branches",
}
maps.n["<leader>gc"] = {
	function()
		require("telescope.builtin").git_commits()
	end,
	desc = "Git commits",
}
maps.n["<leader>ff"] = {
	function()
		require("telescope.builtin").find_files()
	end,
	desc = "Search files",
}
maps.n["<leader>fF"] = {
	function()
		require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
	end,
	desc = "Search all files",
}
maps.n["<leader>fb"] = {
	function()
		require("telescope.builtin").buffers()
	end,
	desc = "Search buffers",
}
maps.n["<leader>fh"] = {
	function()
		require("telescope.builtin").help_tags()
	end,
	desc = "Search help",
}
maps.n["<leader>fm"] = {
	function()
		require("telescope.builtin").marks()
	end,
	desc = "Search marks",
}
maps.n["<leader>fo"] = {
	function()
		require("telescope.builtin").oldfiles()
	end,
	desc = "Search history",
}
maps.n["<leader>fc"] = {
	function()
		require("telescope.builtin").grep_string()
	end,
	desc = "Search for word under cursor",
}
maps.n["<leader>sb"] = {
	function()
		require("telescope.builtin").git_branches()
	end,
	desc = "Git branches",
}
maps.n["<leader>sh"] = {
	function()
		require("telescope.builtin").help_tags()
	end,
	desc = "Search help",
}
maps.n["<leader>sm"] = {
	function()
		require("telescope.builtin").man_pages()
	end,
	desc = "Search man",
}
maps.n["<leader>sn"] = {
	function()
		require("telescope").extensions.notify.notify()
	end,
	desc = "Search notifications",
}
maps.n["<leader>sr"] = {
	function()
		require("telescope.builtin").registers()
	end,
	desc = "Search registers",
}
maps.n["<leader>sk"] = {
	function()
		require("telescope.builtin").keymaps()
	end,
	desc = "Search keymaps",
}
maps.n["<leader>sc"] = {
	function()
		require("telescope.builtin").commands()
	end,
	desc = "Search commands",
}
maps.n["<leader>ls"] = {
	function()
		local aerial_avail, _ = pcall(require, "aerial")
		if aerial_avail then
			require("telescope").extensions.aerial.aerial()
		else
			require("telescope.builtin").lsp_document_symbols()
		end
	end,
	desc = "Search symbols",
}
maps.n["<leader>lG"] = {
	function()
		require("telescope.builtin").lsp_workspace_symbols()
	end,
	desc = "Search workspace symbols",
}
maps.n["<leader>lR"] = {
	function()
		require("telescope.builtin").lsp_references()
	end,
	desc = "Search references",
}
maps.n["<leader>lD"] = {
	function()
		require("telescope.builtin").diagnostics()
	end,
	desc = "Search diagnostics",
}

-- Stay in indent mode
maps.v["<"] = { "<gv", desc = "unindent line" }
maps.v[">"] = { ">gv", desc = "indent line" }

for mode, mapping in pairs(maps) do
	for keymap, options in pairs(mapping) do
		if options then
			local cmd = options
			local keymap_opts = {}
			if type(options) == "table" then
				cmd = options[1]
				keymap_opts = vim.tbl_deep_extend("force", options, keymap_opts)
				keymap_opts[1] = nil
			end
			vim.keymap.set(mode, keymap, cmd, keymap_opts)
		end
	end
end
