local M = {}

vim.api.nvim_create_user_command("NoteNew", function()
	local aaa = vim.api.nvim_buf_get_mark(0, "'<")

	vim.print("aqui " .. aaa)
end, { range = true })

return M
