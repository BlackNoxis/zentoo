# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Manage multiple Emacs versions on one system"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND=">=app-admin/eselect-1.2.6
	~app-admin/eselect-ctags-${PV}"

src_install() {
	insinto /usr/share/eselect/modules
	doins {emacs,etags}.eselect || die
	doman {emacs,etags}.eselect.5 || die
	dodoc ChangeLog || die
}
