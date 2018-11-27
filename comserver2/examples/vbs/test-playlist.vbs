option explicit

dim fb2k, pls, pl, pl2

SetupTest

WScript.Echo fb2k.Name & vbCRLF & fb2k.ApplicationPath & vbCRLF & fb2k.ProfilePath

rem since this script is calling foobar2000 from another process,
rem the number of playlists may change while this loop is running,
rem luckily, the enumerator gets an immutable copy of the list of
rem playlists when it is created
WScript.Echo "--- Testing: get number of playlists"
WScript.Echo "There are " & pls.Count & " playlists containing a total of " & pls.GetTracks().Count & " tracks."
WScript.Echo "--- Testing: enumerate playlists"
DumpPlaylists

rem create a playlist
WScript.Echo "--- Testing: add playlist"
set pl = pls.Add("VBScript Test")
rem rename it
WScript.Echo "--- Testing: rename playlist"
pl.Name = "VBScript Test (renamed)"
rem add another playlist before that one and activate it
WScript.Echo "--- Testing: add and activate playlist"
set pl2 = pls.Add("VBScript Test 2", true)
rem DumpPlaylists
rem move it before first playlist
rem fbPositionFirst = 0
rem fbPositionLast = 1
rem fbPositionBefore = 2
rem fbPositionAfter = 3
WScript.Echo "--- Testing: reorder playlists"
pls.Move pl2, 0
pls.Move pl2, 3, pl
rem activate first playlist
WScript.Echo "--- Testing: activate playlist"
pls.ActivePlaylist = pl
rem remove second playlist
WScript.Echo "--- Testing: remove inactive playlist"
pls.Remove pl2
rem remove first playlist
WScript.Echo "--- Testing: remove active playlist"
pls.Remove pl
rem remove it again just to be sure (that the server can handle that)
WScript.Echo "--- Testing: remove stale playlist"
pls.Remove pl
rem try printing index of removed playlist
WScript.Echo "--- Testing: get index of stale playlist"
WScript.Echo "Removed playlist object now has index " & pl.Index
rem try to activate stale playlist
WScript.Echo "--- Testing: activate stale playlist"
pls.ActivePlaylist = pl

WScript.Echo "--- Testing: enumerate playlists"
DumpPlaylists

CleanupTest

rem *********************************************************
rem * helpers functions
rem *********************************************************

sub SetupTest()
	dim ProgID
	ProgID = "Foobar2000.Application.0.7"
	WScript.Echo "Looking for existing instance..."
	set fb2k = WScript.GetObject("", ProgID)
	if isnull(fb2k) then
		WScript.Echo "Creating new instance..."
		set fb2k = WScript.CreateObject(ProgID)
		if isnull(fb2k) then
			WScript.Echo "Failed to get foobar2000 Application object."
			WScript.Quit
		end if
	end if
	set pls = fb2k.Playlists
	if isnull(pls) then
		WScript.Echo "Failed to get foobar2000 Playlists object."
		WScript.Quit
	end if
	
	rem save settings

	rem connect event handlers
	WScript.ConnectObject pls, "playlists_"
end sub

sub CleanupTest()
	rem disconnect event handlers
	WScript.DisconnectObject pls
	
	rem restore settings
end sub

sub DumpPlaylists()
	dim tmp
	for each tmp in pls
		WScript.Echo "Playlist " & (tmp.Index+1) & " is named """ & tmp.Name & """ and contains " & tmp.GetTracks().Count & " tracks."
	next
end sub

rem *********************************************************
rem * event handler functions
rem *********************************************************

sub playlists_PlaylistAdded(index, obj, name)
	WScript.Echo "Added playlist at index " & (index + 1) & " with name """ & name & """"
end sub

sub playlists_PlaylistRemoved(index, obj)
	WScript.Echo "Removed playlist at index " & (index + 1)
end sub

sub playlists_PlaylistRenamed(index, obj, newName)
	WScript.Echo "Renamed playlist at index " & (index + 1) & " to """ & newName & """"
end sub

sub playlists_PlaylistActivated(index, obj)
	WScript.Echo "Activated playlist at index " & (index + 1)
end sub

sub playlists_PlaylistsReordered(first, last)
	WScript.Echo "Reordered playlists between index " & (first+1) & " and index " & (last+1)
end sub
