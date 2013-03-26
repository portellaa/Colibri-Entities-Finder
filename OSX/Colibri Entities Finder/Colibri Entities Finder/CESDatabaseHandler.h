//
//  CESDatabaseConnection.h
//  Colibri Entities Searcher
//
//  Created by Luis Portela Afonso on 2/3/13.
//  Copyright (c) 2013 Brindigrafica. All rights reserved.
//

#define SQLALLRESULTSQUERY "SELECT NUMERO, NOME, NIF, NIB, TELEFONE, TELEFONE2, TELEMOVEL, EMAIL, EMAIL2, FAX, NOMEBANCO, LOCALIDADE, MORADA, OBS FROM ENTIDADES"

#define SQLCUSTOMQUERY "SELECT NUMERO, NOME, NIF, NIB, TELEFONE, TELEFONE2, TELEMOVEL, EMAIL, EMAIL2, FAX, NOMEBANCO, LOCALIDADE, MORADA, OBS FROM ENTIDADES WHERE NUMERO LIKE '%%%1$@%%' OR NOME LIKE '%%%1$@%%' OR NIF LIKE '%%%1$@%%' OR NIB LIKE '%%%1$@%%' OR TELEFONE LIKE '%%%1$@%%' OR TELEFONE2 LIKE '%%%1$@%%' OR TELEMOVEL LIKE '%%%1$@%%' OR EMAIL LIKE '%%%1$@%%' OR EMAIL2 LIKE '%%%1$@%%' OR FAX LIKE '%%%1$@%%' OR NOMEBANCO LIKE '%%%1$@%%' OR LOCALIDADE LIKE '%%%1$@%%' OR MORADA LIKE '%%%1$@%%' OR OBS LIKE '%%%1$@%%'"

#import <Foundation/Foundation.h>
#import <SPMySQL/SPMySQL.h>
#import "CESPreferenceManager.h"

@protocol CESDatabaseConnectionDelegate;

@interface CESDatabaseHandler : NSObject<SPMySQLConnectionDelegate>
{
	SPMySQLConnection *conn;
}

@property(retain) id<CESDatabaseConnectionDelegate> delegate;


- (id) initWithDelegate: (id)aDelegate;
- (void) connectToDatabase;
- (void) disconnectFromDatabase;
- (void) getResultsWithValue:(NSString*) value;

- (void) getAllResults;

@end

@protocol CESDatabaseConnectionDelegate

- (void) didConnectToDatabase;
- (void) didFailWithError: (NSString*)error;
- (void) queryDidReturnResults: (NSArray *)results;

@end
