#!bin/sh
#
# COMMAND: Remove a container
#

# Command help function
remove_help()
{
  echo "
Delete the container

  -c|--container {container} : override the default container name with an ID or name of a running container
  -k|--hook {hook} : pass a function name for a hook to be run 

@TODO check for existing and running container
@TODO ask for confirmation
"
}

# command execute function
remove_execute()
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
        echo >&2 "unknown flag $1 : stop [-c|--container] {container}"
        exit
        ;;
      *)
        break;
    esac
    shift
  done

  # deal with a hook if it set
  if [ -z ${hook} ]; then
    flags="$flags --emptyhook ${hook}"
  fi

  # Run the rm function
  debug "COMMAND: stop [ handing off to docker abstraction ] ==> docker_stop --container ${container}"
  docker_rm --container "${container}"
}