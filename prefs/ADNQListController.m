#import <Preferences/PSListController.h>

@implementation ADNQListController
- (id)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"NotiQuiet" target:self] retain];
	}
	
	return _specifiers;
}

- (void)followOnTwitter {
	if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tweetbot:///user_profile/thekirbylover"]];
	} else if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"tweetings:"]]) {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tweetings:///user?screen_name=thekirbylover"]];
	} else if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"twitter://user?screen_name=thekirbylover"]];
	} else {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://twitter.com/intent/follow?screen_name=thekirbylover"]];
	}
}
@end
