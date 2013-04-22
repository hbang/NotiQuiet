/**
 * NotiQuiet
 *
 * By Ad@m <http://adam.hbang.ws>
 * Licensed under the MIT License <http://adam.mit-license.org>
 * Not based on any other tweaks (tm)
 */

#define prefpath @"/var/mobile/Library/Preferences/ws.hbang.notiquiet.plist"
#define __(key) [bundle localizedStringForKey:key value:key table:@"NotiQuiet"]

static NSBundle *bundle;
static NSDictionary *prefs;
static BOOL firstRun = NO;

@interface SpringBoard : UIApplication
@end

@interface UIApplication (thekirbylover)
-(void)applicationOpenURL:(NSURL *)url publicURLsOnly:(BOOL)publicURLs;
@end

@interface SBUserAgent : NSObject
+(SBUserAgent *)sharedUserAgent;
-(NSString *)foregroundApplicationDisplayID;
@end

@interface ADNQWelcomeDelegate : NSObject <UIAlertViewDelegate>
-(void)showAlertIfNecessary;
@end

@implementation ADNQWelcomeDelegate
-(void)showAlertIfNecessary {
	if (firstRun) {
		UIAlertView *thanks = [[UIAlertView alloc] initWithTitle:__(@"WELCOME_TITLE") message:__(@"WELCOME_MESSAGE") delegate:self cancelButtonTitle:__(@"WELCOME_DISMISS") otherButtonTitles:__(@"WELCOME_SETTINGS"), nil];
		[thanks show];
		[thanks release];
	}
}
-(void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)index {
	if ([[alert buttonTitleAtIndex:index]isEqualToString:__(@"WELCOME_SETTINGS")]) {
		[[%c(SpringBoard) sharedApplication] applicationOpenURL:[NSURL URLWithString:@"prefs:root=NotiQuiet"] publicURLsOnly:NO]; //damn you 5.1
	}
}
@end

%hook SBBulletinBannerController
-(void)observer:(id)observer addBulletin:(id)bulletin forFeed:(unsigned)feed {
	NSString *currentApp = [[%c(SBUserAgent) sharedUserAgent] foregroundApplicationDisplayID];

	if (([prefs objectForKey:@"Enabled"] && ![[prefs objectForKey:@"Enabled"] boolValue])
		|| !currentApp || !([prefs objectForKey:[@"App-" stringByAppendingString:currentApp]]
		&& [[prefs objectForKey:[@"App-" stringByAppendingString:currentApp]] boolValue])) {
		%orig;
	}
}
%end
%hook SBUIController
-(void)finishedUnscattering {
	%orig;

	if (firstRun) {
		ADNQWelcomeDelegate *welc = [[ADNQWelcomeDelegate alloc]init];
		[welc showAlertIfNecessary]; //memory leak?
		firstRun = NO;
	}
}
%end

static void ADNQPrefsLoad() {
	if ([[NSFileManager defaultManager] fileExistsAtPath:prefpath]) {
		prefs = [[NSDictionary alloc] initWithContentsOfFile:prefpath];
	} else {
		firstRun = YES;
		prefs = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithBool:YES], @"Enabled", nil];
		[prefs writeToFile:prefpath atomically:YES];
	}
}

%ctor {
	%init;
	ADNQPrefsLoad();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ADNQPrefsUpdate, CFSTR("ws.hbang.notiquiet/ReloadPrefs"), NULL, 0);
	bundle = [[NSBundle bundleWithPath:@"/Library/PreferenceBundles/NotiQuiet.bundle"] retain];
}
