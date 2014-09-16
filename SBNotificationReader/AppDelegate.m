//
//  AppDelegate.m
//  Shazam Desktop Scrobbler
//
//  Created by Stéphane Bruckert on 20/08/14.
//  Copyright (c) 2014 Stéphane Bruckert. All rights reserved.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *pathToNCSupport = [@"~/Library/Application Support/NotificationCenter/" stringByExpandingTildeInPath];
    NSError *error = nil;
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathToNCSupport error:&error];    //find the db
    
    FMDatabase *database = nil;
    for (NSString *child in contents) {
        if([child.pathExtension isEqualToString:@"db"]) {
            database = [FMDatabase databaseWithPath:[pathToNCSupport stringByAppendingPathComponent:child]];
            if([database open]) {
                printf("hi");
                [database close];
                break;
            }
        }
    }
    
    if([database open]) {
        FMResultSet *rs = [database executeQuery:@"select count(*) as cnt from presented_notifications"];
        while ([rs next]) {
            int cnt = [rs intForColumn:@"cnt"];
            NSLog(@"Total Records :%d", cnt);
        }
        
        [database close];
    }
    
}

@end
