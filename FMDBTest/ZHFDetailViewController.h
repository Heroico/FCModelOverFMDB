//
//  ZHFDetailViewController.h
//  FMDBTest
//
//  Created by Alvaro Barbeira on 3/21/14.
//  Copyright (c) 2014 Zauber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHFCollection;

@interface ZHFDetailViewController : UIViewController
@property(nonatomic, strong) ZHFCollection *collection;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)newMemberTapped:(id)sender;
@end
