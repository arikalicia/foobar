option explicit

dim fb2k, ml

rem testArtist is used for testing the ML query feature
dim testArtist
testArtist = "Fink"

SetupTest

WScript.Echo fb2k.Name & vbCRLF & fb2k.ApplicationPath & vbCRLF & fb2k.ProfilePath

dim tl, tl2, tl3

set tl = ml.GetTracks()
WScript.Echo "There are " & tl.Count & " tracks in the media library."

set tl2 = tl.GetSortedTracks("%path%|$num(%subsong%,3)", "artist IS " & LCase(testArtist))
WScript.Echo "There are " & tl2.Count & " tracks by " & testArtist & " in the media library."

set tl3 = tl.GetTracks("artist IS " & LCase(testArtist))
WScript.Echo "There are " & tl2.Count & " tracks by " & testArtist & " in track list retrieved from the media library."

dim n, t
n = 0
for each t in tl2
	n = n+1
	WScript.Echo "Track " & n & " is """ & t.Path & """ / index: " & t.Index
	Wscript.Echo "   Info on this track: " & t.FormatTitle("%artist% - %album% - %tracknumber%. %title%")
next

WScript.Echo "Testing invalid query string..."
tl = null
on error resume next
set tl = ml.SearchTracks("(artist IS")
on error goto 0
if isnull(tl) then
	WScript.Echo "Expected error occurred."
end if

CleanupTest

WScript.Quit

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
			WScript.Echo "Failed to get foobar2000 application object."
			WScript.Quit
		end if
	end if
	set ml = fb2k.MediaLibrary
	if isnull(ml) then
		WScript.Echo "Failed to get foobar2000 media library object."
		WScript.Quit
	end if
	
	rem save settings
end sub

sub CleanupTest()
	rem restore settings
end sub
