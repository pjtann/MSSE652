//
//  CourseDetailViewController.h
//  msse652
//
//  Created by PT on 7/11/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"


@interface CourseDetailViewController : UIViewController

@property (nonatomic) Course *course;

@property (weak, nonatomic) IBOutlet UILabel *courseId;

@property (weak, nonatomic) IBOutlet UILabel *courseName;

@property (weak, nonatomic) IBOutlet UILabel *programId;

@property (weak, nonatomic) IBOutlet UILabel *programName;

@end
