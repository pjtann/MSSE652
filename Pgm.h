//
//  Pgm.h
//  msse652
//
//  Created by PT on 7/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pgm : NSObject

@property (nonatomic)int pgmId;
@property (nonatomic) NSString * pgmName;

-(instancetype) initWithId:(int) ident andName:(NSString *) name;


@end
