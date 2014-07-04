#!bin/sh
#
# COMMAND: start a new container or restart a stopped container
#

# Command help function
start_help()
{
  echo "
Start a new container based on the image.

This runs the Dockerfile CMD for the image, which most likely
comes from the parent image, unless you overrode it in you
project Dockerfile

  -c|--container {container} : a particular container name (or ID) to search/create (allows multiple containers - create doesn't create IDs, just names)
       this is a bit tricky to use.  If you pass a short ID for an existing container, then it will be used
       to start the matching container.  If no match is found then a new container is started, using this
       value as a container name.
  -h|--hostname : a hostname to use inside a container, when starting the container (doesn't change a stopped container)
  -i|--image {image}
  -v|--version {version}

  $@ : if any additional attributes exist, then they will be used as a shell command

@NOTE this is a complex command but should have a simple implementation option
      with lot's of overrides.
@NOTE --temporary was removed because it conflicts with background containers, so it is confusing to the user

@TODO test for container is already running
"
}

# Command execute function
start_execute()
{
  container=${Docker_container}
  hostname="${Machine_hostname}"
  image="${Docker_image}"
  version="${Docker_imageversion}"

  flags=""
  while [ $# -gt 0 ]
  do
    case "$1" in
      -c|--container)
        container="$2"
        shift
        ;;
      -h|--hostname)
        hostname="${2}"
        shift
        ;;
      -i|--image)
        image="${2}"
        shift
        ;;
      -v|--version)
        version="${2}"
        shift
        ;;
      -*)
        echo >&2 "unknown flag $1 : run [-i|--image] {image} [-v|--version] {version} --temporary"
        break;; # terminate while loop
      *)
        break;
    esac
    shift
  done

  # Add the default flags to the end of the flaglist
  flags="${flags} ${Machine_runargs} ${Machine_mountvolumes}"      

  # Check for an existing container
  if _docker_container_exists ${container}; then
    # Run the start function
    debug "COMMAND: start [ handing off to docker start abstraction ] ==> docker_start --container ${container}"
    docker_start --container ${container}
  # start a new container based on the image
  else

    # if we don't have a container identifier, make one up.
    name="${image}_${version}"
    name="${container:-${name}}"

    # Run the run function
    debug "COMMAND: start [ handing off to docker abstraction ] ==> docker_run --image \"${image}\" --version \"${version}\" --name \"${name}\" --hostname \"${hostname}\" ${flags} $@"
    docker_run --image "${image}" --version "${version}" --name "${name}" --hostname "${hostname}" ${flags} $@
  fi
}