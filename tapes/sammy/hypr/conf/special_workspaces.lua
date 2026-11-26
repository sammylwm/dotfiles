local workspace_programs = {
	["special:vpn"] = "AmneziaVPN",
	["special:tg"] = "materialgram",
	["special:music"] = "ghostty -e ymusic",
	["special:localsend"] = "localsend",
}

hl.on("workspace.created", function(workspace)
	if not workspace.is_empty then
		return
	end

	local command = workspace_programs[workspace.addressable_name]
	if not command then
		return
	end

	hl.exec_cmd(command, { workspace = workspace.addressable_name .. " silent" })
end)

hl.bind("SUPER + D", hl.dsp.workspace.toggle_special("tg"))
hl.bind("SUPER + L", hl.dsp.workspace.toggle_special("localsend"))
hl.bind("SUPER + M", hl.dsp.workspace.toggle_special("music"))
-- hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("happ"))
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("vpn"))
