#!/usr/bin/env bash
projDir=`git rev-parse --show-toplevel`

pid=`cat $projDir/var/pid`
kill $pid
echo stop pid=$pid


cd $projDir

celery multi stopwait worker1 -A proj -l info \
--pidfile=$projDir/var/celery/%n.pid \
--logfile=$projDir/var/celery/%n%I.log

