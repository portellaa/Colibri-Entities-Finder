//
//  AppDelegate.m
//  Colibri Entities Searcher
//
//  Created by Luis Portela Afonso on 2/2/13.
//  Copyright (c) 2013 Brindigrafica. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize cesSearchViewController;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	cesSearchViewController = [[CESSearchViewController alloc] initWithNibName:@"CESSearchViewController" bundle:nil];
	CESDatabaseHandler *cesDBHandler = [[CESDatabaseHandler alloc] initWithDelegate:cesSearchViewController];
	
	[cesDBHandler connectToDatabase];
	
	[self.window setContentView: cesSearchViewController.view];
	[cesSearchViewController.view setFrame: ((NSView*)self.window.contentView).bounds];
}

@end
