# JoyigameSDK-test-Demo

`JoyigameSDK-test` 的 CocoaPods 独立接入 Demo。此仓库不包含 Joyigame SDK 源码、不引用本地联合工程，也不包含测试 gameId、appKey 或第三方登录凭据。

## 运行步骤

1. 打开 `JoyigameSDKDemo/Info.plist`，填写由 Joyigame 提供的测试参数。仓库中的 `JOYTestGameId`、`JOYTestAppKey`、Facebook 和 Google 字段默认均为空，禁止提交真实值。
2. 生成 Xcode 工程并安装 Pod：

   ```bash
   xcodegen generate
   pod install --repo-update
   open JoyigameSDKDemo.xcworkspace
   ```

3. 使用 `JoyigameSDKDemo` scheme 运行。未配置参数时，Demo 会在控制台和启动弹窗提示填写 `Info.plist`，且不会请求激活接口。

## SDK 接入

```ruby
source "https://github.com/Coke26/JoyigameSDK-test-Specs.git"
source "https://cdn.cocoapods.org/"

pod "JoyigameSDK-test", "0.1.1"
```

Objective-C 导入路径保持正式 SDK 名称：

```objc
#import <JoyigameSDK/JoyigameSDK.h>
```

## 安全规则

- 不要提交任何 appKey、token、账号、Google 配置文件或 Facebook/Google 生产配置。
- 本仓库只用于验证 CocoaPods 二进制接入；私有 `JoyigameSDKDemo` 联合工程继续用于 SDK 开发调试。
