//
//  Pgm.m
//  msse652
//
//  Created by PT on 7/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "Pgm.h"

@implementation Pgm

//@dynamic pgmId;
//@dynamic pgmName;

-(NSString *) description {
    return [NSString stringWithFormat:@"\n PgmId: %i \n PgmName: %@", self.pgmId, self.pgmName];
    
}

-(instancetype) initWithId: (int) ident andName: (NSString *) name{
    self = [super init];
    if (self) {
        _pgmId = ident;
        _pgmName = name;
    }
    return self;
}

@end
