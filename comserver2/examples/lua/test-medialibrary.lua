--require "luacom"

-- forward declaration of local functions
local setupTest, cleanupTest

local fb2k, ml

local testArtist = "Fink"

do
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
			error "Failed to get foobar2000 instance"
		end
		
		-- get Playback object
		ml = fb2k.MediaLibrary
		if not ml then
			error "Failed to get media library interface"
		end
		
		-- save settings
	end
	
	cleanupTest = function()
		-- restore settings
	end
end

local function test()
	print(fb2k.Name)
	print(fb2k.ApplicationPath)
	print(fb2k.ProfilePath)

	local tl, tl2, tl3
	
	tl = ml:GetTracks()
	print("There are " .. tl.Count .." tracks in the media library.")
	
	tl2 = tl:GetSortedTracks("%path%|$num(%subsong%,3)", "artist IS " .. string.lower(testArtist))
	print("There are " .. tl2.Count .. " tracks by " .. testArtist .. " in the media library.")
	
	tl3 = tl:GetTracks("artist IS " .. string.lower(testArtist))
	print("There are " .. tl2.Count .. " tracks by " .. testArtist .. " in track list retrieved from the media library.")
	
	for n, t in luacom.pairs(tl2) do
		print("Track " .. n ..' is "' .. t.Path .. '" / index: '.. t.Index)
		print("   Info on this track: " .. t:FormatTitle("%artist% - %album% - %tracknumber%. %title%"))
	end
	
	print("Testing invalid query string...")
	tl = null
	
	local function f1()
		tl = ml:SearchTracks("(artist IS")
		return true
	end
	if not pcall(f1) then
		print("Expected error occurred.")
	end
end


setupTest()
local res, err = pcall(test)
if not res then print(err) end
cleanupTest()
