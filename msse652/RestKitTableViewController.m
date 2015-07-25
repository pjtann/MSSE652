//
//  RestKitTableViewController.m
//  msse652
//
//  Created by PT on 7/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "RestKitTableViewController.h"
#import "Program.h"
#import <RestKit/RestKit.h>



@interface RestKitTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


@end

@implementation RestKitTableViewController

NSMutableArray *restKitPrograms;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (restKitPrograms == nil) {
        restKitPrograms = [[NSMutableArray alloc] init];
    }
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"name" parameters:@{@"name" : @"name"} success:nil failure:^(RKObjectRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@", error);
        
    }];
     
    self.fetchedResultsController;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSFetchedResultsController *) fetchedResultsController{
    
    if (!_fetchedResultsController) {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName: NSStringFromClass([Program class])];
        fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: @"name" ascending: YES]];
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: fetchRequest managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext sectionNameKeyPath:@"name" cacheName:@"Program"];
        self.fetchedResultsController.delegate = self;
        
        NSLog(@"sectionNameKeyPath: %@", _fetchedResultsController.sectionNameKeyPath);
        NSLog(@"cacheName: %@", _fetchedResultsController.cacheName);
        
        
        NSLog(@"fetchRequest: %@", fetchRequest);
        NSLog(@"fetchedRequestController: %@", _fetchedResultsController);
       
        [restKitPrograms addObject:_fetchedResultsController];
        NSLog(@"restKitPrograms: %@", restKitPrograms);
        
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        NSLog(@"%@", [self.fetchedResultsController fetchedObjects]);
        NSAssert(!error, @"Error performing fetch request: %@", error);
        
    }
    return _fetchedResultsController;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    NSLog(@"restKitPrograms: %@", restKitPrograms);
    NSLog(@"restKitPrograms.count: %li", restKitPrograms.count);
    
    
    return restKitPrograms.count;

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestKitPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    //cell.textLabel.text = ((Program *)[programs objectAtIndex:indexPath.row]).programName;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    
    NSLog(@"\n\n\n\n restKitProgramsAgain: %@", restKitPrograms);
    
    NSLog(@"\n indexPath: %@", indexPath);
    NSLog(@"\n fetchedResultsController again: %@", _fetchedResultsController);
    
    
    Program *restKitPrograms = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = restKitPrograms.name;
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
