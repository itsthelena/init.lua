
-- ensure the packer plugin manager is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- plugins installieren
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'neovim/nvim-lspconfig'
    use 'jose-elias-alvarez/null-ls.nvim'
    use "windwp/nvim-autopairs"
end)

vim.cmd('colorscheme catppuccin-macchiato')
vim.cmd('set mouse=a')

-- python lsp automatisch starten wenn python datei geoffnet wird
require'lspconfig'.pyright.setup{}

-- klammern automatisch schliessen
require("nvim-autopairs").setup {}

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
    },
})

-- the first run will install packer and our plugins
if packer_bootstrap then
    require("packer").sync()
    return
end



