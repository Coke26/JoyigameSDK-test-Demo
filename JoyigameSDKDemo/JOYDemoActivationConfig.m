#import "JOYDemoActivationConfig.h"

NSNotificationName const JOYDemoActivationDidFinishNotification = @"JOYDemoActivationDidFinishNotification";

static NSString *JOYDemoConfigurationValue(NSString *key) {
    id value = [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
    return [value isKindOfClass:NSString.class] ? value : @"";
}

static BOOL JOYDemoConfigurationValueIsPlaceholder(NSString *value) {
    return value.length == 0 || [value hasPrefix:@"$("] || [value hasPrefix:@"<"];
}

NSString *JOYDemoActivationGameId(void) {
    return JOYDemoConfigurationValue(@"JOYTestGameId");
}

NSString *JOYDemoActivationAppKey(void) {
    return JOYDemoConfigurationValue(@"JOYTestAppKey");
}

BOOL JOYDemoActivationConfigurationIsReady(void) {
    return !JOYDemoConfigurationValueIsPlaceholder(JOYDemoActivationGameId()) &&
           !JOYDemoConfigurationValueIsPlaceholder(JOYDemoActivationAppKey());
}
