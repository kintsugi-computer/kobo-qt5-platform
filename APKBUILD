# Contributor: Andreas Schaarschmidt <andreas.schaarschmidt@unknown.nowhere>
# Maintainer: Andreas Schaarschmidt <andreas.schaarschmidt@unknown.nowhere>
pkgname=kobo-qt5-platform
pkgver=1.25.528
pkgrel=1
pkgdesc="A Qt5 platform backend plugin for Kobo E-Ink devices"
url="https://github.com/Rain92/qt5-kobo-platform-plugin.git"
arch="armhf"
license="GPL3+"
depends="qt5-qtbase libevdev i2c-tools"
makedepends="
	libevdev-dev
	i2c-tools-dev
	libudev-zero-dev
	libxkbcommon-dev
        qt5-qtbase-dev
        qt5-qtdeclarative-dev
        qt5-qtwebsockets-dev
        qt5-qtwebchannel-dev
        qt5-qtwebengine-dev
        qt5-qtsvg-dev
        qt5-qtconnectivity-dev
        qt5-qtcharts-dev
        qt5-qtvirtualkeyboard-dev
        qt5-qtlocation-dev
        qt5-qttools-dev
        qt5-qtquickcontrols2-dev
        qt5-qtwayland-dev
        qt5-qtxmlpatterns-dev
        qt5-qtx11extras-dev
        qt5-qtserialport-dev
        qt5-qtsensors-dev
        qt5-qtmultimedia-dev
        qt5-qtspeech-dev
        qt5-qtremoteobjects-dev
        qt5-qtscript-dev
        qt5-qtimageformats
        qt5-qttranslations
        qt5-qtgraphicaleffects
"

provides="$pkgname-dev=$pkgver"
source="
"
options="!check"

prepare () {
	# doas ln -s libmtdev.so.1 /usr/lib/libmtdev.so
	# doas ln -s libinput.so.10 /usr/lib/libinput.so
	# patch the source directory, including the qrc_Resources.cpp file
	cd "$startdir/qt5-kobo-platform-plugin"
	qmake
	make
}

package () {
	mkdir -p "$pkgdir/usr/bin"
	mkdir -p "$pkgdir/usr/lib"
	mkdir -p "$pkgdir/usr/include"

	cp "$startdir/FBInk/Release/fbink" "$pkgdir/usr/bin/fbink"
	cp "$startdir/FBInk/Release/libfbink.so.1.0.0" "$pkgdir/usr/lib/libfbink.so.1.0.0"
	cp -P "$startdir/FBInk/Release/libfbink.so.1" "$pkgdir/usr/lib/libfbink.so.1"
	cp -P "$startdir/FBInk/Release/libfbink.so" "$pkgdir/usr/lib/libfbink.so"
	cp "$startdir/FBInk/fbink.h" "$pkgdir/usr/include/fbink.h"
}

cleanup () {
	cd $startdir
	if [ -e "/home/${USER}/packages/${USER}/armhf/$pkgname-$pkgver-r$pkgrel.apk" ]; then
		cp "/home/${USER}/packages/${USER}/armhf/$pkgname-$pkgver-r$pkgrel.apk" .
	fi
}

sha512sums="
02ac41a111048f1d0aac3612c1e15b35858c0c46044efa617b31743ffec227880a5724902b415c2aeaf31548f37869dba18cdb92b638c229ee110469f8c41f88  fbink
5b13badb89a590febfe096c5eeace9650d9e5904423311150215ac79f02b0981f6867aff25fd4d9796565b3a825b0230395b6cf535fad67ae474c698cf489db5  libfbink.so.1.0.0
5b13badb89a590febfe096c5eeace9650d9e5904423311150215ac79f02b0981f6867aff25fd4d9796565b3a825b0230395b6cf535fad67ae474c698cf489db5  libfbink.so.1
5b13badb89a590febfe096c5eeace9650d9e5904423311150215ac79f02b0981f6867aff25fd4d9796565b3a825b0230395b6cf535fad67ae474c698cf489db5  libfbink.so
0dce6a74b7cf9a0365e1f5b5d7297163c88ef7e498c5fbed0ef19b14ff4a5f3b6e35accf2b89d6f68501ca5ee3d810350f7a643045b4962261e39461a6187f4b  fbink.h
"
