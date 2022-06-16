#!/bin/bash

check_root_user()
{
	if [ $USER != root ];then
		echo "请切换root环境运行!!"
		exit -1
	fi
}

main_repo()
{
    echo "deb http://pools.uniontech.com/desktop-professional/ eagle/sp2 main contrib non-free" > /etc/apt/sources.list
    if [ $? -eq 0 ];then
        echo "主仓库配置成功!"
    else 
        echo "主仓库配置失败!!"
        return -1
    fi
}

ppa_repo()
{
    [ -f /etc/apt/sources.list.d/*-ppa.list ] && rm -f /etc/apt/sources.list.d/*-ppa.list #删除旧的ppa配置文件

    cat > /etc/apt/sources.list.d/master-ppa.list << EOF
deb [trusted=yes] http://zl.uniontech.com/aptly/wayland-master unstable main non-free
deb-src [trusted=yes] http://zl.uniontech.com/aptly/wayland-master unstable main non-free
deb [trusted=yes] http://zl.uniontech.com/klu/klu-crp eagle main non-free
EOF

    if [ $? -eq 0 ];then
        echo "PPA仓库配置成功!"
    else 
        echo "PPA仓库配置失败!!"
        return -1
    fi
}

ppa_priority()
{
	[ `ls /etc/apt/preferences.d/*.pref | wc -l` -ne 0 ] && rm -f /etc/apt/preferences.d/*.pref #删除旧的ppa优先级配置文件

    cat > /etc/apt/preferences.d/master-ppa.pref << EOF
Package: *
Pin: release o=wayland-master unstable,a=unstable,n=unstable,l=wayland-master unstable,c=non-free,b=arm64
Pin-Priority: 1001

Package: *
Pin: release o=wayland-master unstable,a=unstable,n=unstable,l=wayland-master unstable,c=main,b=arm64
Pin-Priority: 1001
EOF

     if [ $? -eq 0 ];then
        echo "PPA仓库优先级配置成功!"
    else 
        echo "PPA仓库优先级配置失败!!"
        return -1
    fi
}

check_root_user
main_repo
ppa_repo
ppa_priority

apt update
