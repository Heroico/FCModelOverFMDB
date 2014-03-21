//
//  ZHFMember.h
//  FMDBTest
//
//  Created by Alvaro Barbeira on 3/21/14.
//  Copyright (c) 2014 Zauber. All rights reserved.
//

#import "FCModel.h"

@class ZHFCollection;

@interface ZHFMember : FCModel
+ (id)newWithParentCollection:(ZHFCollection *)collection;

// table
@property (nonatomic, assign) int64_t id;
@property (nonatomic, assign) int64_t parent_id;
@property (nonatomic, copy) NSString *name;

// non table
- (ZHFCollection *)parentCollection;
@end
