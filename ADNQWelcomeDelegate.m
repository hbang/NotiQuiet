#import "ADNQWelcomeDelegate.h"
#import <SpringBoard/SpringBoard.h>

#define L18N(key) [bundle localizedStringForKey:key value:key table:@"NotiQuiet"]

@implementation ADNQWelcomeDelegate
- (void)showAlertIfNecessary {
	if (firstRun) {
		NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/NotiQuiet.bundle"];

		UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:L18N(@"WELCOME_TITLE") message:L18N(@"WELCOME_MESSAGE") delegate:self cancelButtonTitle:L18N(@"WELCOME_DISMISS") otherButtonTitles:L18N(@"WELCOME_SETTINGS"), nil] autorelease];
		[alertView show];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index {
	if (index == 1) {
		[(SpringBoard *)[%c(SpringBoard) sharedApplication] applicationOpenURL:[NSURL URLWithString:@"prefs:root=NotiQuiet"] publicURLsOnly:NO]; // damn you 5.1
	}
}
@end
