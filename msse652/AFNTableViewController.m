//
//  AFNTableViewController.m
//  msse652
//
//  Created by PT on 7/15/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AFNTableViewController.h"
#import "AFNetworking.h"
#import "Program.h"
#import "Course.h"

// adding another comment just to see if we can get all the files up to GitHub
@interface AFNTableViewController ()

@property(nonatomic, strong) NSMutableDictionary *currentDictionary;   // current section being parsed
@property(nonatomic, strong) NSMutableDictionary *xmlPrograms;       // completed parsed xml response
@property(nonatomic, strong) NSString *elementName;
@property(nonatomic, strong) NSMutableString *outstring;
@property(strong) NSDictionary *programs;

@end

@implementation AFNTableViewController

//NSMutableData *responseData;
NSMutableArray *progs;
NSMutableArray *cours;
NSString *currentElementAFN;
int currentIdentAFN;
NSString *currentNameAFN;
Course *currentCourseAFN;
Program *currentProgramAFN;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (progs == nil) {
        progs = [[NSMutableArray alloc] init];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self downloadAFN];
    
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
    
    return progs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AFNPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = ((Program *)[progs objectAtIndex:indexPath.row]).programName;
    cell.detailTextLabel.text = ((Program *)((Course *)[cours objectAtIndex:indexPath.row]).programName).programName;
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

-(void) downloadAFN {

    NSString *URLString = [NSString stringWithFormat:@"http://regisscis.net/Regis2/webresources/regis2.program"];
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation
                                               , id responseObject) {
        NSXMLParser *XMLParser = (NSXMLParser *) responseObject;
        [XMLParser setShouldProcessNamespaces:YES];
        XMLParser.delegate = self;
        [XMLParser parse];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
            message:[error localizedDescription]
            delegate:nil
            cancelButtonTitle:@"Ok"
            otherButtonTitles:nil];
        [alertView show];
       
    }];
    
    [operation start];
    
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.xmlPrograms = [NSMutableDictionary dictionary];
    [cours removeAllObjects];
    currentCourseAFN = nil;
    currentProgramAFN = nil;
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.elementName = qName;
    
    if([elementName isEqualToString:@"course"]){
        currentCourseAFN = [[Course alloc] init];
        
    }else if ([elementName isEqualToString:@"program"]){
        currentProgramAFN = [[Program alloc]init];
    }
    {
    self.currentDictionary = [NSMutableDictionary dictionary];
    }

    self.outstring = [NSMutableString string];
    
    currentElementAFN = [[NSString alloc] initWithString:elementName];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{

    if ([elementName isEqualToString:@"program"]) {
        [progs addObject:currentProgramAFN];
        currentProgramAFN = nil;
        
    } else if ([elementName isEqualToString:@"id"]){

        if (currentProgramAFN != nil) {
            currentProgramAFN.programId = currentIdentAFN;
        } else {
            currentCourseAFN.courseId = currentIdentAFN;
        }
        
    } else if ([elementName isEqualToString:@"name"]){
        
        if (currentProgramAFN != nil) {
            currentProgramAFN.programName = [[NSString alloc] initWithString:currentNameAFN];
        } else {
            currentCourseAFN.courseName = [[NSString alloc] initWithString:currentNameAFN];
        }
        
    } else if ([elementName isEqualToString:@"pid"]) {

        currentCourseAFN.programName = currentProgramAFN;
        currentProgramAFN = nil;
    }
    
}
    
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!self.elementName)
        return;
    if ([currentElementAFN isEqualToString:@"id"]) {
        currentIdentAFN = [string intValue];
    } else if ([currentElementAFN isEqualToString:@"name"]) {
        currentNameAFN = string;
    }
    
    [self.outstring appendFormat:@"%@", string];
    
}
    
- (void) parserDidEndDocument:(NSXMLParser *)parser
{
    self.programs = @{@"data": self.xmlPrograms};
    self.title = @"XML via AFN";
    [self.tableView reloadData];
    
}

@end
