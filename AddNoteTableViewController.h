//
//  AddNoteTableViewController.h
//  msse652
//
//  Created by PT on 8/5/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNoteTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *notes;

-(IBAction)cancel:(id)sender;
-(IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
//@property (weak, nonatomic) IBOutlet UITextView *noteTextField;


@end
