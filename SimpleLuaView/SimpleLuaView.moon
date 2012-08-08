LuaCocoa.import("Cocoa")

SimpleLuaView = nil

SimpleLuaView = LuaCocoa.CreateClass("SimpleLuaView", NSView)

SimpleLuaView["drawRect_"] = {
  "-v@:{CGRect={CGPoint=dd}{CGSize=dd}}",
  (self, the_rect) ->
    NSColor\redColor()\set()
    NSRectFill(the_rect)
}