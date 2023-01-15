#!/bin/bash
CONFIG_PATH=/data/options.json

declare -x PORT=`jq -r '.PORT' $CONFIG_PATH`
declare -x SERVER=`jq -r '.SERVER' $CONFIG_PATH`
declare -x UART=`jq -r '.UART' $CONFIG_PATH`
declare -x SOCAT=`jq -r '.SOCAT' $CONFIG_PATH`
while true
do
	if [ "$SOCAT" = "true" ]; then
		echo "starting: /usr/bin/socat pty,link=$UART,waitslave tcp:$SERVER:$PORT,reuseaddr"
		sleep 10 && vzlogger --foreground -c /config/vzlogger_cfg/vzlogger.cfg & \
		pid=$!
		/usr/bin/socat -T 5 pty,link=$UART tcp:$SERVER:$PORT,reuseaddr
		kill $pid
		echo "finished"
		sleep 30
	else
		vzlogger --foreground -c /config/vzlogger_cfg/vzlogger.cfg
		sleep 30
	fi
	exit 1 # retry did result in bad states e.g. libsml: error: unrecognized sequence
done
