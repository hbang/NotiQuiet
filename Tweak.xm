/**
 * NotiQuiet
 *
 * By Ad@m <http://adam.hbang.ws>
 * Licensed under the MIT License <http://adam.mit-license.org>
 * Not based on any other tweaks (tm)
 */

#import <SpringBoard/SpringBoard.h>
#import <SpringBoard/SBUserAgent.h>
#import "ADNQWelcomeDelegate.h"

NSDictionary *prefs;
BOOL firstRun = NO;

%hook SBBulletinBannerController
- (void)observer:(id)observer addBulletin:(id)bulletin forFeed:(unsigned)feed {
	NSString *currentApp = [[%c(SBUserAgent) sharedUserAgent] foregroundApplicationDisplayID];

	if (([prefs objectForKey:@"Enabled"] && ![[prefs objectForKey:@"Enabled"] boolValue]) || !currentApp
		|| !([prefs objectForKey:[@"App-" stringByAppendingString:currentApp]] && [[prefs objectForKey:[@"App-" stringByAppendingString:currentApp]] boolValue])) {
		%orig;
	}
}
%end

%hook SBUIController
- (void)finishedUnscattering {
	%orig;

	if (firstRun) {
		ADNQWelcomeDelegate *welcomeDelegate = [[ADNQWelcomeDelegate alloc] init];
		[welcomeDelegate showAlertIfNecessary];
		firstRun = NO;
	}
}
%end

static void ADNQPrefsLoad() {
	prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/ws.hbang.notiquiet.plist"];
	
	if (!prefs) {
		firstRun = YES;
	}
}

%ctor {
	ADNQPrefsLoad();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ADNQPrefsLoad, CFSTR("ws.hbang.notiquiet/ReloadPrefs"), NULL, 0);
}
