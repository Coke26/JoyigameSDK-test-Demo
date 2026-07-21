#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 公开 Demo 从 Info.plist 读取由本地 xcconfig 注入的测试 gameId。
FOUNDATION_EXPORT NSString *JOYDemoActivationGameId(void);

/// 公开 Demo 从 Info.plist 读取由本地 xcconfig 注入的测试 appKey。
FOUNDATION_EXPORT NSString *JOYDemoActivationAppKey(void);

/// 判断本地 DemoConfig.xcconfig 是否已替换所有占位符，未完成配置时不得请求后端。
FOUNDATION_EXPORT BOOL JOYDemoActivationConfigurationIsReady(void);

FOUNDATION_EXPORT NSNotificationName const JOYDemoActivationDidFinishNotification;

NS_ASSUME_NONNULL_END
