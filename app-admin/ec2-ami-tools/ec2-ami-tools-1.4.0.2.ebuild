# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator

DESCRIPTION="These command-line tools serve as the client interface to the Amazon EC2 web service."
HOMEPAGE="http://developer.amazonwebservices.com/connect/entry.jspa?externalID=368&categoryID=88"
SRC_URI="http://s3.amazonaws.com/ec2-downloads/${P}.zip"

LICENSE="Amazon"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND="dev-lang/ruby[ssl]
	net-misc/rsync
	net-misc/curl"

S="${WORKDIR}/${P}"

src_prepare() {
	epatch "${FILESDIR}"/ec2-ami-tools-1.4.0.2-ruby19.patch
	find . -name '*.cmd' -delete || die
}

src_install() {
	insinto /opt/${PN}
	doins -r lib bin etc || die

	chmod 0755 "${D}/opt/${PN}/bin/"*

	dodir /etc/env.d
	cat - > "${T}"/99${PN} <<EOF
EC2_AMITOOL_HOME=/opt/${PN}
PATH=/opt/${PN}/bin
ROOTPATH=/opt/${PN}/bin
EOF
	doenvd "${T}"/99${PN}
}

pkg_postinst() {
	ewarn "Remember to run: env-update && source /etc/profile if you plan"
	ewarn "to use these tools in a shell before logging out (or restarting"
	ewarn "your login manager)"
}
