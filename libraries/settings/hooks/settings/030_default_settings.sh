#!/bin/sh
#
# Configurable settings for the project
#
# @todo : move some of this to yaml?

hook_version=2
hook_root="hook_settings_030"

# description method
hook_settings_030_description()
{
  echo "hook->settings 030 : default variable values"
}

# help method
hook_settings_030_help()
{
  echo "
hook->settings 030 : default variable values

In this hook we include an early set of default settings to configure the system. These
settings incluee information about which builds are being built, which folders are being
used, and what settings to pass to the docker abstraction.
"
}

# execute method
hook_settings_030_execute()
{

  # NOT Overrideable configuration variables
  



  # Overrideable configuration variables

  ####
  # Important paths for the source code
  #

  # =path to custom settings and data=
  # various settings about custom configurations
  #
  # - settings.sh : this file
  #
  #path_data="\${path_project}/data"

  # path to the log file
  # @NOTE to enable logging try passing --log [{level}] to you command line
  #path_log="\${path_log}"

  ###
  # Project settings
  #
  # some project related settings
  #

  # Project name : this gets used as a default all over the place
  project_name=\"${project_name:-project}\"

  ###
  # Docker image configurations
  #

  # Required build images
  #
  # Generally needed to start making containers (a space separated queue of builds)
  # and are the default docker builds built with the flow init command.
  # Change this if your build image has a different name, or if it has different
  # parent images that need building.
  #required_builds="${required_builds:-""}"

  # Project build and image
  #
  # which build (folder) should be used for project images (if it isn't built)
  project_build="${project_build:-project}"
  # which image should we use for creating containers (and build it if it is missing)
  project_image="${project_image:-project}"
  # which image version/tag should we use for containers
  project_imageversion="${project_imageversion:-latest}"

  ###
  # Docker Container configurations
  #

  # OS hostname used inside the container (which would impact things like avahi)
  machine_hostname="${machine_hostname:-Project_name}"

  # Machine arguments for regular container runs.  These arguments are added to all runs (except shell runs)
  # @NOTE these are arguments for \"docker run\". Check that docker command to learn more
  machine_runargs="--tty" # --tty is needed for supervisord to run.

  ###
  # Prefered shell configuration for the Machine
  #
  # Running as a shell is a temporary approach to getting shell access to a machine
  # but should be considered secondary to other methods of running commands on the
  # container.  It is a good plan for now but will be dropped in the future.
  #
  # @NOTE Running a shell creates a new container, but does not give access to an existing container
  #
  # @NOTE if you are using our builds, then zsh is available
  machine_shell="/bin/bash"
  # arguments for docker run that should always be included when starting a shell: docker help run
  # @NOTE you should probably take a look at docker run to learn more
  # @NOTE our builds have a developer user created
  machine_shellrunargs="--publish-all=true"

  ###
  # Mount list:
  #
  # These are run time mounts, where the host FS can be changed
  # directly changing the container FS.
  #

}
