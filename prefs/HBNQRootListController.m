#include "HBNQRootListController.h"
#import <MobileGestalt/MobileGestalt.h>

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
    MFMailComposeViewController *emailController = [[MFMailComposeViewController alloc] init];
    emailController.subject = @"NotiQuiet Support";
    emailController.toRecipients = @[@"HASHBANG Productions Support <support@hbang.ws>"];

    NSString *product = (NSString *)MGCopyAnswer(kMGProductType);
    NSString *version = (NSString *)MGCopyAnswer(kMGProductVersion);
    NSString *build = (NSString *)MGCopyAnswer(kMGBuildVersion);

    [emailController setMessageBody:[NSString stringWithFormat:@"\n\nCurrent Device: %@, iOS %@ (%@)", product, version, build] isHTML:NO];

    system("/usr/bin/dpkg -l >/tmp/dpkgl.log");
    [emailController addAttachmentData:[NSData dataWithContentsOfFile:@"/tmp/dpkgl.log"] mimeType:@"text/plain" fileName:@"dpkgl.txt"];
    [self.navigationController presentViewController:emailController animated:YES completion:nil];
    emailController.mailComposeDelegate = self;
    [emailController release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
