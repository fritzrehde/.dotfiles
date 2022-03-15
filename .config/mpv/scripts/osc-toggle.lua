local toggle = true

function osc_toggle ()
	toggle = not toggle
	mp.command("script-message osc-visibility " .. (toggle and "never" or "always") .. " no-osd")
end

mp.add_key_binding(nil, "osc-toggle", osc_toggle)
