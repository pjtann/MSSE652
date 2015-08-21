//
//  SocketSvc.m
//  msse652
//
//  Created by PT on 8/7/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "SocketSvc.h"

@implementation SocketSvc

// establish stream data members
NSInputStream *inputStream;
NSOutputStream *outputStream;

+(void) connect {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    // open the socket
    
    //CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"http://www.regisscis.net", 8080, &readStream, &writeStream);
    
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"ws://echo.websocket.org/", 8080, &readStream, &writeStream);
    
    
    
    
    // cast the streams
    inputStream = (__bridge NSInputStream *) readStream; // had to add _bridge
    outputStream = (__bridge NSOutputStream *) writeStream; // had to add _bridge
    
    //assign the delegate for callbacks
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    // schedule the run loops
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    // open the streams
    [inputStream open];
    [outputStream open];
    
}

+(void) send:(NSString *)msg{
    // encode the message
    NSData *data = [[NSData alloc] initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
    // write the encoded message to the output stream
    [outputStream write:[data bytes] maxLength:[data length]];
    NSLog(@"data: %@", data);
    NSLog(@"Output stream: %@", outputStream);
    
    
}

+(NSString *) recieve{
    
    NSMutableString *recieveMsg;
    // allocate a buffer
    uint8_t buffer[1024];
    int len=0;
    
    NSLog(@"inputStream value: %@", inputStream);
    
    while ([inputStream hasBytesAvailable]) {
        len=[inputStream read:buffer maxLength:sizeof(buffer)];
        if (len>0) {
            NSString *output = [[NSString alloc]initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
            
            NSLog(@"output value: %@", output);
            
            if (output != nil) {
                // aggregate the recieved msg strings here
            }
        }
    }
    NSLog(@"receiveMsg value: %@", recieveMsg);
    recieveMsg = inputStream;
    NSLog(@"receiveMsg value again: %@", recieveMsg);
    return recieveMsg;
}

+(void) messageRecieved: (NSString *) recieveMessage{
    
    
}


-(void) disconnect{
 
    // close the stream
    [inputStream close];
    [outputStream close];
    // remove from the run loop
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    //remove the delegate
    [inputStream setDelegate:nil];
    [outputStream setDelegate:nil];
    inputStream = nil;
    outputStream = nil;
    
}

@end
