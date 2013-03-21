# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_5,2_6,2_7} )
# Tests crash with pypy

inherit distutils-r1 eutils flag-o-matic

DESCRIPTION="Tools for generating printable PDF documents from any data source."
HOMEPAGE="http://www.reportlab.com/ http://pypi.python.org/pypi/reportlab"
SRC_URI="http://www.reportlab.com/ftp/${P}.tar.gz
	http://www.reportlab.com/ftp/fonts/pfbfer-20070710.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc examples"

RDEPEND="dev-python/imaging
	media-fonts/ttf-bitstream-vera
	media-libs/libart_lgpl
	sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/unzip"

DISTUTILS_NO_PARALLEL_BUILD=1

src_unpack() {
	unpack ${P}.tar.gz
	cd ${P}/src/reportlab/fonts || die
	unpack pfbfer-20070710.zip
}

python_prepare_all() {
	sed -i \
		-e 's|/usr/lib/X11/fonts/TrueType/|/usr/share/fonts/ttf-bitstream-vera/|' \
		-e 's|/usr/local/Acrobat|/opt/Acrobat|g' \
		-e 's|%(HOME)s/fonts|%(HOME)s/.fonts|g' \
		src/reportlab/rl_config.py || die "sed failed"

	epatch "${FILESDIR}/${PN}-2.2_qa_msg.patch"

	rm -fr src/rl_addons/renderPM/libart_lgpl
	epatch "${FILESDIR}/${PN}-2.4-external_libart_lgpl.patch"

	epatch "${FILESDIR}/${PN}-2.5-pypy-implicit-PyArg_NoArgs.patch"
}

src_compile() {
	append-cflags -fno-strict-aliasing
	distutils-r1_src_compile
}

python_compile_all() {
	if use doc; then
		cd docs || die
		"${PYTHON}" genAll.py || die "docs generation failed"
	fi
}

python_test() {
	cd tests || die
	"${PYTHON}" runAll.py || die
}

python_install_all() {
	use doc && dodoc docs/*.pdf

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demos
		insinto /usr/share/doc/${PF}/tools/pythonpoint
		doins -r tools/pythonpoint/demos
	fi
}
