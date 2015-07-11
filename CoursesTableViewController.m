//
//  CoursesTableViewController.m
//  msse652
//
//  Created by PT on 7/10/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "CoursesTableViewController.h"
#import "Course.h"
#import "Program.h"
#import "CourseDetailViewController.h"




@interface CoursesTableViewController ()

@end

@implementation CoursesTableViewController

NSMutableArray *courses;

NSXMLParser *xmlParser;

NSString *currentElement;
int currentIdent;
NSString *currentName;

Course *currentCourse;
Program *currentProgram;

Course *selectedCourse;




- (void)viewDidLoad {
    [super viewDidLoad];

    if (courses == nil) {
        courses = [[NSMutableArray alloc] init];
    }
    
    
    [self downloadCourses];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    
    return courses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SCISCoursePrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = ((Course *)[courses objectAtIndex:indexPath.row]).courseName;
    cell.detailTextLabel.text = ((Program *)((Course *)[courses objectAtIndex:indexPath.row]).programName).programName;
    
    return cell;
}




#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segueToCourseDetail"]){
        CourseDetailViewController *destination = segue.destinationViewController;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        destination.course = [courses objectAtIndex:path.row];
    }
}

-(void) downloadCourses {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        if (error) {
            NSLog(@"Error: %@", error);
            
        }
        
        NSString *URLString = [NSString stringWithFormat:@"http://regisscis.net/Regis2/webresources/regis2.course"];
        NSURL *url = [NSURL URLWithString:URLString];
        
        xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        [xmlParser setDelegate:self];
        
        [xmlParser parse];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    });
}

#pragma mark - NSXMLParserDelegate

-(void) parserDidStartDocument:(NSXMLParser *)parser {
    [courses removeAllObjects];
    currentCourse = nil;
    currentProgram = nil;
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    

    
    if ([elementName isEqualToString:@"course"]) {
        currentCourse = [[Course alloc] init];
    } else if ([elementName isEqualToString:@"pid"]) {
        currentProgram = [[Program alloc] init];
    }
    
    currentElement = [[NSString alloc] initWithString:elementName];
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    

    
    if ([elementName isEqualToString:@"course"]) {
        
        [courses addObject:currentCourse];
        currentCourse = nil;
        
    } else if ([elementName isEqualToString:@"id"]){
        
        if (currentProgram != nil) {
            currentProgram.programId = currentIdent;
        } else {
            currentCourse.courseId = currentIdent;
        }
        
    } else if ([elementName isEqualToString:@"name"]){
        
        if (currentProgram != nil) {
            currentProgram.programName = [[NSString alloc] initWithString:currentName];
        } else {
            currentCourse.courseName = [[NSString alloc] initWithString:currentName];
        }
        
    } else if ([elementName isEqualToString:@"pid"]) {
        currentCourse.programName = currentProgram;
        currentProgram = nil;
    }
    
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // Store the found characters if only we're interested in the current element.
    if ([currentElement isEqualToString:@"id"]) {
        currentIdent = [string intValue];
    } else if ([currentElement isEqualToString:@"name"]) {
        currentName = string;
    }
}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"XML Parsing Error: %@", parseError);
}





@end
