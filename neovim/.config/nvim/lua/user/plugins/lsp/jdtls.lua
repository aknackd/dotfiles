require('lspconfig').jdtls.setup({
    settings = {
        java = {
            configuration = {
                updateBuildConfiguration = 'interactive',
            },
            eclipse = {
                downloadSources = true,
            },
            format = {
                enabled = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            maven = {
                downloadSources = true,
                updateSnapshots = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
        },
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
    },
})
