local U = require('aksh.utils')

U.imap('<C-a>', '<C-o>^')
U.imap('<C-e>', '<C-o>$')


-- terminal
local fterm = require('FTerm')
local function terminal_scratch(cmd)
  fterm.scratch({cmd = cmd})
end
local function terminal_run_build()
  terminal_scratch('if [ -d build ]; then make -C build -j4; else make -j4; fi')
end
local function terminal_run_cmake()
  terminal_scratch('cmake -B build . -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_CXX_COMPILER=clang++')
end

U.nmap('<leader>tt', fterm.toggle, { desc = 'Toggle floating terminal' })
U.tmap('<C-d>', fterm.toggle, { desc = 'Toggle floating terminal' })
U.nmap('<leader>tb', terminal_run_build, { desc = 'Run build' })
U.nmap('<leader>tc', terminal_run_cmake, { desc = 'Run cmake configuration' })

U.nmap('<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
U.nmap('<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
U.nmap('<leader>se', '<C-w>=', { desc = 'Make the splits equal' })
U.nmap('<leader>sx', '<cmd>close<cr>', { desc = 'Close current split' })

U.nmap('<leader>to', '<cmd>tabnew<cr>', { desc = 'Open new tab' })
U.nmap('<leader>tx', '<cmd>tabclose<cr>', { desc = 'Close tab' })
U.nmap('<leader>tn', '<cmd>tabn<cr>', { desc = 'Next tab' })
U.nmap('<leader>tp', '<cmd>tabp<cr>', { desc = 'Previous tab' })

local iron = require('iron.core')
U.nmap('<leader>l,', '<cmd>IronRepl<CR>') -- Because, we don't want to handle filetype inference 
U.map({ 'n', 'i' }, '<C-c><C-c>', iron.send_line, { desc = "Send line" })
U.vmap('<C-c><C-c>', iron.visual_send, { desc = "Send visual" })
U.map({ 'n', 'i' }, '<C-c><C-f>', iron.send_file, { desc = "Send file" })

-- LSP refactoring shortcuts
U.nmap('grr', vim.lsp.buf.rename, { desc = 'Rename' })
