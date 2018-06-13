//
//  NotificationHelper.m
//  LocalNotification
//
//  Created by Dogether on 12/06/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "NotificationHelper.h"
#import <React/RCTLog.h>
#import <UserNotifications/UserNotifications.h>
@implementation NotificationHelper
bool isDenied = false;
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(setNotification){
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
    if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
      [self shootNotification];
    }else if(settings.authorizationStatus == UNAuthorizationStatusDenied){
      [self showErrorMessage];
    }else{
      UNAuthorizationOptions autOption = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
      [center requestAuthorizationWithOptions:autOption completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted){
          [self shootNotification];
        }else{
          [self showErrorMessage];
        }
      }];
    
      
    }
  }];
}
-(void)shootNotification {
  dispatch_async(dispatch_get_main_queue(), ^{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    
    content.title = @"title";
    content.body = @"this is message";
    content.sound = [UNNotificationSound defaultSound];
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"custom" content:content trigger:trigger];
    [center addNotificationRequest:request withCompletionHandler:nil];
  });
}
-(void)showErrorMessage {
  dispatch_async(dispatch_get_main_queue(), ^{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                  message:@"You have denied permision for notification. Please grant the permission if you want to generate notifications."
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [alert show];
  });
}
@end
