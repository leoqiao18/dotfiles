return {
  plug = function(use)
    use {
      "windwp/nvim-autopairs",
      config = function()
        local Rule = require('nvim-autopairs.rule')
        local npairs = require("nvim-autopairs")

        npairs.setup({
          check_ts = true,
          disable_filetype = { "txt" },
          ts_config = {
            lua = { "string" }, -- it will not add pair on that treesitter node
            javascript = { "template_string" },
          },
        })
      end
    }
  end
}
