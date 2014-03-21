//
//  ZHFModel.m
//  FMDBTest
//
//  Created by Alvaro Barbeira on 3/21/14.
//  Copyright (c) 2014 Zauber. All rights reserved.
//

#import "ZHFCollection.h"
#import "ZHFMember.h"
#import <FMDB/FMDatabase.h>
#import <FMDB/FMDatabaseQueue.h>

@implementation ZHFCollection

- (NSArray *)members {
    return [ZHFMember instancesWhere:[NSString stringWithFormat:@"parent_id = %lld", self.id]];
}

@end
