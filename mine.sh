#!/bin/bash
#
# Original script written by Vird for Arweave mining on Vird's pool (https://ar.virdpool.com/)
# Github: https://github.com/virdpool/miner/blob/master/run.sh
#
# Small mods have been made for arPanel usage. Functionality has not been modified.
#
set -e
echo "Stopping any existing miner instances..."
./stop.sh

echo "Edit this file to set the following:"
echo "1. Set your own wallet address below for mining. Rewards will be sent to this wallet address."
echo "   Get your own Arweave Web Extension Wallet. (https://docs.arweave.org/info/wallets/arweave-web-extension-wallet)"
echo ""
echo "2. Set your arweave data directory using the 'data_dir' option. You need this if you have previously synced."
echo ""
echo "3. Do some performance tuning for better mining hashrate speeds. Edit the file to see notes."
echo ""

sleep 5

# Set your own wallet address for mining.
# Get the Arweave Web Extension Wallet: https://docs.arweave.org/info/wallets/arweave-web-extension-wallet
#
WALLET="30ICG06eFCrxobkMYqJK2e1kI6y_2V86wCmWre64t0s"
PORT="1984"

# Check if default port is available.
# Yes it will break if PORT > 65535 or PORT is non-numeric string. This code is intended to be a SIMPLE failover.
#
if [ `lsof -i -P -n | grep LISTEN | grep $PORT | wc -l` != "0" ]; then
  while [ `lsof -i -P -n | grep LISTEN | grep $PORT | wc -l` != "0" ]; do
    NEXT_PORT=$((PORT + 1))
    echo "$PORT port is occupied, probably by another Arweave node. Probing $NEXT_PORT"
    PORT=$((PORT + 1))
  done
  echo "I will use port $PORT"
fi

if [ ! -f "./internal_api_secret" ]; then
  openssl rand -base64 20 | sed 's/[=+\/]//g' > ./internal_api_secret
fi

INTERNAL_API_SECRET=`cat ./internal_api_secret`

# NOTE: Peers closer to your Arweave node may speed up the sync process.
#       You can pick peers from here https://explorer.ar.virdpool.com/#/peer_list
#
PEERS="peer 188.166.200.45 peer 188.166.192.169 peer 163.47.11.64 peer 139.59.51.59 peer 138.197.232.192"

# Start the Arweave node in mining mode.
# Log file: logs/arweave.log
#
# See notes below for setting additional options.
#
nohup ../arweave/_build/prod/rel/arweave/bin/start port $PORT pool_mine \
  internal_api_secret $INTERNAL_API_SECRET \
  $PEERS \
  > logs/arweave.log &

echo "wait for startup..."

sleep 60

# Start the mining proxy.
# Log file: logs/proxy.log
#
# If the proxy is submitting excessive stale solutions, consider reducing the stage_one_hashing_threads
#
# The mining proxy starts in a separate screen.
# To open (attach) the proxy screen: screen -r virdpool_proxy
# To close the proxy screen press in sequence: Ctrl + a, Ctrl + d
#
# To set your worker name use the following option:
# --worker your_worker_name
#
screen -dmS virdpool_proxy ./proxy_log.sh ./proxy.coffee --wallet $WALLET \
  --api-secret $INTERNAL_API_SECRET \
  --miner-url "http://127.0.0.1:$PORT" \
  --worker arpanel_worker


# SETTINGS & PERFORMANCE TUNING

#ulimit -n 1000000
#source ~/.bashrc
#source ~/.nvm/nvm.sh

# DATA DIR example
# ../arweave/_build/prod/rel/arweave/bin/start port $PORT pool_mine \
#   internal_api_secret $INTERNAL_API_SECRET \
#   data_dir /mnt/nvme1 \
#   $PEERS \
#   > logs/arweave.log &

# PERFORMANCE TUNING

# For large pages support you need to enable them.
# pick your value. More cpu cores - more ram needed to allocate (usually)
# sysctl -w vm.nr_hugepages=1000
# cat /proc/meminfo | grep HugePages

# Add these to increase your hashrate
#   enable randomx_jit          # will not work on some machines or can be even slower
#   enable randomx_large_pages  # requires large pages support, will crash if not available or not enough
#   enable randomx_hardware_aes # requires specific instruction set in your CPU

