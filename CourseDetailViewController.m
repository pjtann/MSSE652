//
//  CourseDetailViewController.m
//  msse652
//
//  Created by PT on 7/11/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "CourseDetailViewController.h"

@interface CourseDetailViewController ()

@end

@implementation CourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.courseId.text = [NSString stringWithFormat:@"%d", self.course.courseId];
    self.courseName.text = self.course.courseName;
    self.programId.text = [NSString stringWithFormat:@"%d", self.course.programName.programId];
    self.programName.text = self.course.programName.programName;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
