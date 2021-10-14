#!/bin/bash
#
# Original script written by Vird for Arweave mining on Vird's pool (https://ar.virdpool.com/)
# Github: https://github.com/virdpool/miner/blob/master/sync.sh
#
# Small mods have been made for arPanel usage. Functionality has not been modified.


# Stop any existing Arweave instances
#
./stop.sh
#ulimit -n 1000000

# Set your PEERS and data_dir as needed.
# Log file: logs/arweave.log
#
# PEERS=peer 188.166.200.45 peer 188.166.192.169 peer 163.47.11.64 peer 139.59.51.59 peer 138.197.232.192"
PEERS="peer 65.21.33.240:1984 peer 39.173.177.122:1984 peer 117.148.168.232:1984 peer 157.90.92.225:1984 peer 157.90.92.240:1984 peer 161.97.87.18:1984 peer 157.90.92.241:1984 peer 157.90.92.234:1984 peer 135.181.142.202:1984 peer 157.90.92.244:1984 peer 157.90.92.227:1984 peer 157.90.92.245:1984 peer 157.90.92.230:1984 peer 157.90.90.245:1984 peer 157.90.92.232:1984 peer 157.90.92.228:1984 peer 157.90.93.177:1984"
nohup ../arweave/_build/prod/rel/arweave/bin/start \
  $PEERS \
  data_dir /home/service/arweave-data \
  sync_jobs 200 \
  > logs/arweave.log &
