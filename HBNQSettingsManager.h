@interface HBNQSettingsManager : NSObject

@property (nonatomic, readonly) BOOL enabled;

+ (instancetype)sharedInstance;

- (BOOL)shouldHideNotificationsInAppWithIdentifier:(NSString *)appIdentfier;

@end
