## bearDropper 

**A fork of dropbear log parsing ban agent for OpenWRT 22.03 (nftables rewrite of dropBrute.sh by @robzr)** - @marjancinober

**Revised for using nft set functionality to store blacked IPs with support for IPv6 blacklist by Xiang Xiao**
[![License: AGPLv3](https://www.gnu.org/graphics/agplv3-88x31.png)](https://www.gnu.org/licenses/agpl-3.0.html)
[![License: CC BY-SA 4.0](https://licensebuttons.net/l/by-sa/4.0/80x15.png)](https://creativecommons.org/licenses/by-sa/4.0/)

OpenWRT (22.03) script for blocking repeated invalid dropbear ssh connection attempts (embedded fail2ban)

**Status**

Working, no known issues. Beta nftables port, forked from https://github.com/robzr/bearDropper .

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

**TBD**

 - Port the sister project sub2rbl for RBL based banning: https://github.com/robzr/sub2rbl to nftables
 - Add optional freegeoip.net lookups for (de|ac)cellerated banning
 - implement whitelist
 - CIDR processing for bans & whitelists
 - self expiring ipset based ban list
 - package and submit to openwrt repo once it's reasonably bug free
 - ipv6 support

**Contributions**
 - If you find it helpful, please consider contributing  
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](https://www.contributor-covenant.org/) &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;bitcoincash:qzj8xjuxl4u8p3vw720nya2m2e8jc8a6uge4n5q4dx  

&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<img src="src/assets/bitcoincash.svg" height="60"> &emsp;<img src="src/assets/bitcoincash_qzj8xjuxl4u8p3vw720nya2m2e8jc8a6uge4n5q4dx.png" alt="bitcoincash:qzj8xjuxl4u8p3vw720nya2m2e8jc8a6uge4n5q4dx" />


Also see the sister project sub2rbl for RBL based banning: https://github.com/robzr/sub2rbl

Discussion of this project: https://forum.openwrt.org/t/fail2ban-replacement-and-rbl-firewall-syncing-in-lightweight-ash/159730

