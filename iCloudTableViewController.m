//
//  iCloudTableViewController.m
//  msse652
//
//  Created by PT on 7/31/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "iCloudTableViewController.h"
#import "Note.h"
#import "ShowNoteViewController.h"


@interface iCloudTableViewController ()

@property UITextField *noteTextField;

@end

@implementation iCloudTableViewController

NSMutableArray *notes;
NSString *noteStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (notes == nil) {
        notes = [[NSMutableArray alloc] init];
    }
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.leftItemsSupplementBackButton = YES;
  
    // observer to catch changes from iCloud
    NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
    // register for notification of changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeDidChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:store];
    
    // synchronize method called to get fresh copy of key-value pair from iCloud so we start off with all the latest available notes
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    
    //observer to catch local changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddNewNote:) name:@"New Note" object:nil];
    
}

// invoked when a user adds a new note
- (void)didAddNewNote:(NSNotification *)notification
{
    // retreive the note
    NSDictionary *userInfo = [notification userInfo];
    NSString *noteStr = [userInfo valueForKey:@"Note"];
    // add to local array
    NSLog(@"noteStr: %@", noteStr);
    
    [self.notes addObject:noteStr];
    
    // Update data on the iCloud
    [[NSUbiquitousKeyValueStore defaultStore] setArray:self.notes forKey:@"AVAILABLE_NOTES"];
    
    // Reload the table view to show changes
    [self.tableView reloadData];
}

// called when data is changed in the cloud
- (void)storeDidChange:(NSNotification *)notification
{
    // Retrieve the changes from iCloud and add to local array
    _notes = [[[NSUbiquitousKeyValueStore defaultStore] arrayForKey:@"AVAILABLE_NOTES"] mutableCopy];
    
    // Reload the table view to show changes
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *) notes{
    if (_notes){
        NSLog(@"notes in notes method: %@", _notes);
        return _notes;

    }
    _notes = [[[NSUbiquitousKeyValueStore defaultStore]arrayForKey:@"AVAILABLE_NOTES"] mutableCopy];
    if (!_notes) _notes = [NSMutableArray array];
    NSLog(@"notes inside ! if notes method: %@", _notes);
    return _notes;
    

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.notes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"iCloudPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *note = [self.notes objectAtIndex:indexPath.row];
    [cell.textLabel setText:note];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // remove object note from local array
        [self.notes removeObjectAtIndex:indexPath.row];
        // remove object note from table
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        // resubmit the local array back to the cloud to reflect the changes
        [[NSUbiquitousKeyValueStore defaultStore] setArray:self.notes forKey:@"AVAILABLE_NOTES"];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"prepareForSeque %@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"segueFromiCloudTableToShowNote"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     
        Note *showTheNote = [[Note alloc] init];
        showTheNote.myNote = @"Test note.";
        NSLog(@"showTheNote after alloc and assignment: %@", showTheNote);
        NSLog(@"showTheNote.myNote after alloc and assignment: %@", showTheNote.myNote);
        
        
        Note *showNote = [[Note alloc] init];
        showNote.myNote = _notes[indexPath.row];
        //showNote.myNote = @"This is my note.";
        
        
        NSLog(@"\n _notes: %@", _notes);
        NSLog(@"\n showNote: %@", showNote);

        
        
        // the detail view needs the note
        
        //[[segue destinationViewController] setService:_service];
        NSLog(@"\n showNote with mynote property: %@", showNote.myNote);

        
        [[segue destinationViewController] setDetailNote:showNote];
        NSLog(@"showNote at end of segue method: %@", showNote);
        
    }
}

@end
