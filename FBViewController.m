//
//  FBViewController.m
//  msse652
//
//  Created by PT on 7/28/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "FBViewController.h"
#import <Social/Social.h>


@interface FBViewController ()

@property(nonatomic, copy) SLComposeViewControllerCompletionHandler completionHandler;

@end

@implementation FBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self displayFB];

    //[self performSegueWithIdentifier:@"segueFromFBToTab" sender:self];
}

-(void) displayFB{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *view = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
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
        NSLog(@"Facebook Service NOT Available.");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OOOOOOPS!!" message:@"Facebook Service \n Not Available" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        
        [alertView show];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// //In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     //Get the new view controller using [segue destinationViewController].
//     //Pass the selected object to the new view controller.

-(void) viewWillAppear:(BOOL)animated{
    //[self viewDidLoad];
    [self displayFB];
}



@end
