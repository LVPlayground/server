# LVP Server
This repository contains the configuration for the Las Venturas Playground production servers. It
requires a very particular set-up in order to work as expected, please follow this guide carefully.

## Prerequisites
This guide assumes that the server has been checked out as part of the following commands:

    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
    git clone https://github.com/LVPlayground/echo-plugin.git
    git clone https://github.com/LVPlayground/json-plugin.git
    git clone https://github.com/LVPlayground/playground.git
    git clone https://github.com/LVPlayground/playgroundjs-plugin.git
    git clone https://github.com/samp-incognito/samp-streamer-plugin.git
    git clone https://github.com/LVPlayground/server.git
    git clone https://github.com/LVPlayground/zone-manager-plugin.git

Additionally, it assumes that all the plugins have been compiled to their intended versions.

Finally, you must have a `server.cfg-private` file. An example file has been included with this
repository, but this does not contain the values that Las Venturas Playground uses in production.

## Uploading the Pawn scripts
Upload all required filterscripts, gamemodes and npcmodes in their respective directories. Right
now the following files are required, and not included with this repository:

    gamemodes/lvp.amx

All required files must be open source.

## Initializing the server
An [initialization script](init.sh) has been included which sets up the directory with the required
links. It is safe to run this script multiple times. When updating the repository, execute:

    chmod +x init.sh && ./init.sh

Note that this must be executed **everytime** you update the repository, as it will create the
server's actual configuration files for you.

## Running the server
Due to the way the [PlaygroundJS plugin](https://github.com/LVPlayground/playgroundjs-plugin) has
been compiled, the `LD_LIBRARY_PATH` environment variable must be set. This has been wrapped in
the [server.sh](server.sh) script. Run the server by executing:

    ./server.sh
