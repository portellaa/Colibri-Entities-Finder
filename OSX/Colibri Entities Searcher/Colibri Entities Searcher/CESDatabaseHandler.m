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

- (void) disconnectFromDatabase
{
	if ([conn isConnected])
		[conn disconnect];
}

/**
 * Initiates the core of the MySQL connection process on a background thread.
 */
- (void)initiateMySQLConnection
{
	NSLog(@"Initiating connection to database...");
	
	conn = [[SPMySQLConnection alloc] init];
	
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
	
	NSLog(@"Attempting to connect to database...");
	
	// Connect
	[conn connect];
	
	if (![conn isConnected])
	{
		NSLog(@"ERROR: Failed to connect");
		
		[self.delegate didFailWithError: [conn lastErrorMessage]];
		
		return;
	}
	

	if (![conn selectDatabase: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLDatabase"]]) {
		
		NSLog(@"ERROR: Invalid database");
		
		[self.delegate didFailWithError: [conn lastErrorMessage]];
		
		[conn release];
		conn = nil;

		return;
	}
	
	[conn retain];
	[self.delegate didConnectToDatabase];
}

- (void) getResultsWithValue:(NSString*) value
{
	NSLog(@"Trying to get results!");
	
	NSString *formedQuery = [NSString stringWithFormat:@SQLCUSTOMQUERY, [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSLog(@"%@", formedQuery);
	
	[self performSelectorInBackground:@selector(performQuery:) withObject:formedQuery];

}

- (void)getAllResults
{
	
}

- (void) performQuery:(NSString *)query
{
	NSLog(@"Querying database from results");
	NSLog(@"Final query: %@", query);
	
	SPMySQLResult *results = [conn queryString:query];
	
	NSLog(@"Getted results. Number of rows: %llu", [results numberOfRows]);
	
	if ([results numberOfRows] > 0)
		[self.delegate queryDidReturnResults:[results getAllRows]];
}

- (void)showErrorWithTitle:(NSString *)title message:(NSString *)message
{
	NSLog(@"Error on database connection:\nTitle: %@\nMessage: %@", title, message);
}

- (void)queryGaveError:(NSString *)error connection:(id)connection
{
	NSLog(@"ERROR: An error happens when trying to execute query.\nERROR: %@", error);
}

@end
