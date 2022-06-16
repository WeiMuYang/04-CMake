#!/bin/bash 

# 1 获取当前的绝对路径
echo $(cd "$(dirname "$0")";pwd) 
cd sailfishos
# 2 获取当前目录下所有的文件夹 
for file in `ls -l |grep "^d" |awk '{print $9}'` 
do
  FOLDER[$c]="$file"  #（为了准确起见，此处要加上双引号“”）
  ((c++))
done;

# 2 对所有的包文件夹进行循环
for((i=0;i<${#FOLDER[@]};i++)) 
do
    echo "[================ start ""${FOLDER[i]}""==================]"
    
    # 3 进入包目录
    cd ${FOLDER[i]} 
    c=0
    for fileM in `ls -a` 
    do
        MODU[$c]="$fileM"  #（为了准确起见，此处要加上双引号“”）
        ((c++))
    done;
    # 如果目录里面有gitmodules, 获取最新代码
    for((j=0;j<${#MODU[@]};j++)) 
    do
        echo "${MODU[j]}" 
        if [ "${MODU[j]}" == ".gitmodules" ];then 
            git submodule update --init --recursive
            break
        fi
    done;
    cd ..
done
