dim fb2k, playback, settings

SetupTest

WScript.Echo fb2k.Name & vbCRLF & fb2k.ApplicationPath & vbCRLF & fb2k.ProfilePath

settings.CursorFollowsPlayback = true
settings.PlaybackFollowsCursor = false
settings.StopAfterCurrent = true

if settings.ActivePlaybackOrder = "Repeat" then
	settings.ActivePlaybackOrder = "Default"
else
	settings.ActivePlaybackOrder = "Repeat (playlist)"
end if

dim pos, po
set pos = settings.PlaybackOrders
WScript.Echo "There are " & pos.Count & " playback orders available."
for each po in pos
	WScript.Echo po
next
if pos.Count > 0 then
	WScript.Echo "Unique identifier for " & pos(0) & " is " & pos.GuidFromName(pos(0))
end if

playback.Start true
playback.Pause
WScript.Sleep 10000
if playback.CanSeek then
	rem like playback.Seek playback.Position - 1 but avoids lag between reading position and seeking
	playback.SeekRelative -1
end if
playback.Stop

CleanupTest

rem *********************************************************
rem * helpers functions
rem *********************************************************

dim savedIsPlaying, savedIsPaused
dim savedPosition
dim savedCursorFollowsPlayback
dim savedPlaybackFollowsCursor
dim savedStopAfterCurrent
dim savedActivePlaybackOrder

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
	set playback = fb2k.Playback
	if isnull(playback) then
		WScript.Echo "Failed to get foobar2000 Playback object."
		WScript.Quit
	end if
	set settings = playback.Settings
	if isnull(settings) then
		WScript.Echo "Failed to get foobar2000 PlaybackSettings object."
		WScript.Quit
	end if
	
	rem save settings
	savedIsPlaying = playback.IsPlaying
	savedIsPaused = playback.IsPaused
	savedPosition = playback.Position
	savedCursorFollowsPlayback = settings.CursorFollowsPlayback
	savedPlaybackFollowsCursor = settings.PlaybackFollowsCursor
	savedStopAfterCurrent = settings.StopAfterCurrent
	savedActivePlaybackOrder = settings.ActivePlaybackOrder

	rem connect event handlers
	WScript.ConnectObject playback, "playback_"
	WScript.ConnectObject settings, "settings_"
end sub

sub CleanupTest()
	rem disconnect event handlers
	WScript.DisconnectObject settings
	WScript.DisconnectObject playback
	
	rem restore settings
	if savedIsPlaying then
		playback.Start true
		playback.Seek savedPosition
		if not savedIsPaused then
			playback.Pause
		end if
	end if
	settings.CursorFollowsPlayback = savedCursorFollowsPlayback
	settings.PlaybackFollowsCursor = savedPlaybackFollowsCursor
	settings.StopAfterCurrent = savedStopAfterCurrent
	settings.ActivePlaybackOrder = savedActivePlaybackOrder
end sub

rem *********************************************************
rem * event handler functions
rem *********************************************************

sub playback_Started()
	WScript.Echo "Playback started."
end sub

sub playback_Stopped(reason)
	dim msg
	msg = "Playback stopped"
	select case reason
	case 0 rem fbStopReasonUser
		msg = msg & " (requested by user)"
	case 1 rem fbStopReasonEOF
		msg = msg & " (end of file)"
	case 2 rem fbStopReasonStartingAnother
		msg = msg & " (starting another track)"
	case else
		msg = msg & " (stop reason " & reason & ")"
	end select
	msg = msg & "."
	WScript.Echo msg
end sub

sub playback_Paused(newVal)
	if newVal then
		WScript.Echo "Playback was paused."
	else
		WScript.Echo "Playback was unpaused."
	end if
end sub

sub playback_TrackChanged()
	WScript.Echo "Track changed. New track is " & playback.FormatTitle("""%_path_raw%"""" '('%_subsong%')'")
end sub

sub playback_PositionChanged(position, seeked)
	if seeked then
		WScript.Echo "Position changed (seeking)."
	end if
end sub

sub settings_CursorFollowsPlaybackChanged(newVal)
	WScript.Echo "Setting changed: Cursor follows playback. New value is " & newVal
end sub

sub settings_PlaybackFollowsCursorChanged(newVal)
	WScript.Echo "Setting changed: Playback follows cursor. New value is " & newVal
end sub

sub settings_StopAfterCurrentChanged(newVal)
	WScript.Echo "Setting changed: Stop after current. New value is " & newVal
end sub

sub settings_ActivePlaybackOrderChanged(newVal)
	WScript.Echo "Setting changed: Playback order. New value is " & newVal
end sub
