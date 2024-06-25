#!/bin/sh
# https://github.com/marjancinober/bearDropper
# forked from https://github.com/robzr/bearDropper
# revised by xXiaoXiang
# bearDropper install script - @marjancinober

if [ -f /etc/init.d/bearDropper ] ; then
  echo Detected previous version of bearDropper - stopping
  /etc/init.d/bearDropper stop
fi
echo -e 'Retrieving and installing latest version'
wget -qO /etc/init.d/bearDropper https://raw.githubusercontent.com/xXiaoXiang/bearDropper/master/src/init.d/bearDropper 
wget -qO /etc/config/bearDropper https://raw.githubusercontent.com/xXiaoXiang/bearDropper/master/src/config/bearDropper
wget -qO /usr/sbin/bearDropper https://raw.githubusercontent.com/xXiaoXiang/bearDropper/master/bearDropper
chmod 755 /usr/sbin/bearDropper /etc/init.d/bearDropper
echo -e 'Processing historical log data (this can take a while)'
/usr/sbin/bearDropper -m entire -f stdout
echo -e 'Starting background process'
/etc/init.d/bearDropper enable
/etc/init.d/bearDropper start

dropbear_count=$(uci show dropbear | grep -c =dropbear)
dropbear_count=$((dropbear_count - 1))
for instance in $(seq 0 $dropbear_count); do
  dropbear_verbose=$(uci -q get dropbear.@dropbear[$instance].verbose || echo 0)
  if [ $dropbear_verbose -eq 0 ]; then
    uci set dropbear.@dropbear[$instance].verbose=1 
    dropbear_conf_updated=1
  fi
done
if [ $dropbear_conf_updated ]; then
  uci commit
  /etc/init.d/dropbear restart
  echo "Verbose logging was configured and dropbear service restarted to enable this change."
fi
