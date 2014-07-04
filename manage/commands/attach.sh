#!bin/sh
#
# COMMAND: Attach to a running container
#

# command help function
attach_help()
{
  echo "
Attach input and output to the container if it is running

This attaches the input and output of the current terminal
to the input and output of a running container.

  -c|--container {container} : override the default container name with an ID or name of a running container

@NOTE Existing the attach will likely exit the running container
if the command in the container accepts input

@TODO check for existing and running container
@TODO allow for only input or output
"
}

# Command execute function
attach_execute()
{
  container=${Docker_container}

  while [ $# -gt 0 ]
  do
    case "$1" in
      -c|--container)
        container="${2}"
        shift
        ;;
      -*)
        echo >&2 "unknown flag $1 : attach [-c|--container] {container}"
        exit
        ;;
      *)
        break;
    esac
    shift
  done

  # Run the stop function
  debug "COMMAND: attach [ handing off to docker abstraction ] ==> docker_attach ${attach}"
  docker_attach --container "${container}"
}