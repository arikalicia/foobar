dim helper
set helper = CreateObject("Foobar2000.ApplicationHelper.0.7")

dim bQuit

helper_ServerStateChanged(helper.Running)
bQuit = false

WScript.ConnectObject helper, "helper_"

do until bQuit
	WScript.Sleep 1000
loop

sub helper_ServerStateChanged(bRunning)
	if bRunning then
		WScript.Echo "Server running"
	else
		WScript.Echo "Server not running"
		bQuit = true
	end if
end sub
