//
//  ZHFDetailViewController.m
//  FMDBTest
//
//  Created by Alvaro Barbeira on 3/21/14.
//  Copyright (c) 2014 Zauber. All rights reserved.
//

#import <PSPDFAlertView.h>
#import "ZHFDetailViewController.h"
#import "ZHFCollection.h"
#import "ZHFMember.h"

@interface ZHFDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ZHFDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collection.members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHFMember *member = self.collection.members[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberCell"];
    cell.textLabel.text = member.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ZHFMember *member = self.collection.members[indexPath.row];
        [member delete];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - UIInteraction

- (IBAction)newMemberTapped:(id)sender {
    PSPDFAlertView *alertView = [[PSPDFAlertView alloc] initWithTitle:@"New Member name"];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView setCancelButtonWithTitle:@"Cancel" block:nil];
    
    __weak ZHFDetailViewController *weakSelf = self;
    __weak PSPDFAlertView *weakAlertView = alertView;
    [alertView addButtonWithTitle:@"Create" block:^{
        NSString *name = [[weakAlertView textFieldAtIndex:0] text];
        [weakSelf createMemberWithName:name];
    }];
    [alertView show];
}

#pragma mark - private methods

- (void)createMemberWithName:(NSString *)name {
    ZHFMember *member = [ZHFMember newWithParentCollection:self.collection];
    member.name = name;
    [member save];
    [self.tableView reloadData];
}


@end
