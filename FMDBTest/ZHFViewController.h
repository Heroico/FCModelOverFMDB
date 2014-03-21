//
//  ZHFViewController.h
//  FMDBTest
//
//  Created by Alvaro Barbeira on 3/21/14.
//  Copyright (c) 2014 Zauber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHFViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;

- (IBAction)editButtonTapped:(id)sender;
- (IBAction)newActiontapped:(UIBarButtonItem *)sender;
@end
