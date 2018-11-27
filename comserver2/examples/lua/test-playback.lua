--require "luacom"

-- forward declaration of local functions
local setupTest, cleanupTest

local fb2k, playback, settings

do
	local savedIsPlaying, savedIsPaused
	local savedPosition
	local savedCursorFollowsPlayback
	local savedPlaybackFollowsCursor
	local savedStopAfterCurrent
	local savedActivePlaybackOrder
	
	local playback_event_sink = {}
	local settings_event_sink = {}
	
	function playback_event_sink:Started()
		print("Playback started.")
	end
	
	function playback_event_sink:Stopped(reason)
		local msg = "Playback stopped"
		if reason == 0 then -- fbStopReasonUser
			msg = msg .. " (requested by user)"
		elseif reason == 1 then -- fbStopReasonEOF 
			msg = msg .. " (end of file)"
		elseif reason == 2 then -- fbStopReasonStartingAnother
			msg = msg .. " (starting another track)"
		else
			msg = msg .. " (stop reason " .. reason .. ")"
		end
		print(msg .. ".")
	end
	
	-- not triggered (LuaCOM problem?)
	function playback_event_sink:Paused(state)
		if state then
			print("Playback was paused.")
		else
			print("Playback was unpaused.")
		end
	end
	
	function playback_event_sink:TrackChanged()
		print("Track changed. New track is " .. playback:FormatTitle([["%_path_raw%" '('%_subsong%')']]))
	end
	
	function playback_event_sink:PositionChanged(position, seeked)
		if seeked then
			print("Position changed (seeking).")
		end
	end
	
	-- not triggered (LuaCOM problem?)
	function settings_event_sink:CursorFollowsPlaybackChanged(state)
		print("Setting changed: Cursor follows playback. New value is " .. state)
	end
	
	-- not triggered (LuaCOM problem?)
	function settings_event_sink:PlaybackFollowsCursorChanged(state)
		print("Setting changed: Playback follows cursor. New value is " .. state)
	end
	
	-- not triggered (LuaCOM problem?)
	function settings_event_sink:StopAfterCurrentChanged(state)
		print("Setting changed: Stop after current. New value is " .. state)
	end
	
	-- not triggered (LuaCOM problem?)
	function settings_event_sink:ActivePlaybackOrderChanged(name)
		print("Setting changed: Playback order. New value is " .. state)
	end
	
	local playback_event_obj, settings_event_obj

	setupTest = function()
		local ProgID = "Foobar2000.Application.0.7"
		
		-- get Application object
		fb2k = luacom.GetObject(ProgID)
		if fb2k then
			print "Using existing instance."
		else
			print "Creating new instance."
			fb2k = luacom.CreateObject(ProgID)
		end
		if not fb2k then
			error "Failed to get foobar2000 Application object."
		end
		
		-- get Playback object
		playback = fb2k.Playback
		if not playback then
			error "Failed to get foobar2000 Playback object."
		end
		
		-- get PlaybackSettings object
		settings = playback.Settings
		if not settings then
			error "Failed to get foobar2000 PlaybackSettings object."
		end
		
		-- save settings
		savedIsPlaying = playback.IsPlaying
		savedIsPaused = playback.IsPaused
		savedPosition = playback.Position
		savedCursorFollowsPlayback = settings.CursorFollowsPlayback
		savedPlaybackFollowsCursor = settings.PlaybackFollowsCursor
		savedStopAfterCurrent = settings.StopAfterCurrent
		savedActivePlaybackOrder = settings.ActivePlaybackOrder
		
		-- connect events
		playback_event_obj = luacom.Connect(playback, playback_event_sink)
		settings_event_obj = luacom.Connect(settings, settings_event_sink)
	end
	
	cleanupTest = function()
		-- disconnect events
		luacom.releaseConnection(settings)
		luacom.releaseConnection(playback)
		
		-- restore settings
		if savedIsPlaying then
			playback:Start(true)
			playback:Seek(savedPosition)
			if not savedIsPaused then
				playback:Pause()
			end
		end
		settings.CursorFollowsPlayback = savedCursorFollowsPlayback
		settings.PlaybackFollowsCursor = savedPlaybackFollowsCursor
		settings.StopAfterCurrent = savedStopAfterCurrent
		settings.ActivePlaybackOrder = savedActivePlaybackOrder
	end
end

local function test()
	print(fb2k.Name)
	print(fb2k.ApplicationPath)
	print(fb2k.ProfilePath)

	print("--- enabling Cursor follows playback")
	settings.CursorFollowsPlayback = true
	print("--- disabling Playback follows cursor")
	settings.PlaybackFollowsCursor = false
	print("--- enabling Stop after current")
	settings.StopAfterCurrent = true
	
	print("--- changing playback order")
	if settings.ActivePlaybackOrder == "Repeat (playlist)" then
		settings.ActivePlaybackOrder = "Default"
	else
		settings.ActivePlaybackOrder = "Repeat (playlist)"
	end
	
	local pos
	pos = settings.PlaybackOrders
	print("There are " .. pos.Count .. " playback orders available.")
	for _, po in luacom.pairs(pos) do
		print(po)
	end
	if pos.Count > 0 then
		print("Unique identifier for " .. pos(0) .. " is " .. pos:GuidFromName(pos(0)))
	end
	
	print("--- starting playback in paused state")
	playback:Start(true)
	print("--- unpausing playback")
	playback:Pause()
	if true then
		local n = 10
		print("--- waiting " .. n .. " seconds")
		sleep(n)
		print("--- done with waiting")
	end
	if playback.CanSeek then
		print("--- seeking back one second")
		-- like playback:Seek(playback.Position - 1) but avoids lag between reading position and seeking
		playback:Seek(playback.Position - 1)
		--playback:SeekRelative(-1)
	end
	print("--- stopping playback")
	playback:Stop()
end


local success, err = pcall(setupTest)
if not success then
	print("--- Error while setting up test:")
	print(err)
else
	success, err = pcall(test)
	if not success then
		print("--- Error in test:")
		print(err)
	end
	success, err = pcall(cleanupTest)
	if not success then
		print("--- Error while cleaning up test:")
		print(err)
	end
end
