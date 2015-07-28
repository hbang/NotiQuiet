@interface HBNQSettingsManager : NSObject

@property (nonatomic, readonly, getter=isEnabled) BOOL enabled;

+ (instancetype)sharedManager;

- (void)updateSettings;

- (BOOL)settingsHasAppSelected:(NSString *)appIdentfier;

@end