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
celery multi start worker1 -A celeryDemo -l info \
--pidfile=../var/run/celery/%n.pid \
--logfile=../var/log/celery/%n%I.log