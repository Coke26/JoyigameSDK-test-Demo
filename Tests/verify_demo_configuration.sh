#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_HEADER="${ROOT_DIR}/JoyigameSDKDemo/JOYDemoActivationConfig.h"
CONFIG_SOURCE="${ROOT_DIR}/JoyigameSDKDemo/JOYDemoActivationConfig.m"
INFO_PLIST="${ROOT_DIR}/JoyigameSDKDemo/Info.plist"
PROJECT_SPEC="${ROOT_DIR}/project.yml"

rg -q 'FOUNDATION_EXPORT NSString \*JOYDemoActivationGameId\(void\);' "${CONFIG_HEADER}"
rg -q 'FOUNDATION_EXPORT NSString \*JOYDemoActivationAppKey\(void\);' "${CONFIG_HEADER}"
rg -q 'objectForInfoDictionaryKey:key' "${CONFIG_SOURCE}"
rg -q 'JOYDemoConfigurationValue\(@"JOYTestGameId"\)' "${CONFIG_SOURCE}"
rg -q 'JOYDemoConfigurationValue\(@"JOYTestAppKey"\)' "${CONFIG_SOURCE}"
plutil -extract JOYTestGameId raw "${INFO_PLIST}" | rg -qx '\$\(JOY_TEST_GAME_ID\)'
plutil -extract JOYTestAppKey raw "${INFO_PLIST}" | rg -qx '\$\(JOY_TEST_APP_KEY\)'
rg -q 'configFiles:' "${PROJECT_SPEC}"
rg -q 'DemoConfig.xcconfig' "${PROJECT_SPEC}"

printf '[DemoConfig] configuration contract passed\n'
