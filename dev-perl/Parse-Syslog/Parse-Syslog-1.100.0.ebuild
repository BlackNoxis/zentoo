# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=DSCHWEI
MODULE_VERSION=1.10
inherit perl-module

DESCRIPTION="Parse::Syslog - Parse Unix syslog files"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="virtual/perl-Time-Local
	dev-perl/File-Tail"
DEPEND="${RDEPEND}"

SRC_TEST="do"
