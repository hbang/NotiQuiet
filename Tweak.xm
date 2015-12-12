#import "HBNQSettingsManager.h"
#import <SpringBoard/SBUserAgent.h>

%hook SBBulletinBannerController

- (void)observer:(id)observer addBulletin:(id)bulletin forFeed:(unsigned)feed playLightsAndSirens:(BOOL)lightsAndSirens withReply:(id)reply {
	NSString *currentApp = [[%c(SBUserAgent) sharedUserAgent] foregroundApplicationDisplayID];
	if ([HBNQSettingsManager sharedInstance].enabled && ![[HBNQSettingsManager sharedInstance] shouldHideNotificationsInAppWithIdentifier:currentApp]) {
		%orig;
	}
}

%end
