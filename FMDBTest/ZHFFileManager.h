//
//  SCFileManager.h
//  InsightNotes
//
//  Created by Alvaro Barbeira on 10/10/13.
//  Copyright (c) 2013 Zauber. All rights reserved.
//

#import <Foundation/Foundation.h>

// TODO add nserror handling (or reporting)

/**
 * This class makes a little bit of abstraction to the underlying file system.
 * All paths are considered relative to the app's documents folder.
 * Pass them without leading slash.
 * That is, "folder" (instead of "/folder") as argument,
 * will be used to refer to something like /ugly/ios/path/to/app/Library/Data/folder
 */
@interface ZHFFileManager : NSObject

+ (ZHFFileManager *)newManager;

- (NSString *)createDirectoryAtPath:(NSString *)path;

- (void)removeDirectoryAtPath:(NSString *)path;

- (BOOL)removeItemAtManagedPath:(NSString *)path error:(NSError **)error;

/// Will convert an argument like "item" to "/ugly/ios/path/to/app/Library/data/item"
- (NSString *)fullPath:(NSString *)path;

- (NSString *)pathForFilename:(NSString *)fileName atPath:(NSString *)path;

// Use an argument like "folder" to refer to /ugly/ios/path/to/app/Library/data/folder
- (BOOL)itemExistsAtManagedPath:(NSString *)path;

@end
