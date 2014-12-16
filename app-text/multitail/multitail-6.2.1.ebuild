# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Tail with multiple windows"
HOMEPAGE="http://www.vanheusden.com/multitail/"
SRC_URI="http://www.vanheusden.com/multitail/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug examples unicode"

RDEPEND="sys-libs/ncurses[unicode?]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
RESTRICT="test" # bug #492270

src_prepare() {
	epatch "${FILESDIR}"/${PN}-6.0-as-needed.patch

	use x86-interix && epatch "${FILESDIR}"/${PN}-5.2.6-interix.patch

	sed \
		-e '/gcc/d' \
		-e '/scan-build/d' \
		-e 's:make clean::g' \
		-e "/^DESTDIR/s:=.*$:=${EROOT}:g" \
		-i Makefile || die

	tc-export CC PKG_CONFIG

	use debug && append-flags "-D_DEBUG"
}

src_configure() {
	emake UTF8_SUPPORT=$(usex unicode)
}

src_install () {
	dobin multitail

	insinto /etc
	doins multitail.conf

	dodoc Changes readme.txt thanks.txt
	doman multitail.1

	dohtml manual.html

	docinto examples
	use examples && dodoc colors-example.{pl,sh} convert-{geoip,simple}.pl
}
