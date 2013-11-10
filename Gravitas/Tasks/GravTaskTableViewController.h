//
//  GravTaskTableViewController.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "../Data/GravTask.h"
#import "GravTableViewCell.h"
#import "GravAddTaskViewController.h"

@interface GravTaskTableViewController : UITableViewController

@property NSArray *tasks;
@property GravTask *selectedTask;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction) updateTaskList;

@end
