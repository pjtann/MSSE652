//
//  TWViewController.m
//  msse652
//
//  Created by PT on 7/28/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "TWViewController.h"
#import <Social/Social.h>


@interface TWViewController ()

@end

@implementation TWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
//    {
//        SLComposeViewController *view = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
//        [self presentViewController:view animated:YES completion:nil];
//    } else {
//        // display an alert to the user
//        NSLog(@"Twitter Service NOT Available.");
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OOOOOOPS!!" message:@"Twitter Service \n Not Available" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//        
//        [alertView show];
//        
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) displayTW{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *view = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [self presentViewController:view animated:YES completion:nil];
        
        view.completionHandler = ^(SLComposeViewControllerResult result){
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"User hit cancel.");
                    
                    // move to first tab, but still doesn't reset the FB tab
                    //self.tabBarController.selectedIndex = 0;
                    
                    
                    
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"User hit the send.");
                default:
                    break;
            }
        };
        
    } else {
        // display an alert to the user
        NSLog(@"Twitter Service NOT Available.");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OOOOOOPS!!" message:@"Twitter Service \n Not Available" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        
        [alertView show];
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) viewWillAppear:(BOOL)animated{
    //[self viewDidLoad];
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
//    {
//        SLComposeViewController *view = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
//        [self presentViewController:view animated:YES completion:nil];
//    } else {
//        // display an alert to the user
//        NSLog(@"Twitter Service NOT Available.");
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OOOOOOPS!!" message:@"Twitter Service \n Not Available" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//        
//        [alertView show];
//        
//    }
    [self displayTW];
    
}


@end
