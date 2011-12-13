//
//  MainViewController.m
//  Firrst
//
//  Created by Trevor Grayson on 12/12/11.
//  Copyright (c) 2011 Ipsum LLC. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController
@synthesize longURL = _longURL;
@synthesize shortLink = _shortLink;

@synthesize managedObjectContext = _managedObjectContext;


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self retreiveAndUpdateShortLink];
    [textField resignFirstResponder];
    
    return YES;
}

-(void)retreiveAndUpdateShortLink{
    //Hit service
    //Update self.shortLink
    self.shortLink.text = [[FirrstLink sharedModel] makeThisURLShort:self.longURL.text];
}



/*******************
 * Boiler Plate
 *******************/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setShortLink:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

@end
