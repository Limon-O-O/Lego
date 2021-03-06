#!/bin/bash

httpsRepo="https://github.com/Limon-O-O/Lego.git"
sshRepo="git@github.com:Limon-O-O/Lego.git"
specsRepo="git@github.com:Limon-O-O/Lego.git"
homePage="https://github.com/Limon-O-O/Lego"
author="Limon"

BGreen='\033[1;32m'
Default='\033[0;m'

projectName=""
projectType=""
frameworkName=""
confirmed="n"
profilePath="./templates/Podfile"
currentDate=`date +%Y-%m-%d`
extensionPrefix="Mediator_"

getProjectName() {
    read -p "Enter Project Name: " projectName

    if [[ -z ${projectName} ]]; then
        echo "Invalid project name." && exit 1
    fi

    if test -z "$projectName"; then
        getProjectName
    fi
}

getProjectType() {

    echo -e "\n${Default}================================================"
    echo -e " 1 :  ${BGreen}Module${Default}"
    echo -e " 2 :  ${BGreen}Extension${Default}"
    echo -e " 3 :  ${BGreen}Framework${Default}"
    echo -e "================================================\n"

    read -p "Enter Project Type Number: " projectTypeNumber

    case $projectTypeNumber in  
        "1"|"Module")  
            projectType="Module"
            projectDirectoryPath="../Modules/${projectName}"
            ;;
        "2"|"Extension")  
            projectType="Extension"
            projectName="${extensionPrefix}${projectName}"
            projectDirectoryPath="../Modules/${projectName}"
            ;;
        "3"|"Framework") 
            projectType="Framework"
            projectDirectoryPath="../Frameworks/${projectName}"
            ;;
    esac

    if [[ -z ${projectType} ]]; then
        echo "Invalid type number." && exit 1
    fi

    if test -z "$projectType"; then
        getProjectType
    fi
}

getInfomation() {

    getProjectName
    getProjectType

    echo -e "\n${Default}================================================"
    echo -e "  Project Name  :  ${BGreen}${projectName}${Default}"
    echo -e "  Project Type  :  ${BGreen}${projectType}${Default}"
    echo -e "  HTTPS Repo    :  ${BGreen}${httpsRepo}${Default}"
    echo -e "  SSH Repo      :  ${BGreen}${sshRepo}${Default}"
    echo -e "  Specs Repo    :  ${BGreen}${specsRepo}${Default}"
    echo -e "  Home Page     :  ${BGreen}${homePage}${Default}"
    echo -e "================================================\n"
}

copyFiles() {
    echo "Copy to $uploadFilePath"
    cp -f ./templates/upload.sh               "$uploadFilePath"
    echo "Copy to $releaseFilePath"
    cp -f ./templates/release.sh              "$releaseFilePath"
    echo "Copy to $compareFilePath"
    cp -f ./templates/version_compare.sh      "$compareFilePath"
    echo "Copy to $updateVersionPath"
    cp -f ./templates/update_version.sh       "$updateVersionPath"
}

copyModuleFiles() {

    mkdir -p "${projectDirectoryPath}/Pod/Targets"

    targetFilePath="${projectDirectoryPath}/Pod/Targets/Target_${projectName}.swift"

    echo "Copy to $targetFilePath"
    cp -f ./templates/module/target/Target_Project.swift       "$targetFilePath"

    sed -i "" "s%__ProjectName__%${projectName}%g" "$targetFilePath"
    sed -i "" "s%__Author__%${author}%g" "$targetFilePath"
    sed -i "" "s%__Time__%${currentDate}%g" "$targetFilePath"
}

