#include <notify.h>
#define prefpath @"/var/mobile/Library/Preferences/ws.hbang.notiquiet.plist"
extern "C" BOOL isCapable(){
	return YES;
}
extern "C" BOOL isEnabled(){
	NSDictionary *prefs=[[NSDictionary alloc]initWithContentsOfFile:prefpath];
	return !prefs||![prefs objectForKey:@"Enabled"]||![[prefs objectForKey:@"Enabled"]boolValue];
}
extern "C" void setState(BOOL enabled){
	NSMutableDictionary *prefs=[[NSMutableDictionary alloc]initWithContentsOfFile:prefpath];
	[prefs setObject:[NSNumber numberWithBool:!(!prefs||![prefs objectForKey:@"Enabled"]||[[prefs objectForKey:@"Enabled"]boolValue])] forKey:@"Enabled"];
	[prefs writeToFile:prefpath atomically:YES];
	notify_post("ws.hbang.notiquiet/ReloadPrefs");
}
extern "C" float getDelayTime(){
	return 0.1f;
}
