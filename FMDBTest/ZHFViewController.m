//
//  ZHFViewController.m
//  FMDBTest
//
//  Created by Alvaro Barbeira on 3/21/14.
//  Copyright (c) 2014 Zauber. All rights reserved.
//

#import <PSAlertView/PSPDFAlertView.h>
#import "ZHFViewController.h"
#import "ZHFCollection.h"
#import "ZHFDetailViewController.h"

@interface ZHFViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSArray *collections;
@end

@implementation ZHFViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.collections = [ZHFCollection allInstances];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSIndexPath *selected = [self.tableview indexPathForSelectedRow];
    if (selected) {
        [self.tableview deselectRowAtIndexPath:selected animated:NO];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CollectionToMemberSegueIdentifier"]) {
        NSIndexPath *selected = [self.tableview indexPathForSelectedRow];
        ZHFCollection *collection = self.collections[selected.row];
        ZHFDetailViewController *destination = segue.destinationViewController;
        destination.collection = collection;
    }
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ZHFCollection *collection = self.collections[indexPath.row];
        NSMutableArray *collections = [NSMutableArray arrayWithArray:self.collections];
        [collections removeObject:collection];
        self.collections = [NSArray arrayWithArray:collections];
        [collection delete];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - UIInteraction

- (IBAction)editButtonTapped:(id)sender {
    self.tableview.editing = !self.tableview.editing;
}

- (IBAction)newActiontapped:(UIBarButtonItem *)sender {
    PSPDFAlertView *alertView = [[PSPDFAlertView alloc] initWithTitle:@"New Collection name"];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView setCancelButtonWithTitle:@"Cancel" block:nil];
    
    __weak ZHFViewController *weakSelf = self;
    __weak PSPDFAlertView *weakAlertView = alertView;
    [alertView addButtonWithTitle:@"Create" block:^{
        NSString *name = [[weakAlertView textFieldAtIndex:0] text];
        [weakSelf createCollectionWithName:name];
    }];
    [alertView show];
}

#pragma mark - private methods

- (void)createCollectionWithName:(NSString *)name {
    ZHFCollection *collection = [ZHFCollection new];
    collection.name = name;
    [collection save];
    self.collections = [self.collections arrayByAddingObject:collection];
    [self.tableview reloadData];
}

@end

