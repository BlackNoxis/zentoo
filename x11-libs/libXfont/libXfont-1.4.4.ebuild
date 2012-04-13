# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

XORG_DOC=doc
inherit xorg-2

DESCRIPTION="X.Org Xfont library"

KEYWORDS="amd64"
IUSE="ipv6"

RDEPEND="x11-libs/xtrans
	x11-libs/libfontenc
	>=media-libs/freetype-2
	app-arch/bzip2
	x11-proto/xproto
	x11-proto/fontsproto"
DEPEND="${RDEPEND}"

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable ipv6)
		$(use_enable doc devel-docs)
		$(use_with doc xmlto)
		--with-bzip2
		--without-fop
		--with-encodingsdir="${EPREFIX}/usr/share/fonts/encodings"
	)
}
