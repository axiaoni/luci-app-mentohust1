include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-mentohust1
PKG_VERSION=1.1.1
PKG_RELEASE:=0

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-mentohust1
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=MentoHUST 802.1X Client for LuCI
	PKGARCH:=all
endef

define Package/luci-app-mentohust1/description
	This package contains LuCI configuration pages for 8021xclient.
endef

define Package/luci-app-mentohust1/conffiles
/etc/config/mentohust1
endef

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/files/luci/i18n/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-mentohust1/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/mentohust1
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/mentohust1.*.lmo $(1)/usr/lib/lua/luci/i18n/
	$(INSTALL_CONF) ./files/root/etc/config/mentohust1 $(1)/etc/config/mentohust1
	$(INSTALL_BIN) ./files/root/etc/init.d/mentohust1 $(1)/etc/init.d/mentohust1
	$(INSTALL_DATA) ./files/luci/model/cbi/mentohust1/general.lua $(1)/usr/lib/lua/luci/model/cbi/mentohust1/general.lua
	$(INSTALL_DATA) ./files/luci/model/cbi/mentohust1/log.lua $(1)/usr/lib/lua/luci/model/cbi/mentohust1/log.lua
	$(INSTALL_DATA) ./files/luci/controller/mentohust1.lua $(1)/usr/lib/lua/luci/controller/mentohust1.lua
endef

$(eval $(call BuildPackage,luci-app-mentohust1))
