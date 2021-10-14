#!/bin/bash
# Set the port arpanel will use
export PORT="3030"

echo ""
echo "Starting arpanel..."
echo ""
echo "Using a browser, visit:"
echo "http://localhost:$PORT or http://[your-public-ip]:$PORT"
echo ""

nohup ./arpanel > logs/arpanel.log &
