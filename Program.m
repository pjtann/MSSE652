//
//  Program.m
//  msse652
//
//  Created by PT on 7/10/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "Program.h"

@implementation Program

-(NSString *) description {
    return [NSString stringWithFormat:@"\n ProgramId: %i \n ProgramName: %@", _programId, _programName];
    
}

-(instancetype) initWithId: (int) ident andName: (NSString *) name{
    self = [super init];
    if (self) {
        _programId = ident;
        _programName = name;
    }
    return self;
}

@end
