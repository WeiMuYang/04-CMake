# 配置DDE过程    

[参考资料](https://gitlabbj.uniontech.com/beijing/uwm-group/uwm/-/blob/master/documents/06-%E4%BE%9D%E8%B5%96%E7%8E%AF%E5%A2%83%E7%9A%84%E6%90%AD%E5%BB%BA/03-Wayfire%E8%BF%90%E8%A1%8CUOS%20dde.md)  

```shell
# 1 修改默认启动应用wf-panel
sudo cp /usr/bin/wf-panel /usr/bin/wf-panel.org
# 2 切换kwin，并执行如下命令
sudo cp /etc/deepin/greeters.d/lightdm-deepin-greeter /usr/bin/wf-panel
# 3 修改deepin-greeter
sudo vim  /usr/bin/deepin-greeter
	-/usr/bin/kwin_wayland --drm --no-lockscreen /etc/deepin/greeters.d/lightdm-deepin-greeter
	+/usr/bin/run_wayfire -d

```

## 2 安装kwayland   

[kwayland分支](https://gerrit.uniontech.com/c/kwayland/+/65469)    

```shell
# 1 克隆仓库
git clone "http://gerrit.uniontech.com/kwayland"
# 2 切换分支
cd kwayland
sudo apt-get build-dep .
git fetch "http://gerrit.uniontech.com/kwayland" refs/changes/69/65469/1 && git checkout -b change-65469-1 FETCH_HEAD
# 3 编译安装 
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=on -DCMAKE_PREFIX_PATH=/usr ..
make
# 不能忘了安装  
sudo make install -j8
```

## 3 安装qtwayland    

[qtwayland规避](https://gerrit.uniontech.com/c/qt5.15/qtwayland-opensource-src/+/65574)  

```shell	
# 1 克隆仓库
git clone "http://gerrit.uniontech.com/qt5.15/qtwayland-opensource-src" 
# 2 切换分支 
cd qtwayland-opensource-src
git fetch "http://gerrit.uniontech.com/qt5.15/qtwayland-opensource-src" refs/changes/74/65574/2 && git checkout -b change-65574-2 FETCH_HEAD
# 3 安装依赖
sudo apt-get build-dep .
# 4 编译安装 
mkdir build && cd build 
# qmake ../qtwayland.pro
qmake PREFIX=/usr ..
make -j8
# 不能忘了安装  
# sudo make install -j8 
```

## 4 替换库  

```shell
# 在build目录下执行，替换对应库相当于安装   
sudo cp ./lib/libQt5WaylandClient.so.5.15.1 /usr/lib/x86_64-linux-gnu/libQt5WaylandClient.so.5.15.1
sudo cp ./plugins/wayland-decoration-client/libbradient.so /usr/lib/x86_64-linux-gnu/qt5/plugins/wayland-decoration-client/libbradient.so
```

## 5 修改配置文件  

- 修改启动脚本： /usr/bin/kwin_wayland_helper

```
-exec /usr/bin/kwin_wayland -platform dde-kwin-wayland --xwayland --drm --no-lockscreen  startdde-wayland 1> $HOME/.kwin.log 2>&1
+/usr/bin/run_wayfire
```

- 修改配置文件 ~/.config/wayfire.ini

```
-autostart_wf_shell = true
+autostart_wf_shell = false

+panel = startdde-wayland
```

