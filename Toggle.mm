#include <notify.h>

#define kADNQPrefsPath @"/var/mobile/Library/Preferences/ws.hbang.notiquiet.plist"

extern "C" BOOL isCapable() {
	return YES;
}

extern "C" BOOL isEnabled() {
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:kADNQPrefsPath];
	return [prefs objectForKey:@"Enabled"] ? ![prefs objectForKey:@"Enabled"] boolValue] : YES;
}

extern "C" void setState(BOOL enabled) {
	NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:kADNQPrefsPath];
	[prefs setObject:[NSNumber numberWithBool:[prefs objectForKey:@"Enabled"] ? ![prefs objectForKey:@"Enabled"] : YES] forKey:@"Enabled"];
	[prefs writeToFile:prefpath atomically:YES];
	
	notify_post("ws.hbang.notiquiet/ReloadPrefs");
}

extern "C" float getDelayTime() {
	return 0.1f;
}
