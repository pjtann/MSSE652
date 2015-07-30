//
//  Program.m
//  msse652
//
//  Created by PT on 7/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "Program.h"


@implementation Program

@dynamic id;
@dynamic name;

@dynamic programId;
@dynamic programName;

-(NSString *) description {
    return [NSString stringWithFormat:@"\n ProgramId: %i \n ProgramName: %@", self.programId, self.programName];
    
}

-(instancetype) initWithId: (int) ident andName: (NSString *) name{
    self = [super init];
    if (self) {
        self.programId = ident;
        self.programName = name;
    }
    return self;
}



@end
