#!/bin/sh


[ -f /etc/default/swarm-manager ] || exit 1
[ -f /etc/systemd/system/swarm-manager.service ] || exit 1

diff 1/swarm-manager /etc/default/swarm-manager || exit 1
diff 1/swarm-manager.service /etc/default/swarm-manager.service || exit 1
