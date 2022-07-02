local M = {}

function M.config()
  require('bufferline').setup {
    options = {
      diagnostics = "nvim_lsp",
      -- diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "("..count..")"
      end,
      offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
    }
  }
end

function M.plug(use)
  plug = function(use)
    use {
      "akinsho/bufferline.nvim",
      after = { "theme" },
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("qnix.plugins.bufferline").config()
      end
    }
  end
end

return M
