#!bin/sh
#
# COMMAND: List containers
#

# Help function
ps_help()
{
 echo "
List container processors

  -c|--container {container} : override the default container name with an ID or name of a running container

@TODO check for existing and running container
"
}

# command execute function
ps_execute()
{
  container=${Docker_containerID}

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

  # Run the ps function
  debug "COMMAND: ps [ handing off to docker abstraction ] ==> docker_top --container ${container}"
  docker_top --container "${container}"
}
