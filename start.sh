#!/bin/bash
# Copyright 2015 Las Venturas Playground. All rights reserved.
# Use of this source code is governed by the MIT license, a copy of which can
# be found in the LICENSE file.

# This script should be run on the server every minute using the following crontab:
#
#     * * * * * /usr/bin/nohup /home/jcmp/Server/start.sh > /dev/null 2>&1
#
# It will do all the necessary checks, detect whether a SA-MP server is running under the current
# UID and, if it isn't, rotate the log files and start the server.

cd "$(dirname "$0")"

# Do not remove this line. This is used for the cron backlog.
/bin/date "+%G-%m-%d %H:%M"

if [ ! -f gamemodes/lvp.amx ]; then
  echo "ERROR: The gamemodes/lvp.amx file does not exist."
  exit 1
fi

if [ ! -d logs ]; then
  mkdir logs
fi

if [[ $EUID -ne 0 ]]; then
  if [ "$(pgrep -U $EUID samp03svr)" ]
  then
    /bin/echo "Server is already running!" 2>&1
  else
    /bin/echo Copying log files to the logs directory
    /bin/cp server_log.txt logs/server_log_`/bin/date +%G-%m-%d_%H_%M`.txt
    /bin/echo Done!
    /bin/echo
    /bin/echo Clearing the current logfiles
    /bin/echo "" > server_log.txt
    /bin/echo Done!
    /bin/echo
    /bin/echo Starting the SA-MP server
    /usr/bin/nohup ./samp03svr &

    # Small timeout to let the server start.
    /bin/sleep 3
    /bin/echo `pgrep -U $EUID samp03svr` > server.pid
    /bin/echo SA-MP running with pid: `cat server.pid`
    exit 1
  fi
else
  /bin/echo "Do not start as root, ktnxbye!" 2>&1
fi