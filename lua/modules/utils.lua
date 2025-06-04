local M = {}
M.path_concat = function(path_components)
    return vim.fs.normalize(table.concat(path_components, "/"))
end

M.mason_root_dir = "~/.local/share/nvim/mason/"

return M
