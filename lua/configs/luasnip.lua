local loader_avail, loader = pcall(require, "luasnip/loaders/from_vscode")
if loader_avail then
    loader.lazy_load()
end
local luasnip_avail, luasnip = pcall(require, "luasnip")
