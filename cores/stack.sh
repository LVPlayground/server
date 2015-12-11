#!/bin/bash
# Copyright 2015 Las Venturas Playground. All rights reserved.
# Use of this source code is governed by the MIT license, a copy of which can
# be found in the LICENSE file.

SAMPSRV="samp03svr"

if [ -z "$1" ]; then
  echo "Usage: $0 [core]"
  exit
fi

if [ ! -f "$1" ]; then
  echo "Core does not exist: $1"
  exit
fi

CORE="$( readlink -f "$1" )"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."
SERVER="$DIR/$SAMPSRV"

/usr/bin/gdb --batch --cd "$DIR" --quiet -ex "thread apply all bt full" -ex "quit" "$SERVER" "$CORE" | grep -v "No symbol table"
