#!/bin/bash
#=================================================== ====================================================== === =====================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# 描述：自动为 Amlogic s9xxx 电视盒构建 OpenWrt
# 功能：DIY脚本（更新feeds后，修改默认IP、主机名、主题、添加/删除软件包等）
# 源代码仓库：https://github.com/coolsnowwolf/lede / 分支：master
#=================================================== ====================================================== ===== === =====================

# ------------------------------ 主源已启动 --------------- ----------------
#
# 修改默认主题（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
# sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# 添加对armvirt的自动核心支持
#sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g'寰/lean/autocore/Makefile 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g'寰/lean/autocore/Makefile-i  

#etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R  $(date +%Y.%m.%d)'|g"  package/lean/default-settings/files/zzz-default-settings"s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R $(date +%Y.%m.%d) '|g"包/精益/默认设置/文件/zzz-默认设置
echo "DISTRIB_SOURCECODE='lede'" >>package/base-files/files/etc/openwrt_release"DISTRIB_SOURCECODE='lede'" >>package/base-files/files/etc/openwrt_release

# 修改默认IP（从192.168.1.1更改为192.168.31.4）
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate

#替换默认软件源
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings
#
# ------------------------------ 主要源码结束 --------------- ----------------

#----------------------------------------其他开始了---------------- -- --------------
#
# 添加 luci-app-amlogic
# svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
# svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic xiaorouji/openwrt-passwall
# svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic xiaorouji/openwrt-passwall2

# 修复runc版本错误
# rm -rf ./feeds/packages/utils/runc/Makefile
# svn 导出 https://github.com/openwrt/packages/trunk/utils/runc/Makefile ./feeds/packages/utils/runc/Makefile

#将coolsnowwolf默认替换为Lienol相关真菌
# rm -rf feeds/packages/utils/{containerd,libnetwork,runc,tini}
# svn co https://github.com/Lienol/openwrt-packages/trunk/utils/{containerd,libnetwork,runc,tini} feeds/packages/utils

# 添加第三方软件包（整个存储库）
# git 克隆 https://github.com/libremesh/lime-packages.git package/lime-packages
#添加第三方第三方（指定包）
# svn co https://github.com/libremesh/lime-packages/trunk/packages/{shared-state-pirania,pirania-app,pirania} package/lime-packages/packages
#添加编译选项（根据第三方Makefile的要求添加相关依赖）
# sed -i "/DEFAULT_PACKAGES/ s/$/ pirania-app pirania ip6tables-mod-nat ipset 共享状态-pirania uhttpd-mod-lua/" target/linux/armvirt/Makefile

#应用主题
# git apply ../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------------------ 其他端 ---------------- ----------------

