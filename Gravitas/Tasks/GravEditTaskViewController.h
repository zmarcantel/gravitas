//
//  GravEditTaskViewController.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/9/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "../GravAppDelegate.h"

#import "../Data/GravTask.h"
#import "../UI/GravTextField.h"
#import "GravTaskTableViewController.h"

@interface GravEditTaskViewController : UIViewController

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property GravTask *editingTask;

@end
