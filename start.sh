#!/bin/bash
set -euxo pipefail

/usr/sbin/xvfb-run --auto-servernum -f /var/run/xvfb/ibtws /usr/share/ib-tws/jre/bin/java \
-cp /usr/share/ib-tws/jars/*:/usr/share/java/ibcontroller/IBC.jar -Xmx512M ibcalpha.ibc.IbcTws config/config.ini
