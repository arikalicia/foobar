__module_name__ = "fb2kcomtest" 
__module_version__ = "1.0" 
__module_description__ = "Controls foobar2000 audio player through COM"
__module_author__ = "Holger stenger <holger.stenger@gmx.de>"

import win32com.client;

spec = "[%artist% - ]$if2(%title%,%_filename_ext%)' ['$if(%album%,%album%[ '('%date%')'],$if(%date%,%date%[ / %venue%]))[ #[%disc%/]$num(%tracknumber%,2)]']'[ '['%_length%', '%__bitrate%kbps $codec()']']"

testArtist = "Fink"

def test():
    try:
        ProgID = "Foobar2000.Application.0.7"
        fb2k = win32com.client.Dispatch(ProgID)
        print "- Testing playback interface..."
        try:
            playback = fb2k.Playback
            print "-- Testing playback orders interface..."
            try:
                pos = playback.Settings.PlaybackOrders
                print "--- Enumerating available playback orders:"
                for po in pos:
                    print po
                print "--- Converting name to GUID:"
                if pos.Count > 0:
                    name = pos[0]
                    guid = "<not retrieved>"
                    try:
                        guid = pos.GuidFromName(name)
                    except:
                        pass
                    print name, "->", guid
            except:
                print "There was an error."
        except:
            print "There was an error."
        print "- Testing media library interface..."
        try:
            ml = fb2k.MediaLibrary
            print "--- Rescanning media library."
            ml.Rescan()
            print "--- Getting all tracks:"
            tl = ml.GetTracks()
            print "There are", tl.Count, "tracks in the media library."
            print "--- Searching tracks:"
            tl2 = ml.GetTracks("artist IS " + testArtist)
            print "There are", tl2.Count, "tracks by " + testArtist + " in the media library."
            print "-- Testing track list interface..."
            try:
                tl3 = tl.GetTracks("artist IS " + testArtist)
                print "There are", tl3.Count, "tracks by " + testArtist + " in the track list retrieved from the media library."
            except:
                print "There was an error."
        except:
            print "There was an error."
    except:
        pass

test()
