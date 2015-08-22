//
//  SocketRocketViewController.h
//  msse652
//
//  Created by PT on 8/18/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SocketRocketViewController : UIViewController


//@property (weak, nonatomic) IBOutlet UIButton *sendMessageActionButton;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UILabel *rocketStatusLabel;

@property (weak, nonatomic) IBOutlet UITextField *sendRocketMessageTextField;


@property (weak, nonatomic) IBOutlet UITextView *recieveRocketMessageTextView;



@end
