//
//  SocketSvc.h
//  msse652
//
//  Created by PT on 8/7/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketSvc : NSObject <NSStreamDelegate> // added delegate to use as delegate

-(void) connect;
-(void) send: (NSString *) msg;
-(NSString *) retrieve;
-(void) disconnect;

@end

@protocol SocketProtocol <NSObject>



@end
