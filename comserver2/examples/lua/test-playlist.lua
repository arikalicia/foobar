--require "luacom"

-- forward declaration of local functions
local setupTest, cleanupTest

local fb2k, pls, pl, pl2

do
	local event_sink = {}
	
	function event_sink:PlaylistAdded(index, obj, name)
		print("Added playlist at index " .. (index + 1) .. ' with name "' .. name .. '"')
	end
	
	function event_sink:PlaylistRemoved(index, obj)
		print("Removed playlist at index " .. (index + 1))
	end
	
	function event_sink:PlaylistRenamed(index, obj, newName)
		print("Renamed playlist at index " .. (index + 1) .. ' to "' .. newName .. '"')
	end
	
	function event_sink:PlaylistActivated(index, obj)
		print("Activated playlist at index " .. (index + 1))
	end
	
	function event_sink:PlaylistsReordered(first, last)
		print("Reordered playlists between index " .. (first+1) .. " and index " .. (last+1))
	end
	
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
			error "Failed to get foobar2000 Application object"
		end
		
		-- get Playlist object
		pls = fb2k.Playlists
		if not pls then
			error "Failed to get foobar2000 Playlists object"
		end
		
		-- save settings
		luacom.Connect(pls, event_sink)
		
		-- connect events
	end
	
	cleanupTest = function()
		-- disconnect events
		luacom.releaseConnection(pls)
		
		-- restore settings
	end
end

local function test()
	print(fb2k.Name)
	print(fb2k.ApplicationPath)
	print(fb2k.ProfilePath)

	local function dumpPlaylists()
		local tmp
		for _, tmp in luacom.pairs(pls) do
			print('Playlist ' .. (tmp.Index+1) .. ' is named "' .. tmp.Name .. '" and contains ' .. tmp:GetTracks().Count .. ' tracks.')
		end
	end

	-- since this script is calling foobar2000 from another process,
	-- the number of playlists may change while this loop is running,
	-- luckily, the enumerator gets an immutable copy of the list of
	-- playlists when it is created
	print("--- Testing: get number of playlists")
	print("There are " .. pls.Count .. " playlists containing a total of " .. pls:GetTracks().Count .. " tracks.")
	print("--- Testing: enumerate playlists")
	dumpPlaylists()
	
	-- create a playlist
	print("--- Testing: add playlist")
	pl = pls:Add("VBScript Test")
	-- rename it
	print("--- Testing: rename playlist")
	pl.Name = "VBScript Test (renamed)"
	-- add another playlist before that one and activate it
	print("--- Testing: add and activate playlist")
	pl2 = pls:Add("VBScript Test 2", true)
	-- dumpPlaylists()
	-- move it before first playlist
	-- fbPositionFirst = 0
	-- fbPositionLast = 1
	-- fbPositionBefore = 2
	-- fbPositionAfter = 3
	print("--- Testing: reorder playlists")
	pls:Move(pl2, 0)
	pls:Move(pl2, 3, pl)
	-- activate first playlist
	print("--- Testing: activate playlist")
	pls.ActivePlaylist = pl
	-- remove second playlist
	print("--- Testing: remove inactive playlist")
	pls:Remove(pl2)
	-- remove first playlist
	print("--- Testing: remove active playlist")
	pls:Remove(pl)
	-- remove it again just to be sure (that the server can handle that)
	print("--- Testing: remove stale playlist")
	pls:Remove(pl)
	-- try printing index of removed playlist
	print("--- Testing: get index of stale playlist")
	print("Removed playlist object now has index " .. pl.Index)
	-- try to activate stale playlist
	print("--- Testing: activate stale playlist")
	pls.ActivePlaylist = pl
	
	print("--- Testing: enumerate playlists")
	dumpPlaylists()
end


setupTest()
local res, err = pcall(test)
if not res then print(err) end
cleanupTest()
