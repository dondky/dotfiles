local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	end
end

local servers = {'pyright', 'gopls', 'rust_analyzer', 'solargraph', 'bashls', 'dockerls', 'cmake', 'clangd'}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
	}
end

require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true
	},
}

-- Setup diagnostics formaters and linters for non LSP provided files
nvim_lsp.diagnosticls.setup {
	on_attach = on_attach,
	cmd = {"diagnostic-languageserver", "--stdio"},
	filetypes = {
		"markdown",
		"json"
	},
	init_options = {
		linters = {
			jsonlint = {
				command = "jsonlint",
				isStderr = true,
				debounce = 100,
				args = {"--compact"},
				offsetLine = 0,
				offsetColumn = 0,
				sourceName = "jsonlint",
				formatLines = 1,
				formatPattern = {
					"^line (\\d+), col (\\d*), (.+)$",
					{
						line = 1,
						column = 2,
						message = {3}
					}
				}
			},
			markdownlint = {
				command = "markdownlint",
				isStderr = true,
				debounce = 100,
				args = {"--stdin"},
				offsetLine = 0,
				offsetColumn = 0,
				sourceName = "markdownlint",
				formatLines = 1,
				formatPattern = {
					"^.*?:\\s?(\\d+)(:(\\d+)?)?\\s(MD\\d{3}\\/[A-Za-z0-9-/]+)\\s(.*)$",
					{
						line = 1,
						column = 3,
						message = {4}
					}
				}
			}
		},
		filetypes = {
			markdown = "markdownlint",
			json = "jsonlint"
		},
		formatters = {
			shfmt = {
				command = "shfmt",
				args = {"-i", "2", "-bn", "-ci", "-sr"}
			},
			prettier = {
				command = "prettier",
				args = {"--stdin-filepath", "%filepath"},
			}
		},
		formatFiletypes = {
			sh = "shfmt",
			markdown = "prettier"
		}
	}
}

-- Vim diagnostics, more to do here
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
	update_in_insert = false,
}
)
