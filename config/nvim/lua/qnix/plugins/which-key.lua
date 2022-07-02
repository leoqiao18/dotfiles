local M = {}

function M.config()
  local wk = require("which-key")

  wk.setup ({})

  wk.register({
    [" "] = { "<cmd>lua require('qnix.lib').project_files()<cr>", "Browse files" },
    -- [" "] = { "<cmd>Telescope find_files hidden=true<cr>", "Browse files" },
    -- [" "] = { [[<cmd>lua (function() local opts = {hidden=true} local ok = pcall(require"telescope.builtin".git_files, opts) if not ok then require"telescope.builtin".find_files(opts) end end)()<cr>]], "Project files" },
    [":"] = { "<cmd>Telescope commands<cr>", "Browse commands" },
    ["/"] = { "<cmd>Telescope live_grep<cr>", "Live grep" },
    f = {
      name = "file",
      a = { "<cmd>Telescope live_grep<cr>", "Find word" },
      b = { "<cmd>Telescope file_browser hidden=true<cr>", "File browser" },
      f = { "<cmd>Telescope find_files hidden=true<cr>", "Find file" },
      M = { "<cmd>Telescope marks<cr>", "Find bookmarks" },
      n = { "<cmd>enew<cr>", "New file" },
      r = { "<cmd>Telescope oldfiles<cr>", "Browse recent files" },
      t = { "<cmd>NvimTreeToggle<cr>", "Toggle tree" },
      s = { "<cmd>w<cr>", "Save file" },
      S = { "<cmd>wa<cr>", "Save all" },
    },
    w = {
      name = "window",
      h = { "<cmd>wincmd h<cr>", "Go left" },
      j = { "<cmd>wincmd j<cr>", "Go down" },
      k = { "<cmd>wincmd k<cr>", "Go up" },
      l = { "<cmd>wincmd l<cr>", "Go right" },
      H = { "<cmd>wincmd H<cr>", "Move left" },
      J = { "<cmd>wincmd J<cr>", "Move down" },
      K = { "<cmd>wincmd K<cr>", "Move up" },
      L = { "<cmd>wincmd L<cr>", "Move right" },
      s = { "<cmd>sp<cr>", "Split horizontal" },
      v = { "<cmd>vs<cr>", "Split vertical" },
      d = { "<cmd>wincmd q<cr>", "Delete window" },
      ["+"] = { "<cmd>wincmd +<cr>", "Increase height" },
      ["-"] = { "<cmd>wincmd -<cr>", "Decrease height" },
      [">"] = { "<cmd>wincmd <<cr>", "Increase width" },
      ["<"] = { "<cmd>wincmd ><cr>", "Decrease width" },
      ["|"] = { "<cmd>wincmd |<cr>", "Max width" },
      ["="] = { "<cmd>wincmd =<cr>", "Equal height and width" },
    },
    b = {
      name = "buffer",
      b = { "<cmd>Telescope buffers<cr>", "Browse buffer" },
      p = { "<cmd>bp<cr>", "Previous buffer" },
      n = { "<cmd>bn<cr>", "Next buffer" },
      d = { "<cmd>bd<cr>", "Delete buffer" },
    },
    q = {
      name = "editor",
      q = { "<cmd>qa<cr>", "Quit editor" },
      r = { "<cmd>source $MYVIMRC<cr>", "Reload config" },
    },
    c = {
      name = "code",
      d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Jump to definition" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format buffer" },
      h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover information" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "List implementations" },
      n = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol" },
      r = { "<cmd>lua vim.lsp.buf.references()<cr>", "List references" },
      t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Jump to type definition" },
    },
    u = {
      name = "ui",
      c = { "<cmd>Telescope colorscheme<cr>", "Change colorscheme" },
      l = { "<cmd>set list!<cr>", "Toggle listchars" },
      w = { "<cmd>lua require('qnix.lib').toggle_wrap()<cr>", "Toggle wrap" },
      z = { "<cmd>ZenMode<cr>", "Toggle zen mode" },
    },
    e = {
      name = "error",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
      e = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Show error" },
      h = { "<cmd>lua vim.diagnostic.hide()<cr>", "Hide errors" },
      H = { "<cmd>lua vim.diagnostic.show()<cr>", "Unhide errors" },
      l = { "<cmd>TroubleToggle<cr>", "List errors" },
      n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next error" },
      p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev error" },
      t = { "<cmd>TodoTelescope<cr>", "Browse todos" },
    },
    g = {
      name = "git",
      f = { "<cmd>Telescope git_files<cr>", "Find git files" },
      g = { "<cmd>Git<cr>", "Fugitive" },
      s = { "<cmd>Telescope git_status<cr>", "Browse git status" },
      b = { "<cmd>Telescope git_branches<cr>", "Browse git branches" },
      l = { "<cmd>Telescope git_commits<cr>", "Browse git commits" },
    },
    p = {
      name = "proof",
      s = { "<cmd>CoqStart<cr>", "CoqStart" },
      q = { "<cmd>CoqStop<cr>", "CoqStop" },
      j = { "<cmd>CoqNext<cr>", "CoqNext" },
      k = { "<cmd>CoqUndo<cr>", "CoqUndo" },
      l = { "<cmd>CoqToLine<cr>", "CoqToLine" },
      t = { "<cmd>CoqToTop<cr>", "CoqToTop" },
      G = { "<cmd>CoqJumpToEnd<cr>", "CoqJumpToEnd" },
      e = { "<cmd>CoqJumpToError<cr>", "CoqJumpToError" },
      d = { ":CoqGotoDef <C-r>=coqtail#util#getcurword()<cr><cr>", "CoqGotoDef" },

      h = { ":Coq Check <C-r>=coqtail#util#getcurword()<cr><cr>", "CoqCheck" },
      a = { ":Coq About <C-r>=coqtail#util#getcurword()<cr><cr>", "CoqAbout" },
      p = { ":Coq Print <C-r>=coqtail#util#getcurword()<cr><cr>", "CoqPrint" },
      f = { ":Coq Locate <C-r>=coqtail#util#getcurword()<cr><cr>", "CoqLocate" },
      ['/'] = { ":Coq Search <C-r>=coqtail#util#getcurword()<cr><cr>", "CoqSearch" },

      r = { "<cmd>CoqRestorePanels<cr>", "CoqRestorePanels" },
      g = {
        name = "GotoGoal",
        g = { ":<C-U>execute v:count1 'CoqGotoGoal'<cr>", "GotoGoalStart" },
        G = { ":<C-U>execute v:count1 'CoqGotoGoal!'<cr>", "GotoGoalEnd" },
        n = { "<cmd>CoqGotoGoalNext<cr>", "GotoGoalNextStart" },
        N = { "<cmd>CoqGotoGoalNext!<cr>", "GotoGoalNextEnd" },
        p = { "<cmd>CoqGotoGoalPrev<cr>", "GotoGoalPrevStart" },
        P = { "<cmd>CoqGotoGoalPrev!<cr>", "GotoGoalPrevEnd" },
      },
    },
    r = { "<cmd>Telescope registers<cr>", "Browse registers" },
    s = {
      name = "session",
      s = { "<cmd>SessionSave<cr>", "Save session" },
      l = { "<cmd>SessionLoad<cr>", "Load session" },
    },
    t = {
      name = "tab",
      c = { "<cmd>tabnew<cr>", "Create tab" },
      d = { "<cmd>tabclose<cr>", "Delete tab" },
      p = { "<cmd>tabp<cr>", "Previous tab" },
      n = { "<cmd>tabn<cr>", "Next tab" },
    },
  }, {
    prefix = "<leader>",
    mode = "n",
  })

  wk.register({
    p = {
      name = "proof",
      h = { "<ESC>:Coq Check <C-r>=coqtail#util#getvisual()<cr><cr>", "CoqCheck" },
      a = { "<ESC>:Coq About <C-r>=coqtail#util#getvisual()<cr><cr>", "CoqAbout" },
      p = { "<ESC>:Coq Print <C-r>=coqtail#util#getvisual()<cr><cr>", "CoqPrint" },
      f = { "<ESC>:Coq Locate <C-r>=coqtail#util#getvisual()<cr><cr>", "CoqLocate" },
      ['/'] = { "<ESC>:Coq Search <C-r>=coqtail#util#getvisual()<cr><cr>", "CoqSearch" },
    }
  }, {
    prefix = "<leader>",
    mode = "x",
  })

  wk.register({
    ['p'] = {
      name = "proof",
      j = { "<cmd>CoqNext<cr>", "CoqNext" },
      k = { "<cmd>CoqUndo<cr>", "CoqUndo" },
      l = { "<cmd>CoqToLine<cr>", "CoqToLine" },
      t = { "<cmd>CoqToTop<cr>", "CoqToTop" },
    }
  }, {
    prefix = "<C-space>",
    mode = "i",
  })
end

function M.plug(use)
  use {
    "folke/which-key.nvim",
    config = function()
      require("qnix.plugins.which-key").config()
    end,
  }
end

return M
