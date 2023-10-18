require('lspconfig').jdtls.setup({
    settings = {
        java = {
            home = os.getenv('JAVA_HOME') or '',
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
            saveActions = {
                organizeImports = true,
            },
            server = {
                launchMode = 'lightweight',
            },
        },
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
    },
})
