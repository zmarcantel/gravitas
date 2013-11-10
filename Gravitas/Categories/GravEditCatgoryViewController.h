//
//  GravEditCatgoryViewController.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/9/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "../GravAppDelegate.h"

#import "../UI/GravTextField.h"
#import "../Data/GravCategory.h"

@interface GravEditCatgoryViewController : UIViewController

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property GravCategory *editingCategory;

@end
