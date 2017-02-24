#!/bin/bash

httpsRepo="https://github.com/Limon-O-O/Lego.git"
sshRepo="git@github.com:Limon-O-O/Lego.git"
specsRepo="https://github.com/Limon-O-O/Lego.git"
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
extensionPrefix="CTMediator+"

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

updatePodfile() {

    oldSpecsRepoLine=""

    while read line; do
        if [[ $line == *"source"*".git"* ]] && ! [[ $line == *"github.com/CocoaPods/Specs.git"* ]]; then
            oldSpecsRepoLine=$line
            break
        fi
    done < $profilePath

    newLine="source '$specsRepo'"

    if test -z "$oldSpecsRepoLine"; then
        echo -e "${newLine}\n$(cat $profilePath)" > "$profilePath"
    else
        sed -i '' "s#${oldSpecsRepoLine}#${newLine}#" "$profilePath" # replace old specs repo with new one
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

echo -e "\n"
while [ "$confirmed" != "y" -a "$confirmed" != "Y" ]
do
    if [ "$confirmed" == "n" -o "$confirmed" == "N" ]; then
        getInfomation
    fi
    read -p "Confirm? (y/n):" confirmed
done

updatePodfile

licenseFilePath="${projectDirectoryPath}/FILE_LICENSE"
gitignoreFilePath="${projectDirectoryPath}/.gitignore"
specFilePath="${projectDirectoryPath}/${projectName}.podspec"
readmeFilePath="${projectDirectoryPath}/README.md"
uploadFilePath="${projectDirectoryPath}/upload.sh"
releaseFilePath="${projectDirectoryPath}/release.sh"
compareFilePath="${projectDirectoryPath}/version_compare.sh"
podfilePath="${projectDirectoryPath}/Podfile"
updateVersionPath="${projectDirectoryPath}/update_version.sh"

copyFiles() {
    echo "Copy to $licenseFilePath"
    cp -f ./templates/FILE_LICENSE            "$licenseFilePath"
    echo "Copy to $gitignoreFilePath"
    cp -f ./templates/gitignore               "$gitignoreFilePath"
    echo "Copy to $specFilePath"
    cp -f ./templates/pod.podspec             "$specFilePath"
    echo "Copy to $readmeFilePath"
    cp -f ./templates/README.md               "$readmeFilePath"
    echo "Copy to $uploadFilePath"
    cp -f ./templates/upload.sh               "$uploadFilePath"
    echo "Copy to $releaseFilePath"
    cp -f ./templates/release.sh              "$releaseFilePath"
    echo "Copy to $compareFilePath"
    cp -f ./templates/version_compare.sh      "$compareFilePath"
    echo "Copy to $podfilePath"
    cp -f ./templates/Podfile                 "$podfilePath"
    echo "Copy to $updateVersionPath"
    cp -f ./templates/update_version.sh       "$updateVersionPath"
}

copyModuleFiles() {

    mkdir -p "${projectDirectoryPath}/${projectName}/${projectName}/Targets"

    targetFilePath="${projectDirectoryPath}/${projectName}/${projectName}/Targets/Target_${projectName}.swift"

    echo "Copy to $targetFilePath"
    cp -f ./templates/module/target/Target_Project.swift       "$targetFilePath"

    sed -i "" "s%__ProjectName__%${projectName}%g" "$targetFilePath"
    sed -i "" "s%__Author__%${author}%g" "$targetFilePath"
    sed -i "" "s%__Time__%${currentDate}%g" "$targetFilePath"
}

copyExtensionFiles() {

    shortProjectName=${projectName##*$extensionPrefix}

    extensionFilePath="${projectDirectoryPath}/${projectName}/${projectName}/${projectName}.swift"
    projectProtocolFilePath="${projectDirectoryPath}/${projectName}/${projectName}/${shortProjectName}.swift"

    echo "Copy to $extensionFilePath"
    cp -f ./templates/module/extension/CTMediator+Project.swift                 "$extensionFilePath"
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

    sed -i "" "s%__ProjectName__%${projectName}%g" "$podfilePath"

    sed -i "" "s%__ProjectName__%${projectName}%g" "$readmeFilePath"
    sed -i "" "s%__SpecsRepo__%${specsRepo}%g" "$readmeFilePath"

    sed -i "" "s%__ProjectName__%${projectName}%g" "$releaseFilePath"
    sed -i "" "s%__HomePage__%${homePage}%g" "$releaseFilePath"
    sed -i "" "s%__HTTPSRepo__%${httpsRepo}%g" "$releaseFilePath"

    sed -i "" "s%__ProjectName__%${projectName}%g" "$specFilePath"
    sed -i "" "s%__HomePage__%${homePage}%g"      "$specFilePath"
    sed -i "" "s%__HTTPSRepo__%${httpsRepo}%g"    "$specFilePath"
    sed -i "" "s%__Author__%${author}%g"    "$specFilePath"
    echo "Edit finished"
}

mkdir -p "${projectDirectoryPath}/${projectName}/${projectName}"

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

# [ $projectType != "Framework" ] && echo aaa || echo bbb
# echo "cleaning..."
# cd "${projectDirectoryPath}"
# git init
# git remote add origin $sshRepo  &> /dev/null
# git rm -rf --cached ./Pods/     &> /dev/null
# git rm --cached Podfile.lock    &> /dev/null
# git rm --cached .DS_Store       &> /dev/null
# git rm -rf --cached $projectName.xcworkspace/           &> /dev/null
# git rm -rf --cached $projectName.xcodeproj/xcuserdata/`whoami`.xcuserdatad/xcschemes/$projectName.xcscheme &> /dev/null
# git rm -rf --cached $projectName.xcodeproj/project.xcworkspace/xcuserdata/ &> /dev/null
# echo "clean finished"
say "Finished"
echo "Finished"
