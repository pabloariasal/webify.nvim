local M = {}

function M.split_remote_url(remote_url)
    local remote_url = remote_url:gsub('http[s]+://', '')
    remote_url = remote_url:gsub('.*@', '')
    local pattern = '([%w%p]+)[:/](%w+)/([%w%p]+)'
    local base,user,repo = string.match(remote_url, pattern)
    if not base then
        print('pattern did not match')
        return nil
    end
    repo = repo:gsub('%.git$', '')
    return base,user,repo
end

function M.build_base_url_to_current_file(base, user, repo, branch, relative_path, line)
    local url = nil
    if string.find(base, 'github') then
        url = string.format('https://%s/%s/%s/blob/%s/%s', base, user, repo, branch, relative_path)
    else
        url = string.format('https://%s/%s/%s/-/blob/%s/%s', base, user, repo, branch, relative_path)
    end
    if line then
        return string.format('%s#L%d', url, line)
    end
    return url
end
return M
