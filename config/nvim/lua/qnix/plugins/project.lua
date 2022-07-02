return {
  plug = function(use)
    use {
      "ahmedkhalf/project.nvim",
      --- TODO
      -- opt = true,
      -- cmd = {
      --
      -- },
      requires = { "nvim-telescope/telescope.nvim" },
      config = function()
        require("project_nvim").setup {
          update_cwd = true,
          update_focused_file = {
            enable = true,
            update_cwd = true,
          },
          silent_chdir = false,
        }
        require("telescope").load_extension "projects"
        --- TODO
        -- vim.cmd [[command! Projects Telescope projects]]
      end
    }
  end
}
