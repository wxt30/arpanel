#!/bin/bash
#
# Original script written by Vird for Arweave mining on Vird's pool (https://ar.virdpool.com/)
# Github: https://github.com/virdpool/miner/blob/master/sync.sh
#
# Small mods have been made for arPanel usage. Functionality has not been modified.


# Stop any existing Arweave instances
#
./stop.sh
ulimit -n 1000000

# Set your PEERS and data_dir as needed.
# Peers closer to your Arweave node may speed up the sync process.
# You can pick peers from here https://explorer.ar.virdpool.com/#/peer_list
#
# Log file: logs/arweave.log

PEERS="peer 188.166.200.45 peer 188.166.192.169 peer 163.47.11.64 peer 139.59.51.59 peer 138.197.232.192"
nohup ../arweave/_build/prod/rel/arweave/bin/start \
  $PEERS \
  sync_jobs 200 \
  > logs/arweave.log &
