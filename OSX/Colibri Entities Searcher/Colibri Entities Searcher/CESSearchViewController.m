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
		
		[[self view] setAutoresizesSubviews:YES];
//		[[self view] setAutoresizingMask: (NSUInteger)self.view.frame.size.width | (NSUInteger)self.view.frame.size.height];
//		NSLog(@"AutoResizingMask: %lu", (unsigned long)self.view.autoresizingMask);
//		[[self view] setNeedsDisplay:YES];

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

- (NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize
{
	NSLog(@"New size -> Width: %f | Height: %f", frameSize.width, frameSize.height);
	NSLog(@"Frame size -> Width: %f | Height: %f", self.view.frame.size.width, self.view.frame.size.height);
	NSLog(@"Bounds size -> Width: %f | Height: %f", self.view.bounds.size.width, self.view.bounds.size.height);
	
//	[[self view] setBoundsSize:frameSize];
//	[[self view] setFrameSize:frameSize];
	
	return  frameSize;
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
	
	nonFilteredResults = [NSArray arrayWithArray:results];

	[cesContentArray addObjects:nonFilteredResults];
}

- (IBAction)cesSearchFieldChanged:(id)sender {
	
	NSLog(@"Text changed");
}

@end
