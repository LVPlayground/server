#!/bin/bash
# Copyright 2015 Las Venturas Playground. All rights reserved.
# Use of this source code is governed by the MIT license, a copy of which can
# be found in the LICENSE file.

# This script should be run on the server every minute using the following crontab:
#
#     * * * * * /usr/bin/nohup /path/to/server/start.sh > /dev/null 2>&1
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

if [ ! -d cores ]; then
  mkdir cores
fi

if [[ $EUID -ne 0 ]]; then
  if [ "$(pgrep -U $EUID samp03svr)" ]
  then
    /bin/echo "Server is already running!" 2>&1
  else
    if [ -z "$PS1" ]; then
      read -p "Do you want to update the JavaScript code [Y/N]? " -n 1 -r
      echo

      if [[ $REPLY =~ ^[Yy]$ ]]
      then
        pushd ../playground/
        git pull --rebase
        popd
      fi
    fi

    /bin/echo Copying log files to the logs directory
    /bin/cp server_log.txt logs/server_log_`/bin/date +%G-%m-%d_%H_%M`.txt
    if [ -f core ]; then
      /bin/mv core cores/core_`/bin/date +%G-%m-%d_%H_%M`
    fi
    /bin/echo Done!
    /bin/echo
    /bin/echo Clearing the current logfiles
    /bin/echo "" > server_log.txt
    /bin/echo Done!
    /bin/echo
    /bin/echo Starting the SA-MP server
    LD_LIBRARY_PATH=. /usr/bin/nohup ./samp03svr &

    # Small timeout to let the server start.
    /bin/sleep 3
    /bin/echo `pgrep -U $EUID samp03svr` > server.pid
    /bin/echo SA-MP running with pid: `cat server.pid`
    exit 1
  fi
else
  /bin/echo "Do not start as root, ktnxbye!" 2>&1
fi
