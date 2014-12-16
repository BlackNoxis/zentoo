# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/gentoo/${PN}.git"
else
	SRC_URI="http://dev.gentoo.org/~williamh/dist/${P}.tar.bz2"
	KEYWORDS="amd64"
fi

inherit toolchain-funcs

DESCRIPTION="base functions required by all gentoo systems"
HOMEPAGE="http://www.gentoo.org"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_prepare() {
	tc-export CC
}
