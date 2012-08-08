#import <Cocoa/Cocoa.h>

@class LuaCocoa;

@interface SimpleLuaViewAppDelegate : NSObject
{
  NSWindow *window;
  LuaCocoa* luaCocoa;
}

@property (assign) IBOutlet NSWindow *window;

@end