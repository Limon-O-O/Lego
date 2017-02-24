#!/bin/bash

BGreen='\033[1;32m'
Default='\033[0;m'

podName="Tower"
homepage="https://github.com/Limon-O-O/Lego"
httpsRepo="https://github.com/Limon-O-O/Lego.git"
podspecFilePath="./Tower.podspec"

version=""
oldVersion=""
confirmed="n"

getPodInfo() {

    invalid=true

    for file in ./*
    do
        if test -f $file
        then
            if [[ $file == *"${podName}.podspec"* ]]; then
                invalid=false
            fi
        fi
    done

    if $invalid; then
        echo "${podName}.podspec not exited." && exit 1
    fi

    while read line; do
        # 截取旧版本号
        if [[ $line == *"s.version"*"="* ]]; then
            oldVersion=${line##*=}
            oldVersion=${oldVersion#*\"}
            oldVersion=${oldVersion%\"}
            oldVersion=${oldVersion#*\'}
            oldVersion=${oldVersion%\'}
        fi
    done < $podspecFilePath
}

getVersion() {
    read -p "Enter Version: " version

    if test -z "$version"; then
        getVersion
    fi
}

updateVersion() {
    while read line; do
        if [[ $line == *"s.version"*"="* ]]; then
            newLine=${line/$oldVersion/$version}
            sed -i '' "s#$line#$newLine#" "$podspecFilePath"
        fi
    done < $podspecFilePath

    # update README.md file
    while read line; do
        if [[ $line == *"pod"*"${oldVersion}"* ]]; then
            newLine=${line/$oldVersion/$version}
            sed -i '' "s#$line#$newLine#" "./README.md"
        fi
        if [[ $line == *"github"*"${podName}"*"${oldVersion}"* ]]; then
            newLine=${line/$oldVersion/$version}
            sed -i '' "s#${line}#${newLine}#" "./README.md"
        fi
    done < "./README.md"

    # update Xcode project
    ./update_version.sh --version=$version --target=$podName
}

getInfomation() {
    getVersion

    ! ./version_compare.sh $version $oldVersion ">" && echo "Invalid version. $version <= $oldVersion" && exit 1

    echo -e "\n${Default}================================================"
    echo -e "  Pod Name      :  ${BGreen}${podName}${Default}"
    echo -e "  Version       :  ${BGreen}${version}${Default}"
    echo -e "  HTTPS Repo    :  ${BGreen}${httpsRepo}${Default}"
    echo -e "  Home Page URL :  ${BGreen}${homepage}${Default}"
    echo -e "================================================\n"
}

########### 开始 ###############

getPodInfo

echo -e "\n"
while [ "$confirmed" != "y" -a "$confirmed" != "Y" ]
do
    if [ "$confirmed" == "n" -o "$confirmed" == "N" ]; then
        getInfomation
    fi
    read -p "confirm? (y/n):" confirmed
done

updateVersion

# Specs 目录相当于 CocoaPods 的 source，详见：https://github.com/CocoaPods/Specs
specsPath="../../Specs/${podName}/${version}"

mkdir -p $specsPath

# 增加新的版本到 Specs，不需要 pod repo lint 
echo "copy $podspecFilePath to $specsPath"
cp -f "$podspecFilePath" "$specsPath"

git pull
git add "${specsPath}"
git add "${podspecFilePath}"
git add "./README.md"
git commit -m "[$podName] Update version $version"
git push

say "finished"
echo "finished"

