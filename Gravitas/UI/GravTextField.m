//
//  GravTextField.m
//  Gravitas
//
//  Created by Zachary Marcantel on 11/8/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import "GravTextField.h"

@implementation GravTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    UIColor *colour = [UIColor blackColor];
    NSDictionary *attributes = @{NSForegroundColorAttributeName: colour, NSFontAttributeName: self.font};
    CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
    [self.placeholder drawAtPoint:CGPointMake((rect.size.width/2)-boundingRect.size.width/2,
                                              (rect.size.height/2)-boundingRect.size.height/2)
                   withAttributes:attributes];
}

- (CGRect)borderRectForBounds:(CGRect)bounds
{
    return CGRectMake(0,
               self.frame.size.height-3,
               self.frame.size.width,
               1);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
