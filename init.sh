#!/bin/bash
# Copyright 2015 Las Venturas Playground. All rights reserved.
# Use of this source code is governed by the MIT license, a copy of which can
# be found in the LICENSE file.

if [ ! -f server.cfg-private ]; then
  echo "You must have a server.cfg-private file to initialize the LVP server."
  exit 1
fi

chmod +x samp03svr samp-npc announce start.sh cores/stack.sh

if [ ! -d data ]; then
  ln -s ../playground/data data
fi

if [ ! -d javascript ]; then
  ln -s ../playground/javascript javascript
fi

if [ ! -f plugins/json-plugin.so ]; then
  ln -s ../../json-plugin/src/out/json-plugin.so plugins/json-plugin.so
fi

if [ ! -f plugins/mysql-plugin.so ]; then
  ln -s ../../mysql-plugin/src/out/mysql-plugin.so plugins/mysql-plugin.so
fi

if [ ! -f plugins/playgroundjs-plugin.so ]; then
  ln -s ../../playgroundjs-plugin/src/out/playgroundjs-plugin.so plugins/playgroundjs-plugin.so
fi

if [ ! -f libchrome_zlib.so ]; then
  ln -s ../playgroundjs-plugin/src/out/libchrome_zlib.so libchrome_zlib.so
fi

if [ ! -f libv8.so ]; then
  ln -s ../playgroundjs-plugin/src/out/libv8.so libv8.so
fi

if [ ! -f libv8_libbase.so ]; then
  ln -s ../playgroundjs-plugin/src/out/libv8_libbase.so libv8_libbase.so
fi

if [ ! -f libv8_libplatform.so ]; then
  ln -s ../playgroundjs-plugin/src/out/libv8_libplatform.so libv8_libplatform.so
fi

if [ ! -f icudtl.dat ]; then
  ln -s ../playgroundjs-plugin/src/out/icudtl.dat icudtl.dat
fi

if [ ! -f libicui18n.so ]; then
  ln -s ../playgroundjs-plugin/src/out/libicui18n.so libicui18n.so
fi

if [ ! -f libicuuc.so ]; then
  ln -s ../playgroundjs-plugin/src/out/libicuuc.so libicuuc.so
fi

if [ ! -f plugins/streamer.so ]; then
  ln -s ../../samp-streamer-plugin/bin/linux/Release/streamer.so plugins/streamer.so
fi

if [ ! -f plugins/zone-manager-plugin.so ]; then
  ln -s ../../zone-manager-plugin/src/out/zone-manager-plugin.so plugins/zone-manager-plugin.so
fi

# Create server.cfg by combining server.cfg-base and server.cfg-private
source server.cfg-private

eval "echo \"$(< server.cfg-base)\"" > server.cfg

# Clear the server_log.txt file from previous versions of this script.
echo > server_log.txt

echo "The LVP server has been initialized. You can now run it using:"
echo "$ ./start.sh"
