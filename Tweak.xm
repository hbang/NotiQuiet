#import "HBNQSettingsManager.h"
#import "Interfaces.h"

%hook SBBulletinBannerController

- (void)observer:(id)observer addBulletin:(id)bulletin forFeed:(unsigned)feed playLightsAndSirens:(BOOL)lightsAndSirens withReply:(id)reply {
	NSString *currentApp = [[%c(SBUserAgent) sharedUserAgent] foregroundApplicationDisplayID];
	if ([[HBNQSettingsManager sharedManager] isEnabled] && ![[HBNQSettingsManager sharedManager] settingsHasAppSelected:currentApp]) {
		%orig;
	}
}

%end

%ctor {
	[HBNQSettingsManager sharedManager];
}