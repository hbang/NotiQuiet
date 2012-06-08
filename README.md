# NotiQuiet - disable push notifications inside particular apps
## Internals
* [AppList](http://github.com/rpetrich/AppList) is used to allow the user to choose apps from the Settings.app panel
* When a notification comes in, if the foreground app's bundle ID matches one in the list, it's hidden by not running `%orig` in the notification displaying method. This still allows it to appear in the NC.

## License
[MIT](http://adam.mit-license.org). 
Icons are [CC-BY](http://creativecommons.org/licenses/by/3.0), from [Jigsoar Icons](http://jigsoaricons.com). 
