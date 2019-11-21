#!/usr/bin/env bash

pid=`cat ../var/pid`
kill $pid
echo stop pid=$pid

celery multi stopwait w1 -A proj -l info \
--pidfile=../var/run/celery/%n.pid \
--logfile=../var/log/celery/%n%I.log

