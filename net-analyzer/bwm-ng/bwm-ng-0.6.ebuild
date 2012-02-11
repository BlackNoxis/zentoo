# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Bandwidth Monitor NG is a small and simple console-based bandwidth monitor"
SRC_URI="http://www.gropp.org/bwm-ng/${P}.tar.gz"
HOMEPAGE="http://www.gropp.org/"

KEYWORDS="amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="html csv"

DEPEND=">=sys-libs/ncurses-5.4-r4
	>=sys-apps/net-tools-1.60-r1"

src_compile() {
	econf \
		--with-ncurses \
		$(use_enable html) \
		$(use_enable csv) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
}
