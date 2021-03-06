//
//  ZHFFMDBQueue.h
//  FMDBTest
//
//  Created by Alvaro Barbeira on 3/21/14.
//  Copyright (c) 2014 Zauber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDatabaseQueue.h>

@interface ZHFFMDBQueue : FMDatabaseQueue

// table
@property (nonatomic, assign) int64_t id;
@property (nonatomic, copy) NSString *name;

// non table

@end
