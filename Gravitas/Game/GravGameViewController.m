//
//  GravGameViewController.m
//  Gravitas
//
//  Created by Zachary Marcantel on 11/10/13.
//  Copyright (c) 2013 Zachary Marcantel. All rights reserved.
//

#import "GravGameViewController.h"

@interface GravGameViewController ()

@end

@implementation GravGameViewController

//--------------------------------------------------------------
//
// Controller Initialization
//
//--------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Initializing game.");
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.view.context = context;
    self.view.delegate = self;
    
    UISwipeGestureRecognizer *swipeLeftGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    [self.view addGestureRecognizer:swipeLeftGesture];
    swipeLeftGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------
//
// View Transitions
//
//--------------------------------------------------------------

- (IBAction) unwindToGame:(UIStoryboardSegue *)segue
{
    // setup things when coming to game view from edit mode
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

-(void)handleSwipeGesture:(UIGestureRecognizer *) sender
{
    NSUInteger touches = sender.numberOfTouches;
    if (touches == 1)
    {
        if (sender.state == UIGestureRecognizerStateEnded)
        {
            [self performSegueWithIdentifier:@"editModeSegue" sender:sender];
        }
    }
}

- (IBAction) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

//--------------------------------------------------------------
//
// OpenGL Functions
//
//--------------------------------------------------------------

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    glClearColor((56.0/255.0), (215.0/255.0), 1.0f, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
}

@end