# Fully tuned setup should look like this
# ../arweave/_build/prod/rel/arweave/bin/start port $PORT pool_mine \
#   internal_api_secret $INTERNAL_API_SECRET \
#   $PEERS \
#   enable randomx_jit enable randomx_large_pages enable randomx_hardware_aes \
#   > logs/arweave.log &


# THREAD TUNING

# With thread tuning your startup will look like this (for 16 core CPU)
# ../arweave/_build/prod/rel/arweave/bin/start port $PORT pool_mine \
#   internal_api_secret $INTERNAL_API_SECRET \
#   $PEERS \
#   stage_one_hashing_threads 9 stage_two_hashing_threads 6 io_threads 4 randomx_bulk_hashing_iterations 20

# How to guess possible best values?
# Ratio based on your weave size. E.g. You have 100% of public weave.
# (11985/7555) : 1  = 1.586: 1 (total weave size / public weave size)
# IMPORTANT. But if you have less space than all public weave size you should recalculate values
# you can get fresh numbers here https://explorer.ar.virdpool.com/#/calculator/hashrate_mode=cpu&cpu_model=AMD%20THREADRIPPER%203990X&cpu_count=1&storage_count=1&storage_type=nvme_pcie3&storage_size=8796093022208

# Sample how to pick best value for 16 core CPU
# 10 : 6            = 1.67 : 1 (closest value, but can cause problems)
#  9 : 7            = 1.28 : 1 (alternative way too far from optimal)
#  9 : 6            = 1.5  : 1 (much more closer I guess less problematic, but 1 thread is underused if you have very fast NVMe (low load on IO threads) this can be suboptimal)

# In most cases it's better to have ratio LESS than `total weave size / public weave size`
# If you have too much stage_one_hashing_threads you will cause queue block, because stage 2 will have not enough workers to consume all read chunks.
# NOTE 100% usage of all threads should have bad impact on arweave node stability and overall system stability, use with care
# sum of your stage_one_hashing_threads + stage_two_hashing_threads should be less or equal your threads (for ryzen threads = 2*cores). threads-1, threads-2 is also ok, threads+1 can be also ok. Only benchmark will show the best
# keeping same ratio 1.67 for higher core CPU
# for 24 threaded CPU -> 15 : 9  (alternative 14 / 10 = 1.4 ; 14 / 9  = 1.55)
# for 32 threaded CPU -> 20 : 12 (alternative 19 / 13 = 1.46; 19 / 12 = 1.58)
# for 48 threaded CPU -> 30 : 18 (alternative 29 / 19 = 1.52; 29 / 18 = 1.61 (too much))
# for 64 threaded CPU -> 40 : 24 (alternative 39 / 25 = 1.56 which is closer)
# You can test alternative values. Keep what it best for your system

# io_threads - more threads - more load on your NVMe (higher is not always better)
# make sure that you have proper cooling on NVMe. Normal temperature 40-50° C. 60-70° - your NVMe will be throttling

# some suggestions for powerful CPUs
# if you have ryzen use `randomx_bulk_hashing_iterations 40`
# if you have threadripper/epyc use `randomx_bulk_hashing_iterations 60`
# NOTE It's not recommended to use both 100% of threads and high `randomx_bulk_hashing_iterations` value, arweave node requires some free CPU to sync and handle HTTP requests

# if you have separate NVMe for rocksdb folder - add `enable search_in_rocksdb_when_mining`
# in any other cases remove it. If you have < 1 TB free space pls note that blocks + txs will consume ~400 GB. Also <=2.4.4 chunk_storage stores only 256KB chunks, all other chunks are stored in rocksdb

# ../arweave/_build/prod/rel/arweave/bin/start port $PORT pool_mine \
#   internal_api_secret $INTERNAL_API_SECRET \
#   $PEERS \
#   enable search_in_rocksdb_when_mining \
#   > logs/arweave.log &

# There is some boost recipe from xmrig applicable to arweave mining
# https://xmrig.com/docs/miner/randomx-optimization-guide/msr
# https://github.com/xmrig/xmrig/blob/dev/scripts/randomx_boost.sh
