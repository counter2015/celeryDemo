#!/usr/bin/env bash

# locate source script dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ ${TARGET} == /* ]]; then
    echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'"
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')"
    SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done

RDIR="$( dirname "$SOURCE" )"
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

# prepare data dir
projDir=`git rev-parse --show-toplevel`
dir_names=($projDir"var/celery")
for dir_name in ${dir_names[@]}
do
  if [ ! -d ${dir_name} ]; then
    mkdir -p ${dir_name}
    echo "mkdir at $dir_name"
  fi
done

# migrate database schema
env="$projDir/env/bin/activate"
if [ -f ${env} ]; then
  echo "use venv : $env"
  source $projDir/env/bin/activate
else
  echo "venv not found, use local environment"
fi

python "$projDir/manage.py" migrate

