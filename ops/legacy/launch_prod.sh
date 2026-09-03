#!/bin/bash
setsid nohup /tmp/opencode/restore_server.sh > /tmp/opencode/llama_server_restore.log 2>&1 < /dev/null &
