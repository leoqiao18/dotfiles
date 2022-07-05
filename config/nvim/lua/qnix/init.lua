local M = {}

local fn = vim.fn

--- Entry point to my Neovim configuration.
---
--- Called from init.lua.
function M.setup()
  M.setup_plugins()
  M.setup_keybinds()
end

--- Ensure Packer is installed, and use it to setup my plugins.
function M.setup_plugins()
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  end

  return require('packer').startup(function(use)
    use { "wbthomason/packer.nvim" }
    use { "lewis6991/impatient.nvim" }

    -- Automatically require any plugin module in ~/.config/nvim/lua/qnix/plugins/
    for _, p in ipairs(
      fn.split(fn.glob((fn.stdpath "config") .. "/lua/qnix/plugins/*"))
    ) do
      p = fn.substitute(p, "^.*/", "", "")
      p = fn.substitute(p, "\\.lua$", "", "")
      require("qnix.plugins." .. p).plug(use)
    end

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end)
end

--- Neovim-specific keybindings that aren't associated with any specific plugin.
---
--- This depends on folke/which-key.nvim, so this is invoked after that is setup.
function M.setup_keybinds()

end

--- Define key mappings.
---
--- This is a thin wrapper around folke/which-key.nvim, and (for now) serves as
--- a layer of indirection so that I don't have direct dependencies to that
--- plugin strewn across my config.
M.map = function(mappings, opt, override_opt)
  opt = opt or {}
  override_opt = override_opt or {}
  require("which-key").register(
    mappings,
    vim.tbl_extend("force", opt, override_opt)
  )
end

--- Define normal mode mappings.
---
---@see pokerus.map
M.nmap = function(mappings, opt)
  -- M.map(mappings, opt, { mode = "n" })
  M.map(mappings, opt, {})
end

--- Define insert mode mappings.
---
---@see pokerus.map
M.imap = function(mappings, opt)
  M.map(mappings, opt, { mode = "i" })
end

--- Define visual and select mode mappings.
---
---@see pokerus.map
M.vmap = function(mappings, opt)
  M.map(mappings, opt, { mode = "v" })
end

--- Define visual mode mappings.
---
---@see pokerus.map
M.xmap = function(mappings, opt)
  M.map(mappings, opt, { mode = "x" })
end

--- Define select mode mappings.
---
---@see pokerus.map
M.smap = function(mappings, opt)
  M.map(mappings, opt, { mode = "s" })
end

--- Define operator-pending mode mappings.
---
---@see pokerus.map
M.omap = function(mappings, opt)
  M.map(mappings, opt, { mode = "o" })
end

return M
