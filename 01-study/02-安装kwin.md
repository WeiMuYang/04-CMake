# kwin的安装   
[toc]   

## 1 编译kwin的源码    
### 1.1 获取kwin源码   
从公司的内网获取kwin的源码`deepin-kwin`    

### 1.2 编译源码   
```shell
cd /home/huawei/Documents/Yang/deepin-kwin
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=on -DCMAKE_PREFIX_PATH=/usr    ..  
make -j16 && sudo make install 
```
