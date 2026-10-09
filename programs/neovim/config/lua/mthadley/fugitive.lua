local map = vim.keymap.set
local prefix = "<C-G>"

map("n", prefix .. "s", vim.cmd.Git)
map("n", prefix .. "l", vim.cmd.Gclog)
map("n", prefix .. "b", function()
	vim.cmd.Git("blame")
end)
map("n", prefix .. "e", vim.cmd.Gedit)

map("n", prefix .. "h", vim.cmd.GBrowse)
map("v", prefix .. "h", ":GBrowse<CR>")

--- Added/deleted line counts by file name. Extra arguments go to `git diff`.
local function numstat(buf, ...)
	local stats = {}
	local result = vim.fn.FugitiveExecute({ "diff", "--numstat", "--no-renames", ... }, buf)
	for _, line in ipairs(result.stdout) do
		local add, del, file = line:match("^(%S+)\t(%S+)\t(.+)$")
		if file then
			stats[file] = { add = add, del = del }
		end
	end
	return stats
end

local function format_count(sign, count)
	return count == "0" and "" or sign .. count
end

local function collect_diff_entries(buf)
	local stats = { Unstaged = numstat(buf), Staged = numstat(buf, "--cached") }
	local entries = {}
	local section = {}
	for i, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
		local heading = line:match("^(%a+).* %(%d+%)$")
		local file = line:match("^[MADRUT] (.+)$")
		local stat = file and section[file]
		if heading then
			section = stats[heading] or {}
		elseif stat and (stat.add ~= "0" or stat.del ~= "0") then
			table.insert(entries, {
				row = i - 1,
				width = vim.fn.strdisplaywidth(line),
				add = format_count("+", stat.add),
				del = format_count("-", stat.del),
			})
		end
	end
	return entries
end

local function measure_widths(entries)
	local widths = { name = 0, add = 0, del = 0 }
	for _, e in ipairs(entries) do
		widths.name = math.max(widths.name, e.width)
		widths.add = math.max(widths.add, #e.add)
		widths.del = math.max(widths.del, #e.del)
	end
	return widths
end

local function pad_left(str, width)
	return string.rep(" ", width - #str) .. str
end

local ns = vim.api.nvim_create_namespace("fugitive_numstat")

--- Draw the counts as virtual text in aligned columns.
local function render_diff_counts(buf, entries, widths)
	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
	for _, e in ipairs(entries) do
		local pad = string.rep(" ", widths.name - e.width + 1)
		local virt_text = {
			{ pad .. pad_left(e.add, widths.add), "FugitiveNumstatAdded" },
		}
		if widths.del > 0 then
			table.insert(virt_text, { " " .. pad_left(e.del, widths.del), "FugitiveNumstatRemoved" })
		end
		vim.api.nvim_buf_set_extmark(buf, ns, e.row, 0, {
			virt_text = virt_text,
			hl_mode = "combine",
		})
	end
end

vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("mthadley:fugitive", { clear = true }),
	pattern = "FugitiveIndex",
	callback = function(ev)
		local entries = collect_diff_entries(ev.buf)
		render_diff_counts(ev.buf, entries, measure_widths(entries))
	end,
})
