//
//  SocketViewController.h
//  msse652
//
//  Created by PT on 8/12/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocketViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *socketStatusLabel;

@property (weak, nonatomic) IBOutlet UITextField *sendMessageTextField;


@property (weak, nonatomic) IBOutlet UITextView *recieveMessageTextView;

- (IBAction)openConnectionButtonAction:(id)sender;

- (IBAction)sendMessageButtonAction:(id)sender;

@end
