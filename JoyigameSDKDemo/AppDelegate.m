#import "AppDelegate.h"
#import "ViewController.h"
#import "JOYDemoTestViewController.h"
#import "JOYDemoPaymentViewController.h"
#import "JOYDemoActivationConfig.h"
#import <JoyigameSDK/JoyigameSDK.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self buildRootTabBarController];
    [self.window makeKeyAndVisible];
    [self startJoyigameSDKActivation];
    return YES;
}

- (UITabBarController *)buildRootTabBarController {
    ViewController *activationViewController = [[ViewController alloc] init];
    activationViewController.title = @"激活";
    activationViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"激活"
                                                                        image:nil
                                                                selectedImage:nil];

    JOYDemoPaymentViewController *paymentViewController = [[JOYDemoPaymentViewController alloc] init];
    paymentViewController.title = @"支付";
    paymentViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"支付"
                                                                     image:nil
                                                             selectedImage:nil];

    JOYDemoTestViewController *testViewController = [[JOYDemoTestViewController alloc] init];
    testViewController.title = @"登录";
    testViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"登录"
                                                                  image:nil
                                                          selectedImage:nil];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[activationViewController, testViewController , paymentViewController ];
    return tabBarController;
}

- (void)startJoyigameSDKActivation {
    if (!JOYDemoActivationConfigurationIsReady()) {
        NSError *error = [NSError errorWithDomain:@"com.joyigame.sdk.demo"
                                             code:1001
                                         userInfo:@{NSLocalizedDescriptionKey: @"请配置 DemoConfig.xcconfig 后重新生成工程"}];
        NSLog(@"[JoyigameSDKDemo] %@", error.localizedDescription);
        [[NSNotificationCenter defaultCenter] postNotificationName:JOYDemoActivationDidFinishNotification
                                                            object:nil
                                                          userInfo:@{ @"error": error }];
        return;
    }

    [JOYSDKCenter sharedCenter].debugEnabled = YES;
    [[JOYSDKCenter sharedCenter] startWithGameId:JOYDemoActivationGameId()
                                         appKey:JOYDemoActivationAppKey()
                                     completion:^(JOYActivationConfig * _Nullable config, NSError * _Nullable error) {
        if (error) {
            NSLog(@"[JoyigameSDKDemo] 激活失败: %@", error);
            [[NSNotificationCenter defaultCenter] postNotificationName:JOYDemoActivationDidFinishNotification
                                                                object:nil
                                                              userInfo:@{@"error": error}];
            return;
        }

        NSLog(@"[JoyigameSDKDemo] 激活成功: debug=%ld review=%@ floatBall=%ld autoLogin=%ld",
              (long)config.isDebugEnabled,
              config.review,
              (long)config.isFloatBallEnabled,
              (long)config.isAutoLoginEnabled);
        [[NSNotificationCenter defaultCenter] postNotificationName:JOYDemoActivationDidFinishNotification
                                                            object:nil
                                                          userInfo:@{@"config": config}];
    }];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[JOYSDKCenter sharedCenter] application:application openURL:url options:options];
}

@end
