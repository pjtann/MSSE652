//
//  AppDelegate.m
//  msse652
//
//  Created by PT on 6/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AppDelegate.h"
#import "Program.h"
#import <RestKit/RestKit.h>



@interface AppDelegate ()

//@property (strong) RKManagedObjectStore *managedObjectStore;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // call method to initialize the RestKit
    [self initializeRestKit];

    return YES;
}
// method to initialize the RestKit
-(void) initializeRestKit{
    
    // initialize the object manager with remote file
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL: [NSURL URLWithString:@"http://regisscis.net/Regis2/webresources/regis2.program"]];
    
    [manager.HTTPClient setDefaultHeader:@"GET" value:@"application/json"];

    
    // unremark below to test with local file instead of remote
    //RKObjectManager *manager = [RKObjectManager managerWithBaseURL: [NSURL URLWithString:@"http:////Users/PT/Documents/Development/Regis/MSSE-652/Projects/msse652/ProgramData"]];

    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    manager.managedObjectStore = managedObjectStore;
    
    // create a map for the Program class
    RKEntityMapping *programMapping = [RKEntityMapping mappingForEntityForName: NSStringFromClass([Program class]) inManagedObjectStore:manager.managedObjectStore];
    // the unique identifier attribute
    programMapping.identificationAttributes = @[@"id"];
    // all other attributes - format: JSON attribute: entity attribute
    [programMapping addAttributeMappingsFromDictionary:@{@"id" : @"id" , @"name" : @"name"}];
    
    // create the persistence store (mysqlite)
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent: @"SCIS.sqlite"];
    NSError *error;
    NSPersistentStore *persistenceStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath: nil withConfiguration:nil options: @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption: @YES} error:&error];
    [managedObjectStore createManagedObjectContexts];
    
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    // dump file path to log if needed for troubleshooting
    //NSLog(@"\n StorePath: %@", storePath);
    
    
    //****************************************************
    
    // added
    RKResponseDescriptor *ProgramDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:programMapping method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // create URL request and set it up for JSON
    NSURL *url = [NSURL URLWithString:@"http://regisscis.net/Regis2/webresources/regis2.program"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // map Program entities
    RKManagedObjectRequestOperation *managedObjectRequestOperation = [[RKManagedObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ProgramDescriptor]];
    managedObjectRequestOperation.managedObjectContext = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    managedObjectRequestOperation.managedObjectCache = [RKManagedObjectStore defaultStore].managedObjectCache;
    [manager enqueueObjectRequestOperation:managedObjectRequestOperation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
