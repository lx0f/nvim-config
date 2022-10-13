local ok, mason_null_ls = pcall(require, "mason-null-ls")
if not ok then
	return
end
mason_null_ls.setup({})
mason_null_ls.setup_handlers({
	function(source_name)
		local null_ls_avail, null_ls = pcall(require, "null-ls")
		if null_ls_avail then
			if null_ls.is_registered(source_name) then
				return
			end
			for _, type in ipairs({ "diagnostics", "formatting", "code_actions", "completion", "hover" }) do
				local builtin = require("null-ls.builtins._meta." .. type)
				if builtin[source_name] then
					null_ls.register(null_ls.builtins[type][source_name])
				end
			end
		end
	end,
})
