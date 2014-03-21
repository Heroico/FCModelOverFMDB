//
//  SCFileManager.m
//  InsightNotes
//
//  Created by Alvaro Barbeira on 10/10/13.
//  Copyright (c) 2013 Zauber. All rights reserved.
//

#import "ZHFFileManager.h"

@interface ZHFFIleManager
- (BOOL)pathIsDirectory:(NSString *)path;
- (NSURL *)urlForPath:(NSString *)path;
@end

@implementation ZHFFileManager

+ (ZHFFileManager *)newManager {
    return [[ZHFFileManager alloc] init];
}

- (NSString *)createDirectoryAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = YES;
    NSString *directory = [self  fullPath:path];
    // The NSFileManager message for -getting if a file exists and is a directory-
    // was not used so that we could stub it for testing
    BOOL exist = [fileManager fileExistsAtPath:directory];
    BOOL isDirectory = [self pathIsDirectory:directory];
    if (exist && isDirectory) {
        return directory;
    }
    
    if (exist && !isDirectory) {
        DDLogError(@"Path: %@ exists but is not a directory", directory);
        return nil;
    }
    
    NSError *error;
    success = [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (!success) {
        DDLogError(@"Could not create directory %@. Error: %@", directory, error);
        return nil;
    }
    
    error = nil;
    NSURL *url = [self urlForPath:path];
    success = [url setResourceValue: [NSNumber numberWithBool: YES] forKey: NSURLIsExcludedFromBackupKey error: &error];
    if (!success) {
        DDLogError(@"Could not exclude %@ from iTunes backup, error :%@",directory, error);
        [self removeDirectoryAtPath:directory];
    }

    return success ? directory : nil;
}

- (void)removeDirectoryAtPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    // The NSFileManager message for -getting if a file exists and is a directory-
    // was not used so that we could stub it for testing
    BOOL exists = [manager fileExistsAtPath:path];
    if (exists) {
        BOOL isDirectory = [self pathIsDirectory:path];
        if (isDirectory) {
            NSError *error = nil;
            BOOL success = [manager removeItemAtPath:path error:&error];
            if (!success) {
                DDLogError(@"Error removing directory: %@",error);
            }
        } else {
            DDLogError(@"Will not remove at path:%@ as it is a directory", path);
        }
    }
}

- (BOOL)removeItemAtManagedPath:(NSString *)path error:(NSError **)error {
    BOOL rvalue = NO;
    NSString *fullPath = [self fullPath:path];
    NSFileManager *manager = [NSFileManager defaultManager];
    // The NSFileManager message for -getting if a file exists and is a directory-
    // was not used so that we could stub it for testing
    BOOL exists = [manager fileExistsAtPath:fullPath];
    if (exists) {
        rvalue = [manager removeItemAtPath:fullPath error:error];
    } else {
        rvalue = YES;
    }
    return rvalue;
}

- (NSString *)pathForFilename:(NSString *)fileName atPath:(NSString *)path {
    NSString *basePath = [self fullPath:path];
    NSString *filePath = [basePath stringByAppendingPathComponent:fileName];
    return filePath;
}

- (NSString *)fullPath:(NSString *)path {
    NSArray *paths = [self searchPaths];
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [[libraryDirectory stringByAppendingPathComponent:@"Data"] stringByAppendingPathComponent:path];
    return fullPath;
}

- (BOOL)itemExistsAtManagedPath:(NSString *)path {
    NSString *fullPath = [self fullPath:path];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL exists = [manager fileExistsAtPath:fullPath];
    return exists;
}

#pragma mark - Private utility methods

// The following method is "coupled" to the fullPath method.
- (NSURL *)urlForPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSURL *url = [fileManager URLForDirectory:NSLibraryDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:&error];
    if (error) {
        DDLogError(@"Could not create url for library: %@", error);
    }
    NSURL *urlInDataFolder = [[url URLByAppendingPathComponent:@"Data"] URLByAppendingPathComponent:path];
    return urlInDataFolder;
}

- (NSArray *)searchPaths {
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
}

- (BOOL)pathIsDirectory:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = false;
    BOOL exist = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    return exist && isDirectory;
}

@end
