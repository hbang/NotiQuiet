#import "HBNQSettingsManager.h"
#import <Cephei/HBPreferences.h>

static NSString *const kHBNQEnabledKey = @"Enabled";

@implementation HBNQSettingsManager {
    HBPreferences *_preferences;
}

+ (instancetype)sharedInstance {
    static HBNQSettingsManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _preferences = [[HBPreferences alloc] initWithIdentifier:@"ws.hbang.notiquiet"];

        [_preferences registerBool:&_enabled default:YES forKey:kHBNQEnabledKey];
    }
    return self;
}

- (BOOL)shouldHideNotificationsInAppWithIdentifier:(NSString *)appIdentfier {
    return [_preferences[[NSString stringWithFormat:@"App-%@", appIdentfier]] boolValue];
}

#pragma mark - Memory management

- (void)dealloc {
    [_preferences release];

    [super dealloc];
}

@end
