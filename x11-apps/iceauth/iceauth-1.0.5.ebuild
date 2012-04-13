# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit xorg-2

DESCRIPTION="ICE authority file utility"

KEYWORDS="amd64"
IUSE=""

RDEPEND="x11-libs/libICE"
DEPEND="${RDEPEND}
	x11-proto/xproto"
