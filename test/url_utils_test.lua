local url_utils = require("url_utils")

describe('split url test', function()
    it('ssh github', function()
        local remote_url = 'git@github.com:pabloariasal/dotfiles.git'
        local base,user,repo = url_utils.split_remote_url(remote_url)
        assert.are.same('github.com', base)
        assert.are.same('pabloariasal', user)
        assert.are.same('dotfiles', repo)
    end)
    it('https github', function()
        local remote_url = 'https://github.com/pablo-ariasal/alternate.nvim.git'
        local base,user,repo = url_utils.split_remote_url(remote_url)
        assert.are.same('github.com', base)
        assert.are.same('pablo-ariasal', user)
        assert.are.same('alternate.nvim', repo)
    end)
    it('https gitlab', function()
        local remote_url = 'https://foo:akja_ajkas-WE@some.company.gitlab.com/myuser/my-app.git'
        local base,user,repo = url_utils.split_remote_url(remote_url)
        assert.are.same('some.company.gitlab.com', base)
        assert.are.same('myuser', user)
        assert.are.same('my-app', repo)
    end)
    it('wrong url', function()
        local remote_url = 'foo'
        local base,user,repo = url_utils.split_remote_url(remote_url)
        assert.are.same(nil, base)
        assert.are.same(nil, user)
        assert.are.same(nil, repo)
    end)
end)

describe('assemble url test', function() 
    it('github no line', function()
        local url = url_utils.build_base_url_to_current_file(
            'github.com',
            'user',
            'repo.nvim',
            'dev',
            'path/to/file.txt')
        assert.are.same('https://github.com/user/repo.nvim/blob/dev/path/to/file.txt', url)
    end)

    it('github with line', function()
        local url = url_utils.build_base_url_to_current_file(
            'github.com',
            'user',
            'repo.nvim',
            'dev',
            'path/to/file.txt',
            42)
        assert.are.same('https://github.com/user/repo.nvim/blob/dev/path/to/file.txt#L42', url)
    end)

    it('gitlab no line', function()
        local url = url_utils.build_base_url_to_current_file(
            'some-company.com',
            'my-user',
            'my-app',
            'master',
            'path/to/file.txt')
        assert.are.same('https://some-company.com/my-user/my-app/-/blob/master/path/to/file.txt', url)
    end)

    it('gitlab with line', function()
        local url = url_utils.build_base_url_to_current_file(
            'some-company.com',
            'my-user',
            'my-app',
            'master',
            'path/to/file.txt',
            1)
        assert.are.same('https://some-company.com/my-user/my-app/-/blob/master/path/to/file.txt#L1', url)
    end)

end)

