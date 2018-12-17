//
//  FourthViewController.m
//  Logic Circuits
//
//  Created by woodcol on 12-11-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FourthViewController.h"

@implementation FourthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Abort ME", @"Abort Me");
         self.tabBarItem.image = [UIImage imageNamed:@"second"];
    
        text.editable = NO;
    
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    text.editable = NO;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

@end
