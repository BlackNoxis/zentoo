# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils flag-o-matic multilib-minimal

DESCRIPTION="The Fast Lexical Analyzer"
HOMEPAGE="http://flex.sourceforge.net/"
SRC_URI="mirror://sourceforge/flex/${P}.tar.xz"

LICENSE="FLEX"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls static test"

# We want bison explicitly and not yacc in general #381273
RDEPEND="sys-devel/m4"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	nls? ( sys-devel/gettext )
	test? ( sys-devel/bison )"

src_configure() {
	use static && append-ldflags -static

	multilib-minimal_src_configure
}

multilib_src_configure() {
	# Do not install shared libs #503522
	ECONF_SOURCE=${S} \
	econf \
		--disable-shared \
		$(use_enable nls) \
		--docdir='$(datarootdir)/doc/'${PF}
}

multilib_src_compile() {
	if multilib_is_native_abi; then
		default
	else
		emake -f Makefile -f - lib <<< 'lib: $(lib_LTLIBRARIES)'
	fi
}

multilib_src_test() {
	multilib_is_native_abi && emake check
}

multilib_src_install() {
	if multilib_is_native_abi; then
		default
	else
		emake DESTDIR="${D}" install-libLTLIBRARIES install-includeHEADERS
	fi
}

multilib_src_install_all() {
	einstalldocs
	dodoc ONEWS
	prune_libtool_files --all
	rm "${ED}"/usr/share/doc/${PF}/{COPYING,flex.pdf} || die
	dosym flex /usr/bin/lex
}
