# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit versionator

MY_PN="gtk-doc"
MY_P=${MY_PN}-${PV}
MAJ_PV=$(get_version_component_range 1-2)

DESCRIPTION="Automake files from gtk-doc"
HOMEPAGE="http://www.gtk.org/gtk-doc/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PV}/${MY_P}.tar.xz"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6"
DEPEND="${RDEPEND}
	!<dev-util/gtk-doc-${MAJ_PV}"
# pkg-config is used by gtkdoc-rebase at runtime
# PDEPEND to avoid circular deps, bug 368301
PDEPEND="virtual/pkgconfig"

# This ebuild doesn't even compile anything, causing tests to fail when updating (bug #316071)
RESTRICT="test"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"

src_configure() {
	# Duplicate autoconf checks so we don't have to call configure
	local PERL=$(type -P perl)

	test -n "${PERL}" || die "Perl not found!"
	"${PERL}" -e "require v5.6.0" || die "perl >= 5.6.0 is required for gtk-doc"

	# Replicate AC_SUBST
	sed -e "s:@PERL@:${PERL}:g" -e "s:@VERSION@:${PV}:g" \
		"${S}/gtkdoc-rebase.in" > "${S}/gtkdoc-rebase" || die "sed failed!"
}

src_compile() {
	:
}

src_install() {
	fperms +x gtkdoc-rebase
	exeinto /usr/bin/
	doexe gtkdoc-rebase

	insinto /usr/share/aclocal
	doins gtk-doc.m4
}
