= README =

Documentation is in the /docs folder. This readme is a quick intro.

BOCH is a bash command line tool, that is library and hook based, meant to 
provide project specific configuration, and extensibility, on top of a 
default set of functionality.

BOCH applications are based on a set of commands, each of which can have 
arbitrary hooks run before and after.  Commands and hooks are based in 
libraries, and libraries can be either project specific, user specific or
default (from this repo.)
A BOCH application is demarked by a .boch folder in it's root.  The boch
command line tool can be run anywhere inside that root, to affect the 
application.

Originally written for docker container management, the usefullness of the
docker approach fell quickly out of favour, but the tools is very easy to
user, and has persisted.

This Documentation can easily fall out of date, but the toolset itself includes
a good help system, and even offers help for all hooks used.

This README gives some installation instructions, and then some usage examples,
just to give an idea of how it works.

== DESIGN AND LANGUAGE ==

The tool is a POSIX compliant bash script collection.  It should probably be
something else, but it just sort of grew into what it is.
I started to rewrite it in PYTHON, but it is hard to keep some of the same
extensible functionality using PYTHON, and would make it basically a different
tool.
I haven't tested some of the newer aspect for POSIX compliant, but I believe
it is still something that can be run all over the place.  It uses `eval` a
few times, but it is not use any privilege escalation, and runs little else
other than shell commands, file commands, and of course some docker commands.

The layout of the application is library dependent, and all source is kept
in libraries.  Libraries can contain libraries, and can have libraries as
dependencies, so all code inclusion work in such a way.  The project specific
.boch folder, and a user ~/.boch are also libraries.
Commands are kept in any library, so they can be added to the application,
or the user.

== INSTALLATION ==

The tool can be installed centrally somewhere, to act like any application
on your system.  As long as you can run the primary script, it can be run from
anywhere on your system.  It behaves like git and vagrant, looking up the folder
tree for an indication of a project root.

Typically you can check it out into ~/lib/boch  and copy the provided bin template
to ~/bin to make it easily available across your system.

To get the source, clone it from github:

    $/> git clone git@github.com:james-nesbitt/boch.git
or
    $/> git clone https://github.com/james-nesbitt/boch.git

If you want to make a user bin, copy the script template into place like this:

    $/> cp docs/templates/boch ~/bin/boch
    
And modify the ${path_library} variable to point to where you have the git repo
root path.
If you don't want to do that, then you will just have to run the /boch scripts
with full path.  The toolset doesn't care which approach you take, you can keep
as many copies of the tools around, and even embed it into your project repo if
you want.
These documentation assume that you can run $/> boch directly, so consider that
in the following instructions.

=== PREPARING A PROJECT TO USE BOCH ===

the toolset runs like git and vagrant, in the it inspects the current path,
and all parent paths to look for a .boch folder.  The tool assumes that the
first parent to contain .boch is the project root.

If you are in your project root, and you want the toolset to know about it,
you can run

    $/> boch init

If you want to use a particular project name (which will be used as a default
for things like default image name, container name, hostname:

    $/> boch init --name "projectnamehere"

The straight init call is actually a short form of :

    $/> boch flow init --name "name"

If you like one of our www-server image then you can include a copy of it
for your project by adding this [THIS IS DOCKER SPECIFIC AND THE REFERRED
IMAGES ARE OBSOLETE]:

    $/> boch %builds:www-cnpm-jn flow init --name "name"
    $/> boch %builds:www-lamp-mk flow init --name "name"

You can get help using one of two equivalent forms:

    $/> boch -h flow init --name "name"  <-- just add the -h flag
    $/> boch help flow init              <-- use the help handler directly

    $/> boch help flow:init   <-- this is the syntax that the help system often gives

=== SOME ARCHITECTURE ===

Typical file layouts used:

project_root/
  source/   <-- your actual source code for your project

  .boch   <-- toolset settings for your particular project
                (you can automatically generate this, see below)

== SOME TYPICAL OPERATIONS ==

=== Get a list of settings used in your project ===

    $/> boch settings

Check help for settings:
    $/> boch settings help

=== Get a status report on your images and containers ===

    $/> boch flow status

Check help for status
    $/> boch help flow status

=== Stop/Restart a container [DOCKER LIBRARY REQUIRED] ===

    $/> boch stop
    $/> boch start

These are also short forms for commands:
    $/> boch command start
    $/> boch command stop

To get help on commands
    $/> boch -h command start
    $/> boch help command       <-- this gives a list of available commands

=== get help ===

    $/> manage/help
    $/> manage/control --help
    $/> manage/flow --help

    $/> manage/control --help {command} (e.g. manage/control --help build  OR   manage/help command:build)
    $/> manage/flow --help {flow}  (e.g. manage/flow --help init   OR   manage/help flow:init)
