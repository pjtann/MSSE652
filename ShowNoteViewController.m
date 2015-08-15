//
//  ShowNoteViewController.m
//  msse652
//
//  Created by PT on 8/5/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "ShowNoteViewController.h"
#import "Note.h"


@interface ShowNoteViewController ()

@end

@implementation ShowNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configureView{
    
    if (_detailNote) {
        Note *displayNote = self.detailNote;
        
        //NSLog(@"displayNote.myNote: %@", displayNote.myNote);
        self.showNoteTextView.text = displayNote.myNote;
        //NSLog(@"displayNote.myNote: %@", displayNote.myNote);
        
        NSLog(@"showNoteTextView.text: %@", _showNoteTextView.text);
        
    }
}

-(void) setDetailNote:(id)newDetailNote{
    if(_detailNote != newDetailNote){
        _detailNote = newDetailNote;
        
        NSLog(@"newDetailNote: %@", newDetailNote);
        NSLog(@"_detailNote: %@", _detailNote);
        
        
        
        [self configureView];
        
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

@end
