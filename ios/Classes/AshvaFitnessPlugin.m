#import "AshvaFitnessPlugin.h"
#if __has_include(<ashva_fitness/ashva_fitness-Swift.h>)
#import <ashva_fitness/ashva_fitness-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ashva_fitness-Swift.h"
#endif

@implementation AshvaFitnessPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAshvaFitnessPlugin registerWithRegistrar:registrar];
}
@end
