# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Gentoo specific zsh completion support (includes emerge and ebuild commands)"
HOMEPAGE="https://github.com/radhermit/gentoo-zsh-completions"
SRC_URI="http://dev.gentoo.org/~radhermit/dist/${P}.tar.xz"

LICENSE="ZSH"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=">=app-shells/zsh-4.3.5"

src_install() {
	insinto /usr/share/zsh/site-functions
	doins _*

	dodoc AUTHORS
}

pkg_postinst() {
	elog
	elog "If you happen to compile your functions, you may need to delete"
	elog "~/.zcompdump{,.zwc} and recompile to make the new completions available"
	elog "to your shell."
	elog
}
