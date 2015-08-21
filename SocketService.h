//
//  SocketService.h
//  msse652
//
//  Created by PT on 8/19/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketSvc.h"


@protocol SocketService <NSObject>


+(void) connect;
+(void) send: (NSString *) msg;

+(NSString *) recieve;
//+(NSString *) recieve: (NSString *)recieveMsg;
+(void) disconnect;

+(void) messageRecieved: (NSString *) recieveMessage;


@end
