//
//  SocketViewController.m
//  msse652
//
//  Created by PT on 8/12/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "SocketViewController.h"
#import "SocketSvc.h"


@interface SocketViewController ()

@end

@implementation SocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
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

// OPEN connection button
- (IBAction)openConnectionButtonAction:(id)sender {
    [SocketSvc connect];
   
}

// SEND button
- (IBAction)sendMessageButtonAction:(id)sender {
    [SocketSvc send:self.sendMessageTextField.text];
    [SocketSvc recieve];
    
}
@end
