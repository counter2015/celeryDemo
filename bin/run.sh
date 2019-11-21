#!/usr/bin/env bash

env="../env/bin/activate"
if [ -f ${env} ]; then
  echo "use venv : $env"
  source ../env/bin/activate
else
  echo "venv not found, use local environment"
fi

nohup python3 "../manage.py" runserver 0:8011 >> ../var/server.log_`date "+%Y-%m-%d"` 2>&1 &
pid=$!
echo pid=$pid
echo $pid > ../var/pid

projDir=`git rev-parse --show-toplevel`
cd $projDir


celery multi start worker1 -A celeryDemo -l info \
--pidfile=$projDir/var/celery/%n.pid \
--logfile=$projDir/var/celery/%n%I.log