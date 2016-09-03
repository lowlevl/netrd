#!/bin/sh

### BEGIN INIT INFO
# Provides:		wifird
# Required-Start:	$remote_fs
# Required-Stop:	$remote_fs
# Should-Start:		$network
# Should-Stop:
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	Provides an easier way to repeat wifi.
# Description:		Simple and user-friendly wifi repeater software.
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin
DAEMON_SBIN=/root/WifiRepeater/wifird
DAEMON_DEFS=/etc/default/wifird
NAME=wifird
DESC="Simple and user-friendly wifi repeater software."
PIDFILE=/run/wifird.pid

. /lib/lsb/init-functions

case "$1" in
  start)
	log_deamon_msg "Starting $NAME deamon"
	start-stop-daemon -b --start --oknodo --exec "$DAEMON_SBIN" \
		--pidfile "$PIDFILE"
        log_msg_end $?
	;;
  stop)
	log_deamon_msg "Stopping $NAME deamon"
	start-stop-daemon --stop --oknodo --exec "$DAEMON_SBIN" \
		--pidfile "$PIDFILE"
        log_msg_end $?
  	;;
  reload)
	start-stop-daemon -b --stop --signal HUP --exec "$DAEMON_SBIN" \
		--pidfile "$PIDFILE"
	;;
  restart|force-reload)
  	$0 stop
	sleep 10
	$0 start
	;;
  status)
        status_of_proc "$NAME" "$DAEMON_SBIN" "system-wide $NAME" && exit 0 || exit $?
        ;;
  *)
	echo "Usage: $1 {start|stop|restart|force-reload|reload|status}"
	exit 1
	;;
esac

exit 0
