#!/bin/bash
# Copyright 2015 Las Venturas Playground. All rights reserved.
# Use of this source code is governed by the MIT license, a copy of which can
# be found in the LICENSE file.

if [ ! -f server.cfg-private ]; then
  echo "You must have a server.cfg-private file to initialize the LVP server."
  exit 1
fi

chmod +x samp03svr samp-npc announce server.sh

if [ ! -d data ]; then
  ln -s ../playground/data data
fi

if [ ! -d data ]; then
  ln -s ../playground/javascript javascript
fi

if [ ! -f plugins/echo-plugin.so ]; then
  ln ../echo-plugin/src/out/echo-plugin.so plugins/echo-plugin.so
fi

if [ ! -f plugins/json-plugin.so ]; then
  ln ../json-plugin/src/out/json-plugin.so plugins/json-plugin.so
fi

# TODO: mysql-plugin.so

if [ ! -f plugins/playgroundjs-plugin.so ]; then
  ln ../playgroundjs-plugin/src/out/playgroundjs-plugin.so plugins/playgroundjs-plugin.so
fi

if [ ! -f libv8.so ]; then
  ln ../playgroundjs-plugin/src/out/libv8.so libv8.so
fi

if [ ! -f plugins/streamer.so ]; then
  ln ../samp-streamer-plugin/bin/linux/Release/streamer.so plugins/streamer.so
fi

if [ ! -f plugins/zone-manager-plugin.so ]; then
  ln ../zone-manager-plugin/src/out/zone-manager-plugin.so plugins/zone-manager-plugin.so
fi

# Create server.cfg by combining server.cfg-base and server.cfg-private
source server.cfg-private

eval "echo \"$(< server.cfg-base)\"" > server.cfg

echo "The LVP server has been initialized. You can now run it using:"
echo "$ ./server.sh"