copyExtensionFiles() {

    shortProjectName=${projectName##*$extensionPrefix}

    extensionFilePath="${projectDirectoryPath}/Pod/${projectName}.swift"
    projectProtocolFilePath="${projectDirectoryPath}/Pod/${shortProjectName}.swift"

    echo "Copy to $extensionFilePath"
    cp -f ./templates/module/extension/Mediator_Project.swift                 "$extensionFilePath"
    echo "Copy to $projectProtocolFilePath"
    cp -f ./templates/module/extension/ProjectProtocol.swift       "$projectProtocolFilePath"

    sed -i "" "s%__ProjectName__%${shortProjectName}%g" "$extensionFilePath"
    sed -i "" "s%__Author__%${author}%g" "$extensionFilePath"
    sed -i "" "s%__Time__%${currentDate}%g" "$extensionFilePath"

    sed -i "" "s%__ProjectName__%${shortProjectName}%g" "$projectProtocolFilePath"
    sed -i "" "s%__Author__%${author}%g" "$projectProtocolFilePath"
    sed -i "" "s%__projectName__%$(tr '[:upper:]' '[:lower:]' <<< ${shortProjectName:0:1})${shortProjectName:1}%g" "$projectProtocolFilePath"
    sed -i "" "s%__Time__%${currentDate}%g" "$projectProtocolFilePath"
}

editFiles() {
    echo "Editing..."
    sed -i "" "s%__ProjectName__%${projectName}%g" "$gitignoreFilePath"
    sed -i "" "s%__ProjectName__%${projectName}%g" "$uploadFilePath"

    sed -i "" "s%__SpecsRepo__%${specsRepo}%g" "$readmeFilePath"

    sed -i "" "s%__ProjectName__%${projectName}%g" "$releaseFilePath"
    sed -i "" "s%__HomePage__%${homePage}%g" "$releaseFilePath"
    sed -i "" "s%__HTTPSRepo__%${httpsRepo}%g" "$releaseFilePath"

    sed -i "" "s%__ProjectName__%${projectName}%g" "$specFilePath"
    sed -i "" "s%__HomePage__%${homePage}%g"      "$specFilePath"
    sed -i "" "s%__HTTPSRepo__%${httpsRepo}%g"    "$specFilePath"
    sed -i "" "s%__Author__%${author}%g"    "$specFilePath"
    sed -i "" "s%__ProjectName__%${projectName}%g" "$specFilePath"

    # 修改 pod-template
    sed -i "" "s%__SpecsRepo__%${specsRepo}%g" $podfilePath    

    directory="Modules"
    case $projectType in  
    "Module")  
        directory="Modules"
        sed -i '' "s#\# pod \'Mediator\'##" "$podfilePath"
        ;;
    "Extension")
        directory="Modules"
        sed -i '' "s#\# s.dependency \"Mediator\"#s.dependency \"Mediator\"#" "$specFilePath"
        # pod 'Mediator'
        sed -i '' "s#\# pod \'Mediator\'#pod \'Mediator\'#" "$podfilePath"
        ;;
    "Framework")
        directory="Frameworks"
        sed -i '' "s#\# pod \'Mediator\'##" "$podfilePath"
        ;;
    esac

    sed -i "" "s%__ProjectRootDirectory__%${directory}%g" "$releaseFilePath"

    echo "Edit finished"
}

echo -e "\n"
while [ "$confirmed" != "y" -a "$confirmed" != "Y" ]
do
    if [ "$confirmed" == "n" -o "$confirmed" == "N" ]; then
        getInfomation
    fi
    read -p "Confirm? (y/n):" confirmed
done

licenseFilePath="${projectDirectoryPath}/LICENSE"
gitignoreFilePath="${projectDirectoryPath}/.gitignore"
specFilePath="${projectDirectoryPath}/NAME.podspec"
readmeFilePath="${projectDirectoryPath}/POD_README.md"
uploadFilePath="${projectDirectoryPath}/upload.sh"
releaseFilePath="${projectDirectoryPath}/release.sh"
compareFilePath="${projectDirectoryPath}/version_compare.sh"
podfilePath="${projectDirectoryPath}/templates/swift/Example/Podfile"
updateVersionPath="${projectDirectoryPath}/update_version.sh"

mkdir -p "${projectDirectoryPath}/Pod"

echo "Copy pod-template to $projectDirectoryPath"
cp -rf ./pod-template/.      "$projectDirectoryPath"

case $projectType in  
"Module")  
    copyFiles
    copyModuleFiles
    ;;
"Extension")
    copyFiles
    copyExtensionFiles
    ;;
"Framework")
    copyFiles
    ;;
esac

editFiles

cd "${projectDirectoryPath}" && ./configure $projectName

# 删除 CocoaPods 自动生成的 git
rm -rf .git

cd "./Example"

# 使用 Xcodeproj 向新工程添加相关文件夹及文件
./xcodeproj $projectName $projectType $shortProjectName

rm -f ./xcodeproj

say "Finished"
echo "Finished"
