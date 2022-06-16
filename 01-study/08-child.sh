#!/bin/bash

version="v"
name="n"
source="s"
specFile="s"

# return 0:*.spec文件名有误  1:Source中包含多个/格式不对  2: version/name 中有变量  3: setup error  4:正常退出
function GetVerNameSrc {
    version=$1
    name=$2
    source=$3
    file=$4

    count=0
    numSource=0
    while read line   #使用read命令循环读取文件内容，并将读取的文件内容赋值给变量line
    do
        let count++
        arr=($line)
        # echo "$count $line"
        if [ "${arr[0]}" = "%setup" ];then
            echo "$line"
        fi
        if [ "${arr[0]}" = "%autosetup" ];then
            echo "$line"
        fi
        # 判断字符串是否相等
        if [ "${arr[0]}" = "Version:" ];then
                version="${arr[1]}"
              echo "$line"
        fi
        if [ "${arr[0]}" = "Name:" ];then
                name="${arr[1]}" 
              echo "$line"     
        fi
        # 从第0个开始,往后数6个   ${var:0:5}
        var=${arr[0]}
        len=${#var}
        if [ $len -ge 6 ];then  
            var=${var:0:6}
            if [ "$var" = "Source" ];then  
                echo "$line"
            fi
        fi
    done <$file      #“done <$file”将整个while循环的标准输入指向文件$file
    cd ..
    return 4
}


  #          git submodule update --init --recursive


cp ./rpm/* ./
cd rpm
specFile=`ls | grep *.spec` 
GetVerNameSrc $version $name $source $specFile 

tarName1=$name"-"$version".tar.gz"
tarName2=$name"-"$version".tar.bz2"
tarName3=$name"-"$version".tar"
 
echo "tar zcf ""$tarName1"" ""$name"  
echo "tar jcf ""$tarName2"" ""$name"  
echo "tar cf ""$tarName3"" ""$name""&&"" xz -zk ""$tarName3"

rm -r rpm  


