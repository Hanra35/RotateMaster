#!/usr/bin/env python3
import os, shutil

A="AA000000000000000000000A"
B="AA000000000000000000000B"
C="AA000000000000000000000C"
DD="AA000000000000000000000D"
E="AA000000000000000000000E"
F="AA000000000000000000000F"
G="AA000000000000000000000G"
H="AA000000000000000000000H"
I="AA000000000000000000000I"
J="AA000000000000000000000J"
K="AA000000000000000000000K"
L="AA000000000000000000000L"
M="AA000000000000000000000M"
N="AA000000000000000000000N"
O="AA000000000000000000000O"
P="AA000000000000000000000P"
Q="AA000000000000000000000Q"
R="AA000000000000000000000R"
S="AA000000000000000000000S"
T="AA000000000000000000000T"
U="AA000000000000000000000U"

pbxproj = """// !$*UTF8*$!
{
\tarchiveVersion = 1;
\tclasses = {
\t};
\tobjectVersion = 56;
\tobjects = {

/* Begin PBXBuildFile section */
\t\t"""+F+""" /* AppDelegate.swift */ = {isa = PBXBuildFile; fileRef = """+B+"""; };
\t\t"""+G+""" /* ViewController.swift */ = {isa = PBXBuildFile; fileRef = """+C+"""; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
\t\t"""+A+""" = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = RotateMaster.app; sourceTree = BUILT_PRODUCTS_DIR; };
\t\t"""+B+""" = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
\t\t"""+C+""" = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "<group>"; };
\t\t"""+DD+""" = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
\t\t"""+E+""" = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = entitlements.plist; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
\t\t"""+N+""" = {
\t\t\tisa = PBXFrameworksBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
\t\t"""+H+""" = {
\t\t\tisa = PBXGroup;
\t\t\tchildren = (
\t\t\t\t"""+I+""",
\t\t\t\t"""+J+""",
\t\t\t);
\t\t\tsourceTree = "<group>";
\t\t};
\t\t"""+I+""" /* RotateMaster */ = {
\t\t\tisa = PBXGroup;
\t\t\tchildren = (
\t\t\t\t"""+B+""",
\t\t\t\t"""+C+""",
\t\t\t\t"""+DD+""",
\t\t\t\t"""+E+""",
\t\t\t);
\t\t\tpath = RotateMaster;
\t\t\tsourceTree = "<group>";
\t\t};
\t\t"""+J+""" /* Products */ = {
\t\t\tisa = PBXGroup;
\t\t\tchildren = (
\t\t\t\t"""+A+""",
\t\t\t);
\t\t\tname = Products;
\t\t\tsourceTree = "<group>";
\t\t};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
\t\t"""+K+""" /* RotateMaster */ = {
\t\t\tisa = PBXNativeTarget;
\t\t\tbuildConfigurationList = """+T+""";
\t\t\tbuildPhases = (
\t\t\t\t"""+M+""",
\t\t\t\t"""+N+""",
\t\t\t\t"""+O+""",
\t\t\t);
\t\t\tbuildRules = (
\t\t\t);
\t\t\tdependencies = (
\t\t\t);
\t\t\tname = RotateMaster;
\t\t\tproductName = RotateMaster;
\t\t\tproductReference = """+A+""";
\t\t\tproductType = "com.apple.product-type.application";
\t\t};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
\t\t"""+L+""" /* Project object */ = {
\t\t\tisa = PBXProject;
\t\t\tattributes = {
\t\t\t\tLastSwiftUpdateCheck = 1500;
\t\t\t\tLastUpgradeCheck = 1500;
\t\t\t};
\t\t\tbuildConfigurationList = """+U+""";
\t\t\tcompatibilityVersion = "Xcode 14.0";
\t\t\tdevelopmentRegion = fr;
\t\t\thasScannedForEncodings = 0;
\t\t\tknownRegions = (
\t\t\t\ten,
\t\t\t\tBase,
\t\t\t);
\t\t\tmainGroup = """+H+""";
\t\t\tproductRefGroup = """+J+""";
\t\t\tprojectDirPath = "";
\t\t\tprojectRoot = "";
\t\t\ttargets = (
\t\t\t\t"""+K+""",
\t\t\t);
\t\t};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
\t\t"""+O+""" = {
\t\t\tisa = PBXResourcesBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
\t\t"""+M+""" = {
\t\t\tisa = PBXSourcesBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
\t\t\t\t"""+F+""" /* AppDelegate.swift */,
\t\t\t\t"""+G+""" /* ViewController.swift */,
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t};
/* End PBXSourcesBuildPhase section */

/* Begin XCBuildConfiguration section */
\t\t"""+P+""" /* Debug */ = {
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {
\t\t\t\tCODE_SIGN_IDENTITY = "";
\t\t\t\tCODE_SIGNING_ALLOWED = NO;
\t\t\t\tCODE_SIGNING_REQUIRED = NO;
\t\t\t\tDEAD_CODE_STRIPPING = NO;
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 14.0;
\t\t\t\tSDKROOT = iphoneos;
\t\t\t\tSWIFT_OPTIMIZATION_LEVEL = "-Onone";
\t\t\t};
\t\t\tname = Debug;
\t\t};
\t\t"""+Q+""" /* Release */ = {
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {
\t\t\t\tCODE_SIGN_IDENTITY = "";
\t\t\t\tCODE_SIGNING_ALLOWED = NO;
\t\t\t\tCODE_SIGNING_REQUIRED = NO;
\t\t\t\tDEAD_CODE_STRIPPING = NO;
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 14.0;
\t\t\t\tSDKROOT = iphoneos;
\t\t\t};
\t\t\tname = Release;
\t\t};
\t\t"""+R+""" /* Debug Target */ = {
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {
\t\t\t\tCODE_SIGN_IDENTITY = "";
\t\t\t\tCODE_SIGNING_ALLOWED = NO;
\t\t\t\tCODE_SIGNING_REQUIRED = NO;
\t\t\t\tCODE_SIGN_ENTITLEMENTS = RotateMaster/entitlements.plist;
\t\t\t\tCURRENT_PROJECT_VERSION = 1;
\t\t\t\tINFOPLIST_FILE = RotateMaster/Info.plist;
\t\t\t\tLD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
\t\t\t\tMARKETING_VERSION = 1.0;
\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = com.local.rotatemaster;
\t\t\t\tPRODUCT_NAME = "$(TARGET_NAME)";
\t\t\t\tSUPPORTED_PLATFORMS = iphoneos;
\t\t\t\tSUPPORTS_MACCATALYST = NO;
\t\t\t\tSWIFT_VERSION = 5.0;
\t\t\t\tTARGETED_DEVICE_FAMILY = 1;
\t\t\t};
\t\t\tname = Debug;
\t\t};
\t\t"""+S+""" /* Release Target */ = {
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {
\t\t\t\tCODE_SIGN_IDENTITY = "";
\t\t\t\tCODE_SIGNING_ALLOWED = NO;
\t\t\t\tCODE_SIGNING_REQUIRED = NO;
\t\t\t\tCODE_SIGN_ENTITLEMENTS = RotateMaster/entitlements.plist;
\t\t\t\tCURRENT_PROJECT_VERSION = 1;
\t\t\t\tINFOPLIST_FILE = RotateMaster/Info.plist;
\t\t\t\tLD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
\t\t\t\tMARKETING_VERSION = 1.0;
\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = com.local.rotatemaster;
\t\t\t\tPRODUCT_NAME = "$(TARGET_NAME)";
\t\t\t\tSUPPORTED_PLATFORMS = iphoneos;
\t\t\t\tSUPPORTS_MACCATALYST = NO;
\t\t\t\tSWIFT_VERSION = 5.0;
\t\t\t\tTARGETED_DEVICE_FAMILY = 1;
\t\t\t};
\t\t\tname = Release;
\t\t};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
\t\t"""+T+""" = {
\t\t\tisa = XCConfigurationList;
\t\t\tbuildConfigurations = (
\t\t\t\t"""+R+""",
\t\t\t\t"""+S+""",
\t\t\t);
\t\t\tdefaultConfigurationIsVisible = 0;
\t\t\tdefaultConfigurationName = Release;
\t\t};
\t\t"""+U+""" = {
\t\t\tisa = XCConfigurationList;
\t\t\tbuildConfigurations = (
\t\t\t\t"""+P+""",
\t\t\t\t"""+Q+""",
\t\t\t);
\t\t\tdefaultConfigurationIsVisible = 0;
\t\t\tdefaultConfigurationName = Release;
\t\t};
/* End XCConfigurationList section */
\t};
\trootObject = """+L+""";
}
"""

