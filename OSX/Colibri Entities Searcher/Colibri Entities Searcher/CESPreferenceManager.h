//
//  CESPreferenceManager.h
//  Colibri Entities Searcher
//
//  Created by Luis Portela Afonso on 2/5/13.
//  Copyright (c) 2013 Brindigrafica. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CESPreferenceManager : NSObject


+ (NSString*)getSQLServerHostname;
+ (NSInteger*)getSQLServerPort;
+ (NSString*)getSQLServerUsername;
+ (NSString*)getSQLServerPassword;
+ (NSString*)getSQLDatabase;
+ (NSString*)getSQLTable;
+ (NSArray*)getSQLTableFields;

@end
