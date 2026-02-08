return {
  'nvimtools/none-ls.nvim',
  lazy = true,
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jay-babu/mason-null-ls.nvim',
  },
  config = function()
    local null_ls = require('null-ls')
    local mason_null_ls = require('mason-null-ls')
    local null_ls_utils = require('null-ls.utils')

    mason_null_ls.setup({
      ensure_installed = {
        'prettier',
        'stylua',
        'ktlint',
      },
    })

    null_ls.setup({
      root_dir = null_ls_utils.root_pattern('.null-ls-root', 'Makefile', '.git', 'package.json', 'settings.gradle.kts', 'CMakeLists.txt', 'deps.edn', 'project.clj'),
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.diagnostics.cmake_lint,
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.buf,
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.clj_kondo,
        null_ls.builtins.diagnostics.ktlint,
        null_ls.builtins.diagnostics.markdownlint_cli2,
      },
    })
  end,
}
