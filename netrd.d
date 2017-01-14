#!/bin/sh

### BEGIN INIT INFO
# Provides:		netrd.d
# Required-Start:	$remote_fs
# Required-Stop:	$remote_fs
# Should-Start:		$network
# Should-Stop:
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	Easy wifi auto configured AP.
# Description:		Simple and user-friendly wifi AP.
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin

DIR=/root/netrd
NAME=netrd
DAEMON=$DIR/$NAME

PIDFILE=/run/$NAME.pid

. /lib/lsb/init-functions

case "$1" in
  start)
	log_daemon_msg "Starting $NAME deamon"
	start-stop-daemon -b --start --oknodo --exec "$DAEMON" \
		--pidfile "$PIDFILE"
        log_end_msg $?
	;;
  stop)
	log_daemon_msg "Stopping $NAME deamon"
	start-stop-daemon --stop --oknodo --exec "$DAEMON" \
		--pidfile "$PIDFILE"
        log_end_msg $?
  	;;
  reload)
	start-stop-daemon -b --stop --signal HUP --exec "$DAEMON" \
		--pidfile "$PIDFILE"
	;;
  restart|force-reload)
  	$0 stop
	sleep 2
	$0 start
	;;
  status)
        status_of_proc "$NAME" "$DAEMON" "system-wide $NAME" && exit 0 || exit $?
        ;;
  *)
	echo "Usage: $1 {start|stop|restart|force-reload|reload|status}"
	exit 1
	;;
esac

exit 0
