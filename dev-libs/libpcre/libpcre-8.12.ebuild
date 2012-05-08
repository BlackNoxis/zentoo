# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit libtool eutils toolchain-funcs

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
if [[ ${PV} == ${PV/_rc} ]]
then
	MY_P="pcre-${PV}"
	# Only the final releases are available here.
	SRC_URI="mirror://sourceforge/pcre/${MY_P}.tar.bz2
		ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/${MY_P}.tar.bz2"
else
	MY_P="pcre-${PV/_rc/-RC}"
	SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/Testing/${MY_P}.tar.bz2"
fi
LICENSE="BSD"
SLOT="3"
KEYWORDS="amd64"
IUSE="bzip2 +cxx unicode zlib static-libs +recursion-limit"

RDEPEND="bzip2? ( app-arch/bzip2 )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	userland_GNU? ( >=sys-apps/findutils-4.4.0 )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e "s:-lpcre ::" libpcrecpp.pc.in || die "Fixing libpcrecpp pkgconfig files failed"
	elibtoolize
}

src_configure() {
	[[ ${CHOST} == *-mint* ]] && CXXFLAGS="${CXXFLAGS} -D_GNU_SOURCE"
	econf --with-match-limit-recursion=$(use recursion-limit && echo 8192 || echo MATCH_LIMIT) \
		$(use_enable unicode utf8) $(use_enable unicode unicode-properties) \
		$(use_enable cxx cpp) \
		$(use_enable zlib pcregrep-libz) \
		$(use_enable bzip2 pcregrep-libbz2) \
		$(use_enable static-libs static) \
		--enable-shared \
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	gen_usr_ldscript -a pcre
	find "${D}" -type f -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
