#import "XuiPlugin.h"
#if __has_include(<xui/xui-Swift.h>)
#import <xui/xui-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "xui-Swift.h"
#endif

@implementation XuiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftXuiPlugin registerWithRegistrar:registrar];
}
@end
