# 深度启动器安装    

- 作为编译其他debian应用的蓝本    
- dtk也是这样编译的  

```shell
# 进行相应目录  
cd Downloads/
# 用命令下载 deepin-boot-maker
apt source deepin-boot-maker
ls
# 进入项目目录
cd deepin-boot-maker-5.6.17/
ls
# 对于有debian目录的，可以直接使用build-dep，来安装相应的环境所需依赖 
sudo apt-get build-dep .
# 创建build目录 
mkdir build
cd build/
# 生成编译文件
qmake ../deepin-boot-maker.pro
make -j8
ls
# 再次编译
make
# 返回项目目录，打开*.pro
cd ..
qtcreator deepin-boot-maker.pro   # qt版本切换到5.11 ，但是在KLU上5.15也没有问题
# 编译是不是有问题，有问题的话看看是不是qt版本问题
qmake -v  
which qmake
# 切换qt版本试试    
```

- 探索过程：

```shell
sudo apt-get build-dep deepin-boot-maker
sudo apt install libdtkwidget-dev
# 查看软件的安装
dpkg -L libdtkcore-dev
# 查看qt版本 
cat /usr/lib/x86_64-linux-gnu/qt5/mkspecs/modules/qt_lib_dtkcore.pri
# 进行相应目录  
cd Downloads/
# 用命令下载 deepin-boot-maker
apt source deepin-boot-maker
ls
cd deepin-boot-maker-5.6.17/
ls
mkdir build
cd build/
# 编译 deepin-boot-maker
qmake ../deepin-boot-maker.pro
make -j16
cd ..
# 对于有debian目录的，可以直接使用build-dep，来安装相应的环境所需依赖 
sudo apt-get build-dep .
sudo apt-get build-dep deepin-boot-maker
cd build/
make -j8
ls
make
cd ..
qtcreator deepin-boot-maker.pro   # qt版本切换到5.11 ，但是在KLU上5.15也没有问题
qmake -v  # 切换qt版本  
which qmake
```

