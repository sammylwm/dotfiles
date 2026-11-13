local info = debug.getinfo(1, "S")
local module_directory = string.match(info.source, "^@(.*)/")
local module_filename = string.match(info.source, "/([^/]*)$")

local module_name = ... or "conf"

local function scandir(directory)
	local files = {}

	for filename in io.popen('ls -a "' .. directory .. '"'):lines() do
		table.insert(files, filename)
	end

	return files
end

local config_files = {}

for _, filename in ipairs(scandir(module_directory)) do
	if string.match(filename, "[.]lua$") and filename ~= module_filename then
		table.insert(config_files, filename)
	end
end

for _, filename in ipairs(config_files) do
	local config_module = string.match(filename, "(.+)%.lua$")
	require(module_name .. "." .. config_module)
end
