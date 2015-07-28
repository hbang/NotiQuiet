#import "HBNQSettingsManager.h"

@interface HBNQSettingsManager ()

@property (nonatomic, copy) NSDictionary *settings;

@end

@implementation HBNQSettingsManager

+ (instancetype)sharedManager {
    static dispatch_once_t p = 0;
    __strong static id _sharedSelf = nil;
    dispatch_once(&p, ^{
        _sharedSelf = [[self alloc] init];
    });
    return _sharedSelf;
}

void settingsChanged(CFNotificationCenterRef center,
                     void * observer,
                     CFStringRef name,
                     const void * object,
                     CFDictionaryRef userInfo) {
    [[HBNQSettingsManager sharedManager] updateSettings];
}

- (id)init {
    if (self = [super init]) {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingsChanged, CFSTR("ws.hbang.notiquiet/preferenceschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        [self updateSettings];
    }
    
    return self;
}

- (void)updateSettings {
    
    self.settings = nil;
    
    CFPreferencesAppSynchronize(CFSTR("ws.hbang.notiquiet"));
    CFStringRef appID = CFSTR("ws.hbang.notiquiet");
    CFArrayRef keyList = CFPreferencesCopyKeyList(appID , kCFPreferencesCurrentUser, kCFPreferencesAnyHost) ?: CFArrayCreate(NULL, NULL, 0, NULL);
    self.settings = (NSDictionary *)CFPreferencesCopyMultiple(keyList, appID , kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    CFRelease(keyList);

    HBLogDebug(@"%@", self.settings);
    
}

- (BOOL)isEnabled {
    return self.settings[@"enabled"] ? [self.settings[@"enabled"] boolValue] : YES;
}

- (BOOL)settingsHasAppSelected:(NSString *)appIdentfier {
    return [self.settings[[NSString stringWithFormat:@"App-%@", appIdentfier]] boolValue];
}

@end