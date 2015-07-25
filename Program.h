//
//  Program.h
//  msse652
//
//  Created by PT on 7/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Program : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;

// properties for NSURL tab of programs and courses
//@property (nonatomic) int programId;
//@property (nonatomic) NSString *programName;
//-(instancetype) initWithId:(int) ident andName:(NSString *) name;


@end
