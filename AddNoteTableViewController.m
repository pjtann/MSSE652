//
//  AddNoteTableViewController.m
//  msse652
//
//  Created by PT on 8/5/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AddNoteTableViewController.h"

@interface AddNoteTableViewController ()

@end

@implementation AddNoteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// send the notification of a new note to have the table controller list it and save to cloud
- (IBAction)save:(id)sender {
    // Notify the previouse view to save the changes locally
    [[NSNotificationCenter defaultCenter] postNotificationName:@"New Note" object:self userInfo:[NSDictionary dictionaryWithObject:self.noteTextField.text forKey:@"Note"]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
