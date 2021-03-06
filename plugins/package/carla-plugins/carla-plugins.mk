######################################
#
# carla-plugins
#
######################################

CARLA_PLUGINS_VERSION = 08e416113bcb0facaac952370fdee19937907384
CARLA_PLUGINS_SITE = $(call github,falkTX,Carla,$(CARLA_PLUGINS_VERSION))
CARLA_PLUGINS_DEPENDENCIES = libsndfile ffmpeg
# for later: fluidsynth liblo (unused at the moment)
CARLA_PLUGINS_BUNDLES = carla-audiogain.lv2 carla-files.lv2 carla-miditools.lv2

CARLA_PLUGINS_NO_GUI = HAVE_HYLIA=false HAVE_PYQT=false

CARLA_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) $(CARLA_PLUGINS_NO_GUI) NOOPT=true -C $(@D) lv2-bundles

define CARLA_PLUGINS_BUILD_CMDS
	$(CARLA_PLUGINS_TARGET_MAKE)
endef

define CARLA_PLUGINS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $(@D)/bin/carla-*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/carla-audiogain.lv2/* $(TARGET_DIR)/usr/lib/lv2/carla-audiogain.lv2/
endef

$(eval $(generic-package))
