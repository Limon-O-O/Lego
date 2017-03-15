#!/bin/bash
# Link: <https://gist.github.com/jellybeansoup/db7b24fb4c7ed44030f4>
# ./update-version.sh --version=1.2.9 --build=95 --target=MonkeyKing

# We use PlistBuddy to handle the Info.plist values. Here we define where it lives.
plistBuddy="/usr/libexec/PlistBuddy"

BGreen='\033[1;32m'
Default='\033[0;m'

# Parse input variables and update settings.
for i in "$@"; do
case $i in
	-h|--help)
	echo "usage: sh version-update.sh [options...]\n"
	echo "Options: (when provided via the CLI, these will override options set within the script itself)"
	echo "    --build=<number>          Apply the given value to the build number (CFBundleVersion) for the project."
	echo "-p, --plist=<path>            Use the specified plist file as the source of truth for version details."
	echo "    --version=<number>        Apply the given value to the marketing version (CFBundleShortVersionString) for the project."
	echo "-x, --xcodeproj=<path>        Use the specified Xcode project file to gather plist names."
	echo "-x, --target=<name>         	Use the specified Xcode project target to gather plist names."
	echo "\nFor more detailed information on the use of these variables, see the script source."
	exit 1 
	;;
	-x=*|--xcodeproj=*)
	xcodeproj="${i#*=}"
	shift
	;;
	-p=*|--plist=*)
	plist="${i#*=}"
	shift
	;;
	--target=*)
	specified_target="${i#*=}"
	shift
	;;
	--build=*)
	specified_build="${i#*=}"
	shift
	;;
	--version=*)
	specified_version="${i#*=}"
	shift
	;;
	*)
	;;
esac
done

# Locate the xcodeproj.
# If we've specified a xcodeproj above, we'll simply use that instead.
if [[ -z ${xcodeproj} ]]; then
	xcodeproj=$(find . -depth 1 -name "*.xcodeproj" | sed -e 's/^\.\///g')
fi

# Check that the xcodeproj file we've located is valid, and warn if it isn't.
# This could also indicate an issue with the code used to automatically locate the xcodeproj file.
# If you're encountering this and the file exists, ensure that ${xcodeproj} contains the correct
# path, or use the "--xcodeproj" variable to provide an accurate location.
if [[ ! -f "${xcodeproj}/project.pbxproj" ]]; then
	echo "${BASH_SOURCE}:${LINENO}: error: Could not locate the xcodeproj file \"${xcodeproj}\"."
	exit 1
else 
	echo "Xcode Project: \"${xcodeproj}\""
fi

# Find unique references to Info.plist files in the project
projectFile="${xcodeproj}/project.pbxproj"
plists=$(grep "^\s*INFOPLIST_FILE.*$" "${projectFile}" | sed -Ee 's/^[[:space:]]+INFOPLIST_FILE[[:space:]*=[[:space:]]*["]?([^"]+)["]?;$/\1/g' | sort | uniq)

# Attempt to guess the plist based on the list we have.
# If we've specified a plist above, we'll simply use that instead.
if [[ -z ${plist} ]]; then
	while read -r thisPlist; do
		if [[ $thisPlist == *"${specified_target}"* ]]; then
			plist=$thisPlist
        fi
	done <<< "${plists}"
fi

# Check that the plist file we've located is valid, and warn if it isn't.
# This could also indicate an issue with the code used to match plist files in the xcodeproj file.
# If you're encountering this and the file exists, ensure that ${plists} contains _ONLY_ filenames.
if [[ ! -f ${plist} ]]; then
	echo "${BASH_SOURCE}:${LINENO}: error: Could not locate the plist file \"${plist}\"."
	exit 1		
else
	echo "Source Info.plist: \"${plist}\""
fi

# Find the current build number in the main Info.plist
mainBundleVersion=$("${plistBuddy}" -c "Print CFBundleVersion" "${plist}")
mainBundleShortVersionString=$("${plistBuddy}" -c "Print CFBundleShortVersionString" "${plist}")
echo "Current project version is ${mainBundleShortVersionString} (${mainBundleVersion})."

# If the user specified a marketing version (via "--version"), we overwrite the version from the source of truth.
if [[ ! -z ${specified_version} ]]; then
	mainBundleShortVersionString=${specified_version}
	echo "Applying specified marketing version (${specified_version})..."
fi

if [[ ! -z ${specified_build} ]]; then
	mainBundleVersion=${specified_build}
	echo "Applying specified build number (${specified_build})..."
fi

# Update all of the Info.plist files we discovered
while read -r thisPlist; do
	# Find out the current version
	thisBundleVersion=$("${plistBuddy}" -c "Print CFBundleVersion" "${thisPlist}")
	thisBundleShortVersionString=$("${plistBuddy}" -c "Print CFBundleShortVersionString" "${thisPlist}")
	# Update the CFBundleVersion if needed
	if [[ ${thisBundleVersion} != ${mainBundleVersion} ]]; then
		echo -e "${BGreen}Updating \"${thisPlist}\" with build ${mainBundleVersion}...${Default}"
		"${plistBuddy}" -c "Set :CFBundleVersion ${mainBundleVersion}" "${thisPlist}"
	fi
	# Update the CFBundleShortVersionString if needed
	if [[ ${thisBundleShortVersionString} != ${mainBundleShortVersionString} ]]; then
		echo -e "${BGreen}Updating \"${thisPlist}\" with marketing version ${mainBundleShortVersionString}...${Default}"
		"${plistBuddy}" -c "Set :CFBundleShortVersionString ${mainBundleShortVersionString}" "${thisPlist}"
		git add "${thisPlist}"
	fi
	echo -e "${BGreen}Current \"${thisPlist}\" version is ${mainBundleShortVersionString} (${mainBundleVersion}).${Default}"
done <<< "${plist}"
