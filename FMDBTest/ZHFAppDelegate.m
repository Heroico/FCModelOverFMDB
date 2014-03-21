//
//  ZHFAppDelegate.m
//  FMDBTest
//
//  Created by Alvaro Barbeira on 3/21/14.
//  Copyright (c) 2014 Zauber. All rights reserved.
//

#import "ZHFAppDelegate.h"
#import <CocoaLumberjack/DDASLLogger.h>
#import <CocoaLumberjack/DDTTYLogger.h>
#import "FCModel.h"
#import "ZHFFileManager.h"

@implementation ZHFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    ZHFFileManager *fileManager = [ZHFFileManager newManager];
    //hack
    if (![fileManager itemExistsAtManagedPath:@"test"]) {
        [fileManager createDirectoryAtPath:@"test"];
    }
    
    NSString *dbPath = [fileManager pathForFilename:@"db" atPath:@"test"];
    [FCModel openDatabaseAtPath:dbPath key:@"secret" withSchemaBuilder:^(FMDatabase *db, int *schemaVersion) {

        db.traceExecution = YES; // Log every query (useful to learn what FCModel is doing or analyze performance)
        [db beginTransaction];
        
        void (^failedAt)(int statement) = ^(int statement){
            int lastErrorCode = db.lastErrorCode;
            NSString *lastErrorMessage = db.lastErrorMessage;
            [db rollback];
            NSAssert3(0, @"Migration statement %d failed, code %d: %@", statement, lastErrorCode, lastErrorMessage);
        };
        
        if (*schemaVersion < 1) {
            if (! [db executeUpdate:
                   @"CREATE TABLE ZHFCollection ("
                   @"    id           INTEGER PRIMARY KEY AUTOINCREMENT," // Autoincrement is optional. Just demonstrating that it works.
                   @"    name         TEXT NOT NULL"
                   @");"
                   ]) failedAt(1);
            
            if (! [db executeUpdate:
                   @"CREATE TABLE ZHFMember ("
                   @"    id           INTEGER PRIMARY KEY AUTOINCREMENT,"
                   @"    name         TEXT NOT NULL,"
                   @"    parent_id    INTEGER NOT NULL,"
                   @"    FOREIGN KEY(parent_id) REFERENCES Collection(id)"
                   @");"
                   ]) failedAt(2);
            
            // Create any other tables...
            
            *schemaVersion = 1;
        }
        
        // If you wanted to change the schema in a later app version, you'd add something like this here:
        /*
         if (*schemaVersion < 2) {
         if (! [db executeUpdate:@"ALTER TABLE Person ADD COLUMN lastModified INTEGER NULL"]) failedAt(3);
         *schemaVersion = 2;
         }
         */
        
        [db commit];
    }];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
