-- I like using space for leader key
vim.g.mapleader = ' '

-- some basic vim options
require("qnix.basics").setup()


-- special settings for different file types
require("qnix.ft").setup()

-- the rest of my setup (especially plugins)
require("qnix").setup()
