-- Configurações globais
local config = {
	size = {
		width = 0.9, -- 90% da largura da tela
		height = 0.8, -- 80% da altura da tela
	},
	border = "rounded", -- "single", "double", "rounded", "solid", "shadow"
	winblend = 10, -- Transparência (0-100)
	auto_insert = true, -- Entra automaticamente no modo insert
	auto_close = true, -- Fecha quando o terminal é encerrado
}

-- Estado do terminal
local terminal_state = {
	buf = nil,
	win = nil,
	job_id = nil,
}

-- Keymap para sair do terminal com ESC duplo
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
	desc = "Sair do modo terminal",
})

-- Função para calcular dimensões centralizadas
local function get_window_config()
	local width = math.floor(vim.o.columns * config.size.width)
	local height = math.floor(vim.o.lines * config.size.height)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	return {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = config.border,
		title = " Terminal ",
		title_pos = "center",
	}
end

-- Função para criar o buffer do terminal
local function create_terminal_buffer()
	local buf = vim.api.nvim_create_buf(false, true)

	-- Configurações do buffer
	vim.bo[buf].filetype = "terminal"
	vim.bo[buf].buflisted = false
	vim.bo[buf].bufhidden = "hide"

	-- Keymaps específicos do buffer
	local opts = { buffer = buf, silent = true }
	vim.keymap.set("t", "<C-q>", function()
		close_terminal()
	end, opts)
	vim.keymap.set("n", "<C-q>", function()
		close_terminal()
	end, opts)
	vim.keymap.set("n", "q", function()
		close_terminal()
	end, opts)

	return buf
end

-- Função para fechar o terminal
function close_terminal()
	if terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, true)
	end
	terminal_state.win = nil
end

-- Função para resetar completamente o terminal (mata processos)
local function reset_terminal()
	if terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, true)
	end

	-- Limpa o buffer usado
	if terminal_state.buf and vim.api.nvim_buf_is_valid(terminal_state.buf) then
		vim.api.nvim_buf_delete(terminal_state.buf, { force = true })
	end

	terminal_state.win = nil
	terminal_state.buf = nil
	terminal_state.job_id = nil
end

-- Função para abrir o terminal
local function open_terminal()
	-- Cria buffer apenas se não existir ou não for válido
	if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
		terminal_state.buf = create_terminal_buffer()
		terminal_state.job_id = nil -- Reset job_id para buffer novo
	end

	-- Cria a janela flutuante
	local win_config = get_window_config()
	terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, win_config)

	-- Configurações da janela
	pcall(function()
		vim.wo[terminal_state.win].winhl = "Normal:Normal,FloatBorder:FloatBorder"
		vim.wo[terminal_state.win].winblend = config.winblend
	end)

	-- Inicia o terminal apenas se não estiver rodando
	if not terminal_state.job_id then
		terminal_state.job_id = vim.fn.termopen(vim.o.shell, {
			on_exit = function()
				if config.auto_close then
					vim.schedule(function()
						reset_terminal() -- Usa reset quando o processo morre naturalmente
					end)
				end
			end,
		})
	end

	-- Entra automaticamente no modo insert se configurado
	if config.auto_insert then
		vim.schedule(function()
			if vim.api.nvim_win_is_valid(terminal_state.win) then
				vim.cmd("startinsert")
			end
		end)
	end
end

-- Função principal para alternar o terminal
local function toggle_terminal()
	if terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		close_terminal()
	else
		open_terminal()
	end
end

-- Função para configurar o plugin
local function setup(user_config)
	if user_config then
		config = vim.tbl_deep_extend("force", config, user_config)
	end
end

-- Comandos
vim.api.nvim_create_user_command("ToggleTerminal", toggle_terminal, {
	desc = "Alternar terminal flutuante",
})

vim.api.nvim_create_user_command("FloatTerminal", open_terminal, {
	desc = "Abrir terminal flutuante",
})

vim.api.nvim_create_user_command("ResetTerminal", reset_terminal, {
	desc = "Resetar terminal completamente (mata processos)",
})

-- Keymaps principais
vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal, {
	desc = "Alternar terminal flutuante",
})

vim.keymap.set({ "n", "t" }, "<C-`>", toggle_terminal, {
	desc = "Alternar terminal flutuante",
})

vim.keymap.set({ "n", "t" }, "<leader>tr", reset_terminal, {
	desc = "Resetar terminal completamente",
})

-- Autocommand para redimensionar quando o Neovim for redimensionado
vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	callback = function()
		if terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
			local new_config = get_window_config()
			pcall(function()
				vim.api.nvim_win_set_config(terminal_state.win, new_config)
			end)
		end
	end,
	desc = "Redimensionar terminal flutuante quando Neovim for redimensionado",
})

-- Return necessário para o Lazy.nvim
return {
	{
		name = "floaterminal",
		dir = vim.fn.stdpath("config") .. "/lua/plugins/",
		config = function()
			-- O código já foi executado acima quando o arquivo foi carregado
			-- Aqui você pode adicionar configurações extras se necessário
		end,
	},
}
