#!/bin/bash

httpsRepo="https://github.com/Limon-O-O/Lego.git"
sshRepo="git@github.com:Limon-O-O/Lego.git"
specsRepo="https://github.com/Limon-O-O/Lego.git"
homePage="https://github.com/Limon-O-O/Lego"

BGreen='\033[1;32m'
Default='\033[0;m'

projectName=""
confirmed="n"
profilePath="./templates/Podfile"

getProjectName() {
    read -p "Enter Project Name: " projectName

    if [[ -z ${projectName} ]]; then
        echo "Invalid project name." && exit 1
    fi

    if test -z "$projectName"; then
        getProjectName
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

    echo -e "\n${Default}================================================"
    echo -e "  Project Name  :  ${BGreen}${projectName}${Default}"
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

projectDirectoryPath="../${projectName}"

mkdir -p "${projectDirectoryPath}/${projectName}/${projectName}"

licenseFilePath="${projectDirectoryPath}/FILE_LICENSE"
gitignoreFilePath="${projectDirectoryPath}/.gitignore"
specFilePath="${projectDirectoryPath}/${projectName}.podspec"
readmeFilePath="${projectDirectoryPath}/README.md"
uploadFilePath="${projectDirectoryPath}/upload.sh"
releaseFilePath="${projectDirectoryPath}/release.sh"
compareFilePath="${projectDirectoryPath}/version_compare.sh"
podfilePath="${projectDirectoryPath}/Podfile"
updateVersionPath="${projectDirectoryPath}/update_version.sh"

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
echo "Edit finished"

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
