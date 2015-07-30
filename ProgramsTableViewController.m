//
//  ProgramsTableViewController.m
//  msse652
//
//  Created by PT on 7/10/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "ProgramsTableViewController.h"
#import "Program.h"
#import "Pgm.h"



@interface ProgramsTableViewController ()


@end

@implementation ProgramsTableViewController

NSMutableData *responseData;
NSMutableArray *programs;

- (void)viewDidLoad {
    [super viewDidLoad];

    if (programs == nil) {
        programs = [[NSMutableArray alloc] init];
    }
   
    [self downloadProgramXMLData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) downloadProgramXMLData{

    // converting from XML format
    NSString *URLString = [NSString stringWithFormat:@"http://regisscis.net/Regis2/webresources/regis2.program"];
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];

    
    
}
#pragma mark - NSURLConnectionDelegate / NSURLConnectionDataDelegate
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *response = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    //NSLog(@"JSON Response: %@", response); // only for logging and debugging

    [programs removeAllObjects];
    
    NSError *error = nil;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:responseData
                                                     options:kNilOptions
                                                       error:&error];
    
    for (int i = 0; i <array.count; i++) {
        NSString *item = array[i];
        
        NSDictionary *programDict = array[i];
        Pgm *pgm = [[Pgm alloc]init];
        for (id key in programDict) {
            id value = [programDict objectForKey:key];
            if ([key isEqualToString:@"id"]) {
                pgm.pgmId = [value intValue];
            } else if ([key isEqualToString:@"name"]) {
                pgm.pgmName = value;
            }
        }
        
        [programs addObject:pgm];

        
    }
    
    [self.tableView reloadData];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"NSURLConnection Error: %@", error);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return programs.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SCISProgramsPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
  
    cell.textLabel.text = ((Pgm *)[programs objectAtIndex:indexPath.row]).pgmName;

    
    return cell;
}

@end
