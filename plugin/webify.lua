local function open_file(opts)
    require('webify').open_file_in_browser()
end

local function open_file_at_line(opts)
    require('webify').open_line_in_browser()
end

local function yank_file_url(opts)
    require('webify').yank_file_url(opts.fargs[1])
end

local function yank_line_url(opts)
    require('webify').yank_line_url(opts.fargs[1])
end

vim.api.nvim_create_user_command('OpenLineInRepo', open_file_at_line, {})
vim.api.nvim_create_user_command('OpenFileInRepo', open_file, {})
vim.api.nvim_create_user_command('YankFileUrl', yank_file_url, {  nargs = 1 })
vim.api.nvim_create_user_command('YankLineUrl', yank_line_url, {  nargs = 1 })
