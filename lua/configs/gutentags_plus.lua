return {
  "skywind3000/gutentags_plus",
  event = "VeryLazy",
  dependencies = { "ludovicchabant/vim-gutentags" },
  config = function()
    vim.g.gutentags_enabled = true
    vim.g.gutentags_generate_on_new = true
    vim.g.gutentags_generate_on_missing = true
    vim.g.gutentags_generate_on_write = true
    vim.g.gutentags_generate_on_empty_buffer = true
    vim.g.gutentags_resolve_symlinks = true
    vim.g.gutentags_ctags_tagfile = ".git/tags"
    vim.g.gutentags_project_root = { ".git", "package.json", "go.mod" }
    vim.g.gutentags_ctags_extra_args = { "--tag-relative=yes", "--fields=+ailmnS" }
    vim.g.gutentags_add_default_project_roots = false
    vim.g.gutentags_file_list_command = "rg --files"

    -- Define the cache directory for Gutentags
    local cache_dir = vim.fn.expand("~/.cache/nvim/ctags/")

    -- Create the directory if it doesn't exist
    local uv = vim.loop  -- Using Neovim's built-in libuv bindings
    if not uv.fs_stat(cache_dir) then
      uv.fs_mkdir(cache_dir, 493)  -- 493 is equivalent to 0755 in octal (permissions)
    end
    -- Set the Gutentags cache directory
    vim.g.gutentags_cache_dir = cache_dir

    -- borrowed from https://github.com/BrunoKrugel/dotfiles/blob/master/lua/configs/tags.lua
    vim.g.gutentags_ctags_exclude = {
      "*.git",
      "*.svg",
      "*.hg",
      "*/tests/*",
      "build",
      "dist",
      "*sites/*/files/*",
      "bin",
      "node_modules",
      "bower_components",
      "cache",
      "compiled",
      "docs",
      "example",
      "bundle",
      "vendor",
      "*.md",
      "*-lock.json",
      "*.lock",
      "*bundle*.js",
      "*build*.js",
      ".*rc*",
      "*.json",
      "*.min.*",
      "*.map",
      "*.bak",
      "*.zip",
      "*.pyc",
      "*.class",
      "*.sln",
      "*.Master",
      "*.csproj",
      "*.tmp",
      "*.csproj.user",
      "*.cache",
      "*.pdb",
      "tags*",
      "cscope.*",
      ".venv",
      "*.exe",
      "*.dll",
      "*.mp3",
      "*.ogg",
      "*.flac",
      "*.swp",
      "*.swo",
      "*.bmp",
      "*.gif",
      "*.ico",
      "*.jpg",
      "*.png",
      "*.rar",
      "*.zip",
      "*.tar",
      "*.tar.gz",
      "*.tar.xz",
      "*.tar.bz2",
      "*.pdf",
      "*.doc",
      "*.docx",
      "*.ppt",
      "*.pptx",
    }
  end,
}
