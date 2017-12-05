#!/bin/bash
set -euxo pipefail

ln -fs config ${USERID}

/usr/sbin/xvfb-run --auto-servernum -f /var/run/xvfb/ibtws /usr/share/ib-tws/jre/bin/java \
-cp /usr/share/ib-tws/jars/*:/usr/share/java/ibcontroller/ibcontroller.jar -Xmx512M ibcontroller.IBGatewayController config/config.ini
