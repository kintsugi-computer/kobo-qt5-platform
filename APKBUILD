# Contributor: Andreas Schaarschmidt <andreas.schaarschmidt@unknown.nowhere>
# Maintainer: Andreas Schaarschmidt <andreas.schaarschmidt@unknown.nowhere>
pkgname=kobo-qt5-platform
pkgver=1.0.0
pkgrel=0
pkgdesc="A Qt5 platform backend plugin for Kobo E-Ink devices"
url="https://github.com/Rain92/qt5-kobo-platform-plugin.git"
arch="armhf"
license="GPL3"
depends="qt5-qtbase libevdev i2c-tools eudev libxkbcommon libinput-libs mtdev"
makedepends="
	libevdev-dev
	i2c-tools-dev
	libxkbcommon-dev
	libinput-dev
	mtdev-dev
        qt5-qtbase-dev
"

provides="$pkgname-dev=$pkgver"
source="qt5-kobo-platform-plugin/libkobo.so"
options="!check"

prepare () {
	# patch the source directory. This included the qrc_Resources.cpp file,
	# because rcc cannot find the resource files in the Alpine build chroot
	cd "$startdir/qt5-kobo-platform-plugin"
	test -z "$(git status -s)" && git apply ../0001-Fixes-for-compilation-in-Alpine-chroot-on-Kobo.patch
	qmake
	make
}

package () {
	mkdir -p "$pkgdir/usr/lib/qt5/plugins/platforms"
	cp "$startdir/qt5-kobo-platform-plugin/libkobo.so" "$pkgdir/usr/lib/qt5/plugins/platforms"
}

cleanup () {
	cd $startdir
	if [ -e "/home/${USER}/packages/${USER}/armhf/$pkgname-$pkgver-r$pkgrel.apk" ]; then
		cp "/home/${USER}/packages/${USER}/armhf/$pkgname-$pkgver-r$pkgrel.apk" .
	fi
}

sha512sums="
eb7ee8f917f4fa0cdc50ff05c5e7790182e1b2b025d5ebb7f0c95fae484a4e62c5206f20f27acf2defbc36a87dcae52631777c5d55d81e8bec2911f71fe1f3fb  libkobo.so
"
