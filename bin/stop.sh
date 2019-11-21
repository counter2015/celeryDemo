#!/usr/bin/env bash

pid=`cat ../var/pid`
kill $pid
echo stop pid=$pid

projDir=`git rev-parse --show-toplevel`
cd $projDir

celery multi stopwait worker1 -A proj -l info \
--pidfile=$projDir/var/celery/%n.pid \
--logfile=$projDir/var/celery/%n%I.log

