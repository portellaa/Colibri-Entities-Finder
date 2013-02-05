//
//  CESSearchViewController.m
//  Colibri Entities Searcher
//
//  Created by Luis Portela Afonso on 2/3/13.
//  Copyright (c) 2013 Brindigrafica. All rights reserved.
//

#import "CESSearchViewController.h"

@interface CESSearchViewController ()

@end

@implementation CESSearchViewController

@synthesize cesSearchClientNumberField, cesSearchField, cesSearchScrollView, cesSearchTableView, cesDBConnHandler, cesSearchTableHeaderView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//		cesSearchTableView tableColumns
    }
    
    return self;
}


- (void)didConnectToDatabase
{
	NSLog(@"Connected to database");
	[cesSearchField setEnabled:YES];
}

- (void)didFailWithError:(NSString *)error
{
	NSLog(@"Failed to connect.\nError: %@", error);
}

- (void) queryDidReturnResults:(NSArray *)results
{
	
}

- (IBAction)cesSearchFieldChanged:(id)sender {
	
	NSLog(@"Text changed");
	if ([[cesSearchField stringValue] length])
	{
		NSLog(@"Text on search field: %@", [cesSearchField stringValue]);
		NSLog(@"Querying database...");
		
		[cesDBConnHandler getResultsWithValue:[cesSearchField stringValue]];
	}

}
@end
