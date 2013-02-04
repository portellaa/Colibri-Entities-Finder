//
//  CESDatabaseConnection.h
//  Colibri Entities Searcher
//
//  Created by Luis Portela Afonso on 2/3/13.
//  Copyright (c) 2013 Brindigrafica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SPMySQL/SPMySQL.h>

@protocol CESDatabaseConnectionDelegate;

@interface CESDatabaseHandler : NSObject<SPMySQLConnectionDelegate>
{
	SPMySQLConnection *conn;
}

@property(retain) id<CESDatabaseConnectionDelegate> delegate;


- (id) initWithDelegate: (id)aDelegate;
- (void) connectToDatabase;

@end

@protocol CESDatabaseConnectionDelegate

- (void) didConnectToDatabase;
- (void) didFailWithError: (NSError*)error;

@end
