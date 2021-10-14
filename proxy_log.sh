#!/bin/bash
$* 2>&1 | tee logs/proxy.log
