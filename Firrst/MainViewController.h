//
//  MainViewController.h
//  Firrst
//
//  Created by Trevor Grayson on 12/12/11.
//  Copyright (c) 2011 Ipsum LLC. All rights reserved.
//

#import "FlipsideViewController.h"
#import <CoreData/CoreData.h>
#import "AppModel.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UILabel *shortLink;

- (IBAction)showInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *longURL;

-(void) retreiveAndUpdateShortLink;

@end
