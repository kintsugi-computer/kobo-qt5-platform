PKGNAME := $(shell sed -n 's/pkgname=//p' APKBUILD)
PKGVER := $(shell sed -n 's/pkgver=//p' APKBUILD)
PKGREL := $(shell sed -n 's/pkgrel=//p' APKBUILD)

$(PKGNAME)-$(PKGVER)-r$(PKGREL).apk: APKBUILD
	abuild prepare
	abuild checksum
	abuild -r
	cp /home/$(USER)/packages/$(USER)/armhf/$(PKGNAME)-$(PKGVER)-r$(PKGREL).apk .
