return {
  init_options = {
    -- storagePath = …, -- Optional absolute path to storage dir. Defaults to os.tmpdir().
    -- globalStoragePath = …, -- Optional absolute path to a global storage dir. Defaults to os.homedir().
    licenceKey = "~/intelephense/licence.txt", -- Optional licence key or absolute path to a text file containing the licence key.
    -- clearCache = …, -- Optional flag to clear server state. State can also be cleared by deleting {storagePath}/intelephense
  },
  settings = {
    intelephense = {
      diagnostics = {
        enable = true,
      },
      format = {
        enable = true,
      },
    },
  },
}
