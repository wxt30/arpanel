#!/bin/bash
echo ""
echo "Stopping arPanel..."
kill -9 `ps axww | grep arpanel | awk '{print $1}'` 2>/dev/null
echo ""
