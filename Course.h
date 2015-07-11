//
//  Course.h
//  msse652
//
//  Created by PT on 7/10/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Program.h"


@interface Course : NSObject

@property (nonatomic) int courseId;
@property (nonatomic) NSString *courseName;
@property (nonatomic) Program *programName;
@property (nonatomic) Program *program;




-(instancetype) initWithId:(int) ident andName:(NSString *) name;
-(instancetype) initWithId:(int)ident andName:(NSString *)name andProgram:(Program *) program;



@end
