require('lspconfig').tailwindcss.setup({
    filetypes = { "html", "astro", "javascript", "typescript", "react", "vue" },
    settings = {
        tailwindCSS = {
            includeLanguages = {
                templ = "html",
            },
        },
    },
})

