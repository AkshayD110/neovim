local U = require('aksh.utils')
local nmap = U.nmap

local opts = { noremap = true, silent = false, }
local on_attach = function(client, bufnr)
  opts.buffer = bufnr
  opts.desc = 'Show LSP references'
  nmap('gR', '<cmd>Telescope lsp_references<cr>', opts)
  opts.desc = 'Go to declarations'
  nmap('gD', vim.lsp.buf.declaration, opts)
  opts.desc = 'Show LSP definitions'
  nmap('gd', '<cmd>Telescope lsp_definitions<cr>', opts)
  opts.desc = 'Show LSP implementations'
  nmap('gi', '<cmd>Telescope lsp_implementations<cr>', opts)
  opts.desc = 'Show LSP type definitions'
  nmap('gt', '<cmd>Telescope lsp_type_definitions<cr>', opts)
  opts.desc = 'Smart rename'
  nmap('<leader>rn', vim.lsp.buf.rename, opts)
  opts.desc = 'Hover'
  nmap('gh', vim.lsp.buf.hover, opts)
  
  -- Enable semantic token highlighting for better IDE-like colors
  if client.server_capabilities.semanticTokensProvider then
    vim.lsp.semantic_tokens.start(bufnr, client.id)
  end
end

local servers = {
  'bashls',
  'clangd',
  'clojure_lsp',
  'cmake',
  'gopls',
  'jdtls',
  'kotlin_language_server',
  'ts_ls',
}

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    
    local flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 200,
    }

    -- Configure all servers
    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = flags,
      })
    end

    -- Lua LSP with custom settings
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        }
      },
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
    })

    -- Python LSP
    vim.lsp.config('pylsp', {
      settings = {
        pylsp = {
          plugins = {
            ignore = { 'W391' },
            maxLineLength = 120,
          }
        }
      },
      capabilities = capabilities,
      flags = flags,
      on_attach = on_attach,
    })

    -- Ruff LSP
    vim.lsp.config('ruff', {
      settings = {
        ruff = {
          checkOnSave = true,
        },
      },
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
    })
    
    -- Auto-start LSP servers based on filetype
    local filetype_to_server = {
      java = 'jdtls',
      python = 'pylsp',
      lua = 'lua_ls',
      c = 'clangd',
      cpp = 'clangd',
      go = 'gopls',
      javascript = 'ts_ls',
      typescript = 'ts_ls',
      javascriptreact = 'ts_ls',
      typescriptreact = 'ts_ls',
      bash = 'bashls',
      sh = 'bashls',
      kotlin = 'kotlin_language_server',
      clojure = 'clojure_lsp',
      cmake = 'cmake',
    }
    
    vim.api.nvim_create_autocmd('FileType', {
      pattern = vim.tbl_keys(filetype_to_server),
      callback = function(args)
        local server = filetype_to_server[args.match]
        if server then
          vim.schedule(function()
            local config = vim.lsp.config[server]
            if config then
              vim.lsp.start(config, { bufnr = args.buf })
              vim.notify('Starting LSP: ' .. server, vim.log.levels.INFO)
            end
          end)
        end
      end,
    })

--    Using rustacean - it advises not setting up rust_analyzer below. Hence commented out.
--    lspconfig.rust_analyzer.setup({
--      settings = {
--        ['rust-analyzer'] = {
--          cargo = {
--            loadOutDirsFromCheck = true,
--            allFeatures = true,
--          },
--          procMacro = {
--            enable = true,
--          },
--          checkOnSave = {
--            command = 'clippy',
--            allFeatures = true,
--          },
--          diagnostics = {
--            enable = true,
--            disabled = { 'unresolved-import' },
--            enableExperimental = true,
--          },
--          assist = {
--            importMergeBehavior = 'last',
--            importPrefix = 'by_self',
--            importGranularity = 'module',
--          },
--          experimental = {
--            procAttrMacros = true,
--          },
--        },
--      },
--      on_attach = on_attach,
--    })

  end
}
