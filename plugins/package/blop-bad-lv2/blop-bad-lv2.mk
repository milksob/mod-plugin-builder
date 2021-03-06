######################################
#
# blop-bad-lv2
#
######################################

BLOP_BAD_LV2_VERSION = 44ff27dd355e850b9865fa50e3f32d8e24619006
BLOP_BAD_LV2_SITE = http://git.drobilla.net/blop.lv2.git
BLOP_BAD_LV2_SITE_METHOD = git
BLOP_BAD_LV2_BUNDLES = blop-bad.lv2

BLOP_BAD_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define BLOP_BAD_LV2_CONFIGURE_CMDS
	(cd $(@D); $(BLOP_BAD_TARGET_WAF) configure --prefix=/usr)
endef

define BLOP_BAD_LV2_BUILD_CMDS
	(cd $(@D); $(BLOP_BAD_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define BLOP_BAD_LV2_INSTALL_TARGET_CMDS
	(cd $(@D); $(BLOP_BAD_TARGET_WAF) install --destdir=$(TARGET_DIR))
	mv $(TARGET_DIR)/usr/lib/lv2/blop.lv2 $(TARGET_DIR)/usr/lib/lv2/blop-bad.lv2
	cp -rL $($(PKG)_PKGDIR)/blop-bad.lv2/* $(TARGET_DIR)/usr/lib/lv2/blop-bad.lv2/
endef

$(eval $(generic-package))
