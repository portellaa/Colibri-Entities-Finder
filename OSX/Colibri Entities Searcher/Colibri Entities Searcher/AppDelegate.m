//
//  AppDelegate.m
//  Colibri Entities Searcher
//
//  Created by Luis Portela Afonso on 2/2/13.
//  Copyright (c) 2013 Brindigrafica. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize cesSearchViewController, cesDBHandler, window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	NSLog(@"Starting application...");
	
	cesSearchViewController = [[[CESSearchViewController alloc] initWithNibName:@"CESSearchViewController" bundle:nil] autorelease];
	cesDBHandler = [[[CESDatabaseHandler alloc] initWithDelegate:cesSearchViewController] autorelease];
	
	NSLog(@"Trying to connect to database...");
	[cesDBHandler connectToDatabase];
	
	NSLog(@"Setting database connection handler to view controller");
	[cesSearchViewController setCesDBConnHandler:cesDBHandler];
	
	NSLog(@"Adding view to main window");
	[self.window setContentView: cesSearchViewController.view];
	[cesSearchViewController.view setFrame: ((NSView*)self.window.contentView).bounds];
	
//	[window setDelegate:cesSearchViewController];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	NSLog(@"Terminating application...");
	[cesDBHandler disconnectFromDatabase];
}

- (NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize
{
	NSLog(@"New size -> Width: %f | Height: %f", frameSize.width, frameSize.height);
	
	return  frameSize;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}



@end
