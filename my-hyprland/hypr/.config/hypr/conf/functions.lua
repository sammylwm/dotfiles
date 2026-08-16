local M = {}

function M.add(keys, action, opts)
	if type(keys) == "string" then
		keys = string.gsub(keys, "super", "SUPER")
		hl.bind(keys, action, opts)
	elseif type(keys) == "table" then
		for _, key in ipairs(keys) do
			key = string.gsub(key, "super", "SUPER")
			hl.bind(key, action, opts)
		end
	end
end

return M
