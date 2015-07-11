//
//  Course.m
//  msse652
//
//  Created by PT on 7/10/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "Course.h"

@implementation Course

-(instancetype) initWithId:(int)ident andName:(NSString *)name{
    self = [super init];
    if (self) {
        _courseId = ident;
        _courseName = name;
    }
    return self;
}

-(instancetype) initWithId:(int) ident andName:(NSString *) name andProgram:(Program *)program {
    self = [super init];
    if (self) {
        _courseId = ident;
        _courseName = name;
        _program = program;
    }
    return self;
}

@end
