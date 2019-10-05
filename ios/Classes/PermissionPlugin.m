#import "PermissionPlugin.h"
#import <CoreLocation/CLLocationManager.h>
#import <EventKit/EventKit.h>
#import <Photos/PHPhotoLibrary.h>
#import <Contacts/Contacts.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

@import AVFoundation;
@import CoreTelephony;
CLLocationManager *locationManager;
@implementation PermissionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"plugins.ly.com/permission"
                                     binaryMessenger:[registrar messenger]];
    PermissionPlugin* instance = [[PermissionPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPermissionsStatus" isEqualToString:call.method]) {
        NSDictionary *argsMap = call.arguments;
        NSArray *permissions = argsMap[@"permissions"];
        NSMutableArray *list = @[].mutableCopy;
        for (NSString *permissionName in permissions) {
            if ([@"Camera" isEqualToString:permissionName]){
                PHAuthorizationStatus PHStatus = [PHPhotoLibrary authorizationStatus];
                switch (PHStatus) {
                    case PHAuthorizationStatusAuthorized:
                        [list addObject:@0];
                        break;
                    case PHAuthorizationStatusDenied:
                        [list addObject:@1];
                        break;
                    case PHAuthorizationStatusNotDetermined:
                        [list addObject:@2];
                        break;
                    case PHAuthorizationStatusRestricted:
                        [list addObject:@1];
                        break;
                    default:
                        [list addObject:@2];
                        break;
                }
            } else if ([@"Location" isEqualToString:permissionName]){
                CLAuthorizationStatus CLStatus =  [CLLocationManager authorizationStatus];
                switch (CLStatus) {
                    case kCLAuthorizationStatusAuthorizedWhenInUse:
                        [list addObject:@4];
                        break;
                    case kCLAuthorizationStatusAuthorizedAlways:
                        [list addObject:@5];
                        break;
                    case kCLAuthorizationStatusDenied:
                        [list addObject:@1];
                        break;
                    case kCLAuthorizationStatusNotDetermined:
                        [list addObject:@2];
                        break;
                    case kCLAuthorizationStatusRestricted:
                        [list addObject:@1];
                        break;
                    default:
                        [list addObject:@2];
                        break;
                }
            }
        }
        while (1) {
            if (list.count == permissions.count) {
                result(list);
                return;
            }
        }
    } else if ([@"requestPermissions" isEqualToString:call.method]) {
        NSDictionary *argsMap = call.arguments;
        NSArray *permissions = argsMap[@"permissions"];
        for (NSString *permissionName in permissions) {
            if ([@"Camera" isEqualToString:permissionName]){
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus PHStatus) {
                    switch (PHStatus) {
                        case PHAuthorizationStatusAuthorized:
                            result(@0);
                            break;
                        case PHAuthorizationStatusDenied:
                            result(@1);
                            break;
                        case PHAuthorizationStatusNotDetermined:
                            result(@2);
                            break;
                        case PHAuthorizationStatusRestricted:
                            result(@1);
                            break;
                        default:
                            result(@2);
                            break;
                    }
                }];
            } else if ([@"Location" isEqualToString:permissionName]){
                locationManager = [[CLLocationManager alloc] init];
                [locationManager requestAlwaysAuthorization];
            }
        }
    } else if ([@"openSettings" isEqualToString:call.method]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        result(@YES);
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end
