//
//  GravTaskTableViewController.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "../Data/Task.h"
#import "GravAddTaskViewController.h"

@interface GravTaskTableViewController : UITableViewController

@property NSArray *tasks;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
