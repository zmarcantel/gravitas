//
//  GravGameViewController.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/10/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <GLKit/GLKit.h>

#import "GravGameView.h"

@interface GravGameViewController : GLKViewController

@property (weak, nonatomic) IBOutlet GravGameView *view;

@end
