LuaCocoa.import("Cocoa")
local SimpleLuaView = nil
SimpleLuaView = LuaCocoa.CreateClass("SimpleLuaView", NSView)
SimpleLuaView["drawRect_"] = {
  "-v@:{CGRect={CGPoint=dd}{CGSize=dd}}",
  function(self, the_rect)
    NSColor:redColor():set()
    return NSRectFill(the_rect)
  end
}
