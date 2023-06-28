local git = require("git_utils")
local foo = 4
local url_utils = require("url_utils")

local M = {}

function get_relative_file_path(repo_root)
    local current = vim.api.nvim_buf_get_name(0):gsub('%s+', '')
    local s,e = string.find(current, repo_root, 1, true)
    if s ~= 1 then
        print('Repo root is not a prefix')
        return nil
    end
    local removed = current:sub(e+2)
    return removed
end

function get_current_line()
    local r,_ = unpack(vim.api.nvim_win_get_cursor(0))
    return r
end

function get_url(with_line)
    local remotes = git.get_remotes()
    if not remotes then
        return nil
    end
    local remote = remotes[1]
    local remote_url = git.get_remote_url(remote)
    if not remote_url then
        return nil
    end
    local base,user,repo = url_utils.split_remote_url(remote_url)
    if not base then
        return nil
    end
    local url_to_current_file = url_utils.build_base_url_to_current_file(
        base,
        user,
        repo,
        git.get_current_branch(),
        get_relative_file_path(git.get_repo_root()),
        (with_line and get_current_line() or nil)
    )
    if not url_to_current_file then
        return nil
    end
    return url_to_current_file
end

function open_in_browser(url)
    if url then
        vim.fn.jobstart({ 'xdg-open', url }, { detach = true })
    else
        print('Could not open file')
    end
end

function yank_to_register(register, url)
    local cmd = string.format('let @%s = "%s"', register, url)
    vim.cmd(cmd)
    print(url, "yanked to register '" .. register .. "'")
end

M.open_file_in_browser = function() open_in_browser(get_url(false)) end
M.open_line_in_browser = function() open_in_browser(get_url(true)) end
M.yank_file_url = function(register) return yank_to_register(register, get_url(false)) end
M.yank_line_url = function(register) return yank_to_register(register, get_url(true)) end
M.get_file_url = function() return get_url(false) end
M.get_line_url = function() return get_url(true) end

return M
