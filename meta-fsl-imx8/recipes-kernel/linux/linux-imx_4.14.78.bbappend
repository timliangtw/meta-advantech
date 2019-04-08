FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRCBRANCH = "imx_4.14.78_1.0.0_ga"
LOCALVERSION = "-${SRCBRANCH}"
KERNEL_SRC = "git://github.com/ADVANTECH-Corp/linux-imx6.git;protocol=https;branch=${SRCBRANCH}"
SRC_URI = "${KERNEL_SRC};branch=${SRCBRANCH}"
SRCREV = "${AUTOREV}"
DEFCONFIG ?= ""
DEFCONFIG_mx8qm = "imx8qm_adv_defconfig"
DEFCONFIG_mx8mq = "imx8mq_adv_defconfig"

do_copy_defconfig_mx8 () {
    if [ "${DEFCONFIG}" == "" ]; then
        echo "no defconfig defined"
        return 1
    fi
    cp ${S}/arch/arm64/configs/${DEFCONFIG} ${B}/.config
    cp ${S}/arch/arm64/configs/${DEFCONFIG} ${B}/../defconfig
}

