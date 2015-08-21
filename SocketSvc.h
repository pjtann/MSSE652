//
//  SocketSvc.h
//  msse652
//
//  Created by PT on 8/7/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketService.h"


@interface SocketSvc : NSObject <SocketService, NSStreamDelegate> // added delegate to use as delegate and added socket service protocol

//
//-(void) connect;
//-(void) send: (NSString *) msg;
//-(NSString *) retrieve;
//-(void) disconnect;
//
//@end
//
//@protocol SocketProtocol <NSObject>
//


@end
