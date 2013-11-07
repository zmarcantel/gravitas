//
//  GravAddTaskViewController.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "../GravAppDelegate.h"

#import "../Data/Task.h"

@interface GravAddTaskViewController : UIViewController

@property Task *task;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
