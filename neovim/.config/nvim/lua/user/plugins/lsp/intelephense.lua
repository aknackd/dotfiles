local utils = require('user.utils')

require('lspconfig').intelephense.setup({
    init_options = {
        globalStoragePath = utils.get_lsp_cache_dir()..'/intelephense',
        telemetry = {
            enabled = false,
        },
    },
})
