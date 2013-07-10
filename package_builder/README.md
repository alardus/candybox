package_builder
===============

- candybox-'kernel.version'-'package.version' - package contains a set of original 'deploy' configs and scripts and are easy to upgrade (just download a new version of this package and you’re done).

- xl2tpd-modules-'kernel.version' - package contains xl2tp_ modules builded for current upstream kernel version, needed for running xl2tpd daemon builded with kernel support

- xl2tpd-kernel_'xl2tpd.version'+dfsg-'package.version'_'arch' - a simple wrapper for renaming package from 'xl2tpd' to 'xl2tpd-kernel', that helps avoiding conflict with package 'xl2tpd' in Raspbian repository.

- repo-update.sh - builds packages 'candybox', 'xl2tpd-kernel' and creates Packages.gz for those packages. After that you may copy folder 'ubuntu' content to repository.