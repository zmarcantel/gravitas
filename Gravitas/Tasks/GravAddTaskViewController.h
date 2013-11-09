//
//  GravAddTaskViewController.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "../GravAppDelegate.h"

#import "../UI/GravTextField.h"
#import "../Data/GravTask.h"

@interface GravAddTaskViewController : UIViewController <UITextFieldDelegate>

@property GravTask *task;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void) donePicking;

@end
