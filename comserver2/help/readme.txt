Installation
============

IMPORTANT: If you have a previous version of foo_comserver2 installed, please unregister it
as described in its documentation, before installing the new version.

Put foo_comserver2.dll into your components folder.

To register the server, run foobar2000.exe from the commandline with the /regsvr:comserver2
switch. This will enter some necessary information into the Windows Registry.

It is not possible to use this component with multiple foobar2000 installations on the same
machine, though this will hardly ever be a problem.


Uninstallation
==============

Unregister the server by running foobar2000.exe with the /unregsvr:comserver2 commandline
switch. This will remove the information the component added to the Windows Registry.

After that, you can safely delete foo_comserver2.dll.


Frequently asked questions
==========================

Q: Why is there a 2 in the name of this component?
A: foo_comserver2 is the second implementation of the idea behind the original foo_comserver
   component, using better tools and experience gained during development of the original.

Q: Wait, what is this foo_comserver thing? I have never heard of it.
A: foo_comserver is the predecessor of foo_comserver2, and is a foobar2000 v0.8.3 component.
   It never got past the prototype stage and was not officially released. Development of
   foo_comserver has stopped.

Q: I still use foobar2000 v0.8.3 as my main player and have foo_comserver installed for it.
   Can I use foo_comserver2 in addition to that?
A: Perhaps, depending on how you use it, but that is not officially supported.

Q: I have multiple installations of foobar2000. Can I install foo_comserver2 for each of them?
A: No, you can only use the component with one installation of foobar2000 on a given machine.

Q: I get an error 80040155 in Visual basic 6. How can this be solved?
A: Re-register foo_comserver using the /regsvr:comserver2 commandline switch for foobar2000.exe.
