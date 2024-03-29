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
@synthesize shortTextView = _shortTextView;
@synthesize shortLink = _shortLink;

@synthesize managedObjectContext = _managedObjectContext;

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSURL *url = [FirrstLink validateURL: textField.text];
    if (url == nil) {
        return NO;
    }
    [textField resignFirstResponder];
    [FirrstLink shortenURLAsynchronous:url onComplete:^(NSString *shortUrl) {
        self.shortTextView.text = shortUrl;
        self.shortLink.text = shortUrl;
    }];
    return YES;
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
    [self setShortTextView:nil];
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

// Allow them to exit the text box by touching off the keyboard.
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.longURL resignFirstResponder];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

@end
