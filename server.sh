#!/bin/bash
# Copyright 2015 Las Venturas Playground. All rights reserved.
# Use of this source code is governed by the MIT license, a copy of which can
# be found in the LICENSE file.

if [ ! -f gamemodes/lvp.amx ]; then
  echo "ERROR: The gamemodes/lvp.amx file does not exist."
  exit 1
fi

LD_LIBRARY_PATH=./ ./samp03svr
