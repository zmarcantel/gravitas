//
//  GravTableViewCell.h
//  Gravitas
//
//  Created by Zachary Marcantel on 11/7/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../MSCMoreOptionTableViewCell/MSCMoreOptionTableViewCell/MSCMoreOptionTableViewCell.h"

@interface GravTableViewCell : MSCMoreOptionTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleField;
@property (weak, nonatomic) IBOutlet UILabel *dueDateField;

@end
