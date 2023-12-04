local util = require('lspconfig.util')

local root_files = {
    -- Single-module projects
    { 'build.xml', 'pom.xml', 'settings.gradle', 'settings.gradle.kts' },
    -- Multi-module projects
    { 'build.gradle', 'build.gradle.kts' },
    -- Other
    { '.project' },
}

require('lspconfig').jdtls.setup({
    root_dir = function(fname)
        for _, patterns in ipairs(root_files) do
            local root = util.root_pattern(unpack(patterns))(fname)
            if root then return root end
        end
    end,
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
