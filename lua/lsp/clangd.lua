require'lspconfig'.clangd.setup {
    cmd = {DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd",
	    	"--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu"},
    on_attach = Custom_attach
}
