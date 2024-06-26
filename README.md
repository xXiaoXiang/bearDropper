## bearDropper 

**A fork of dropbear log parsing ban agent for OpenWRT 22.03 \[(nftables rewrite of dropBrute.sh by @robzr)- @marjancinober\] updated by Xiang Xiao** 

**Revised for using nft set functionality to store blacked IPs with support for IPv6 blacklist by Xiang Xiao**
[![License: AGPLv3](https://www.gnu.org/graphics/agplv3-88x31.png)](https://www.gnu.org/licenses/agpl-3.0.html)
[![License: CC BY-SA 4.0](https://licensebuttons.net/l/by-sa/4.0/80x15.png)](https://creativecommons.org/licenses/by-sa/4.0/)

OpenWRT (22.03) script for blocking repeated invalid dropbear ssh connection attempts (embedded fail2ban)

**Status**

Working, no known issues. Beta nftables set and IPv6 support, forked from https://github.com/marjancinober/bearDropper .

**Dependencies** 

None! Written entirely in busybox ash, uses all standard OpenWRT 22.03 commands with new fw4 nftables v1.0.2 (Lester Gooch).

**Installation**

To install or upgrade to the latest bearDropper, run:

	wget -qO- https://raw.githubusercontent.com/xXiaoXiang/bearDropper/master/install.sh | sh

 - To modify the config options, edit the uci config file (/etc/config/bearDropper)
 - Use bearDropper -h to see options for runtime config (runtime options override uci config options)
 - Consider increasing your syslog ring buffer size (/etc/config/system option log_size)

**Logging**

 - logs to the syslog ring buffer by default (view with the logread command)
 - logs to stdout with "-f stdout" (or logFacility config option)
 - increaser verbosity with "-l 2" (or logLevel config option)

**Features**

 - small size, low memory footprint, no external dependencies
 - uses uci for config, overridable via command line arguments
 - uses a state database which periodically syncs to iptables (for resiliency)
 - can sync state database to persistent storage, with logic to avoid excessive flash writes
 - state database supports optional compression
 - uses highly readable BIND time syntax for all time values (ex: 9d2h3s is 9 days, 2 hours, 3 seconds)
 - runs in the background for realtime monitoring when run via included init script
 - can also be run by hand to process historical log entries
 - self installs into iptables for simple and reliable setup (easily disabled)
 - conservative input validation for security


