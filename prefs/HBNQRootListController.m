#include "HBNQRootListController.h"
#import <CepheiPrefs/HBSupportController.h>

@implementation HBNQRootListController

+ (NSString *)hb_specifierPlist {
	return @"Root";
}

+ (NSString *)hb_shareText {
	return @"I'm using NotiQuiet to hide notifications when I'm in certain apps. It's on BigBoss, for free. Check it out!";
}

+ (NSString *)hb_shareURL {
	return @"https://hbang.ws/";
}

+ (UIColor *)hb_tintColor {
	return [UIColor colorWithRed:0.012 green:0.278 blue:0.361 alpha:1.00];
}

+ (BOOL)hb_invertedNavigationBar {
	return YES;
}

- (void)showSupportEmailController {
	UIViewController *viewController = (UIViewController *)[HBSupportController supportViewControllerForBundle:[NSBundle bundleForClass:self.class] preferencesIdentifier:@"ws.hbang.notiquiet"];
	[self.navigationController pushViewController:viewController animated:YES];
}

- (void)openSupportFAQ {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.hbang.ws/faq/"]];
}

@end
