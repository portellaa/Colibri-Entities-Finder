//
//  CESDatabaseConnection.m
//  Colibri Entities Searcher
//
//  Created by Luis Portela Afonso on 2/3/13.
//  Copyright (c) 2013 Brindigrafica. All rights reserved.
//

#import "CESDatabaseHandler.h"

@implementation CESDatabaseHandler

- (id)initWithDelegate:(id)aDelegate
{
	self = [super init];
	
	if (self)
		[self setDelegate:aDelegate];
	
	return self;
}

/*
 * Create a connection with the MySQL database server
 */
- (void)connectToDatabase
{
	//TODO make some tests
	
//	[NSThread detachNewThreadSelector:@selector(initiateMySQLConnection) toTarget:self withObject:nil];
	[self performSelectorInBackground:@selector(initiateMySQLConnection) withObject:nil];
}

/**
 * Initiates the core of the MySQL connection process on a background thread.
 */
- (void)initiateMySQLConnection
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	conn = [[SPMySQLConnection alloc] init];
	
	//TODO: Use values stored on the preferences file
	[conn setHost: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLHostname"]];
	[conn setUsername: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLUsername"]];
	[conn setPassword: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLPassword"]];
	[conn setUseSocket:NO];
	[conn setUseSSL:NO];
	
	
	// Connection delegate must be set before actual connection attempt is made
	[conn setDelegate:self];
	
	
	// Set options from preferences
	[conn setTimeout:15];
	[conn setUseKeepAlive:YES];
	[conn setKeepAliveInterval:10.0];
	
	// Connect
	[conn connect];
	

	if (![conn selectDatabase: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLDatabase"]]) {
		
		[conn release];
		conn = nil;

		return;
	}
	
	[self.delegate didConnectToDatabase];
	
	[pool release];
}

@end
