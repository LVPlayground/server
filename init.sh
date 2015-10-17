#!/bin/bash
# Copyright 2015 Las Venturas Playground. All rights reserved.
# Use of this source code is governed by the MIT license, a copy of which can
# be found in the LICENSE file.

ln -s ../playground/data server/data
ln -s ../playground/javascript server/javascript

ln -s ../echo-plugin/src/out/echo-plugin.so server/plugins/echo-plugin.so
ln -s ../json-plugin/src/out/json-plugin.so server/plugins/json-plugin.so
# TODO: mysql-plugin.so
ln -s ../playgroundjs-plugin/src/out/playgroundjs-plugin.so server/plugins/playgroundjs-plugin.so
ln -s ../playgroundjs-plugin/src/out/libv8.so server/plugins/libv8.so
# TODO: streamer.so
ln -s ../zone-manager-plugin/src/out/zone-manager-plugin.so server/plugins/zone-manager-plugin.so
