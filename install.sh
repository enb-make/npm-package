#!/bin/sh

curl https://raw.github.com/enb-make/npm-package/master/init.sh > /tmp/npm-package-init.sh
sh /tmp/npm-package-init.sh < /dev/stdin
rm /tmp/npm-package-init.sh
