#!/bin/bash
#
# Original script written by Vird for Arweave mining on Vird's pool (https://ar.virdpool.com/)
# Github: https://github.com/virdpool/miner/blob/master/stop.sh
#
# Small mods have been made for arPanel usage. Functionality has not been modified.
#
../arweave/_build/prod/rel/arweave/bin/stop 2>/dev/null
../arweave/_build/virdpool_testnet/rel/arweave/bin/stop 2>/dev/null
kill `ps axww | grep node | grep proxy.coffee | awk '{print $1}'` 2>/dev/null
echo "stop ok"
