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
		tableHeaders = [CESPreferenceManager getSQLTableFields];
		[tableHeaders retain];
		isConnected = NO;
    }
    
    return self;
}

- (void)loadView
{
	[super loadView];
	
	int i = 0;
	
	for (NSTableColumn *col in [cesSearchTableView tableColumns])
	{
		NSLog(@"Table Field pos %d, %@", i, [tableHeaders objectAtIndex:i]);
		[col setIdentifier: [tableHeaders objectAtIndex:i]];
		[col setHeaderCell:[[[NSTableHeaderCell alloc] initTextCell:[tableHeaders objectAtIndex:i]] autorelease]];
		
		[col bind:@"value" toObject:cesContentArray withKeyPath:[NSString stringWithFormat:@"arrangedObjects.%@", [tableHeaders objectAtIndex:i]] options:nil];
		
		i++;
	}
	
}


- (void)didConnectToDatabase
{
	NSLog(@"Connected to database");
	[cesSearchField setEnabled:YES];
	isConnected = YES;
	
	[cesDBConnHandler getAllResults];
}

- (void)didFailWithError:(NSString *)error
{
	NSLog(@"Failed to connect.\nError: %@", error);
}

- (void) queryDidReturnResults:(NSArray *)results
{
	NSLog(@"Query returned %ld results", (unsigned long)[results count]);

	[cesContentArray addObjects:results];
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
