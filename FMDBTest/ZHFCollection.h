//
//  ZHFModel.h
//  FMDBTest
//
//  Created by Alvaro Barbeira on 3/21/14.
//  Copyright (c) 2014 Zauber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCModel.h"

@interface ZHFCollection : FCModel
// table
@property (nonatomic, assign) int64_t id;
@property (nonatomic, copy) NSString *name;

// non table
- (NSArray *)members;

@end