info_plist = """<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDisplayName</key><string>RotateMaster</string>
  <key>CFBundleExecutable</key><string>$(EXECUTABLE_NAME)</string>
  <key>CFBundleIdentifier</key><string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
  <key>CFBundleName</key><string>$(PRODUCT_NAME)</string>
  <key>CFBundlePackageType</key><string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>CFBundleVersion</key><string>1</string>
  <key>LSRequiresIPhoneOS</key><true/>
  <key>UILaunchScreen</key><dict/>
  <key>UISupportedInterfaceOrientations</key>
  <array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationPortraitUpsideDown</string>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
  </array>
  <key>UIUserInterfaceStyle</key><string>Dark</string>
  <key>UIApplicationSceneManifest</key>
  <dict><key>UIApplicationSupportsMultipleScenes</key><false/></dict>
</dict>
</plist>"""

entitlements = """<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>platform-application</key><true/>
  <key>com.apple.private.springboard.rotation</key><true/>
  <key>com.apple.private.security.no-sandbox</key><true/>
  <key>com.apple.springboard.services</key><true/>
</dict>
</plist>"""

os.makedirs("RotateMaster.xcodeproj", exist_ok=True)
os.makedirs("RotateMaster", exist_ok=True)

with open("RotateMaster.xcodeproj/project.pbxproj","w") as f: f.write(pbxproj)
print("OK project.pbxproj")
with open("RotateMaster/Info.plist","w") as f: f.write(info_plist)
print("OK Info.plist")
with open("RotateMaster/entitlements.plist","w") as f: f.write(entitlements)
print("OK entitlements.plist")

for src in ["AppDelegate.swift","ViewController.swift"]:
    if os.path.exists(src):
        shutil.copy(src, "RotateMaster/"+src)
        print("OK "+src)
    else:
        print("ERREUR: "+src+" introuvable!")
        exit(1)

print("\nSucces! Fichiers generes.")
