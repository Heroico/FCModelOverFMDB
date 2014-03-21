//
//  ZHFMember.m
//  FMDBTest
//
//  Created by Alvaro Barbeira on 3/21/14.
//  Copyright (c) 2014 Zauber. All rights reserved.
//

#import "ZHFMember.h"
#import "FCModel+Private.h"
#import "ZHFCollection.h"

@implementation ZHFMember

+ (id)newWithParentCollection:(ZHFCollection *)collection {
    ZHFMember *member = [[self alloc] initWithFieldValues:@{@"parent_id":@(collection.id)} existsInDatabaseAlready:NO];
    return member;
}

- (ZHFCollection *)parentCollection {
    return [ZHFCollection instanceWithPrimaryKey:@(self.parent_id)];
}

@end
