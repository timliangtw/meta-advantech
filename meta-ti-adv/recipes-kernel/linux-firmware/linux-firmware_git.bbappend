# Copyright (C) 2017 Advantech
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://EWM-W170H01E.tgz"
SRC_URI[md5sum] = "f72305e1634a2412747af82300eae3ad"

# Overwrite WiFi calibration file
do_install_append() {
    install -d ${D}/lib/firmware/
    install -d ${D}/lib/firmware/wlan
    cp -r ${WORKDIR}/firmware_bin/* ${D}/lib/firmware/
}
FILES_${PN} += "/lib/firmware/*"

do_install() {
        install -d  ${D}/lib/firmware/
        cp -r * ${D}/lib/firmware/

        # Avoid Makefile to be deployed
        rm ${D}/lib/firmware/Makefile

        # Remove unbuild firmware which needs cmake and bash
        rm ${D}/lib/firmware/carl9170fw -rf

        # Remove pointless bash script
        rm ${D}/lib/firmware/configure

        # Libertas sd8686
        ln -sf libertas/sd8686_v9.bin ${D}/lib/firmware/sd8686.bin
        ln -sf libertas/sd8686_v9_helper.bin ${D}/lib/firmware/sd8686_helper.bin

        # fixup wl12xx location, after 2.6.37 the kernel searches a different location for it
        ( cd ${D}/lib/firmware ; ln -sf ti-connectivity/* . )
	rm ${D}/lib/firmware/ti-connectivity/ -rf
}

PACKAGES =+ "${PN}-bcm43241b4 \
            "

LICENSE_${PN}-bcm43241b4 = "Firmware-broadcom_bcm43xx"
FILES_${PN}-bcm43241b4 = " \
  /lib/firmware/brcm/brcmfmac43241b4-sdio.bin \
"
RDEPENDS_${PN}-bcm43241b4 += "${PN}-broadcom-license"

PACKAGES =+ "${PN}-sd8897 \
            "

LICENSE_${PN}-sd8897 = "Firmware-Marvell"
FILES_${PN}-sd8897 = " \
  /lib/firmware/mrvl/sd8897_uapsta.bin \
"
RDEPENDS_${PN}-sd8897 += "${PN}-marvell-license"

