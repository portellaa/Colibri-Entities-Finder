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

@synthesize cesSearchField, cesSearchScrollView, cesSearchTableView, cesDBConnHandler, cesSearchTableHeaderView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		tableHeaders = [CESPreferenceManager getSQLTableFields];
		[tableHeaders retain];
		isConnected = NO;
		
		[cesSearchTableView setAllowsMultipleSelection:NO];

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
	
	[cesSearchTableView setDelegate:self];
	
}

- (void)didConnectToDatabase
{
	NSLog(@"Connected to database");
	
	[cesDBConnHandler getAllResults];
}

- (void)didFailWithError:(NSString *)error
{
	NSLog(@"Failed to connect.\nError: %@", error);
}

- (void) queryDidReturnResults:(NSArray *)results
{
	NSLog(@"Query returned %ld results", (unsigned long)[results count]);
	
	nonFilteredResults = [NSArray arrayWithArray:results];
	[nonFilteredResults retain];

	[cesContentArray addObjects:nonFilteredResults];
	[cesSearchTableView setEnabled:YES];
	[cesSearchField setEnabled:YES];
	
	[cesSearchField becomeFirstResponder];
	
	[cesSearchTableView deselectAll:cesSearchTableView];
}


- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
	
	NSLog(@"Table View Selected Index: %ld", [cesSearchTableView selectedRow]);
	
	if ([cesSearchTableView selectedRow] < 0)
	{
		NSLog(@"Invalid index value");
		return ;
	}
	

	NSDictionary *dictIndex = [[cesContentArray arrangedObjects] objectAtIndex:[cesSearchTableView selectedRow]];
	NSArray *clipboardObjects = [NSArray arrayWithObject:[dictIndex valueForKey:@"NUMERO"]];

	NSPasteboard *clipboard = [NSPasteboard generalPasteboard];
	[clipboard clearContents];
	
	NSLog(@"Selected client: %@", [clipboardObjects objectAtIndex:0]);
	
	BOOL result = [clipboard writeObjects: clipboardObjects];
	
	if (result)
		NSLog(@"Copied? %c", (BOOL)result);
	else NSLog(@"Not Copied");
	
}

@end
