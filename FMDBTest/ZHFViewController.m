//
//  ZHFViewController.m
//  FMDBTest
//
//  Created by Alvaro Barbeira on 3/21/14.
//  Copyright (c) 2014 Zauber. All rights reserved.
//

#import "ZHFViewController.h"
#import "ZHFCollection.h"

@interface ZHFViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSArray *collections;
@end

@implementation ZHFViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.collections = [ZHFCollection allInstances];
}

#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHFCollection *collection = self.collections[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCell"];
    cell.textLabel.text = collection.name;
    return cell;
}

@end
