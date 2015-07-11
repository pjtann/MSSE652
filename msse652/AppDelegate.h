//
//  AppDelegate.h
//  msse652
//
//  Created by PT on 6/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(void)downloadDataFromURL:(NSURL*)url withCompletionHandler:(void(^)(NSData *data))completionHandler;



@end

