
#import "SimpleLuaViewAppDelegate.h"
#import <LuaCocoa/LuaCocoa.h>
#include <LuaCocoa/lua.h>
#include <LuaCocoa/lualib.h>
#include <LuaCocoa/lauxlib.h>

@implementation SimpleLuaViewAppDelegate

@synthesize window;

- (void) setupLuaCocoa
{
  LuaCocoa* lua_cocoa = [[LuaCocoa alloc] init];
  luaCocoa            = lua_cocoa;

  struct lua_State* lua_state = [lua_cocoa luaState];

  NSString* the_path;
  int the_error;
  
  the_path  = [[NSBundle mainBundle] pathForResource:@"SimpleLuaView" ofType:@"lua"];
  the_error = luaL_loadfile(lua_state, [the_path fileSystemRepresentation]);
  if(the_error)
  {
    NSLog(@"luaL_loadfile failed: %s", lua_tostring(lua_state, -1));
    lua_pop(lua_state, 1); /* pop error message from stack */
    exit(0);
  }
  
  the_error = lua_pcall(lua_state, 0, 0, 0);
  if(the_error)
  {
    NSLog(@"Lua parse load failed: %s", lua_tostring(lua_state, -1));
    lua_pop(lua_state, 1); /* pop error message from stack */
    exit(0);
  } 
}

- (void) setupSimpleLuaView
{
  Class new_class = NSClassFromString(@"SimpleLuaView");
  id simple_lua_view = [[[new_class alloc] initWithFrame:[self.window.contentView frame]] autorelease];
  self.window.contentView = simple_lua_view;
}

- (id) init
{
  self = [super init];

  if(nil != self) {
    [self setupLuaCocoa];
  }

  return self;
}


- (void) applicationDidFinishLaunching:(NSNotification *) the_notification
{
  [self setupSimpleLuaView];
}

- (void) applicationWillTerminate:(NSNotification*) the_notification
{
  LuaCocoa* lua_cocoa = luaCocoa;

  [lua_cocoa release];
  luaCocoa = nil;

  [LuaCocoa collectExhaustivelyWaitUntilDone:true];
}

@end