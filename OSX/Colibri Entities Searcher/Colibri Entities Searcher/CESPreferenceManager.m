//
//  CESPreferenceManager.m
//  Colibri Entities Searcher
//
//  Created by Luis Portela Afonso on 2/5/13.
//  Copyright (c) 2013 Brindigrafica. All rights reserved.
//

#import "CESPreferenceManager.h"

@implementation CESPreferenceManager

+ (NSString *)getSQLServerHostname
{
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLHostname"];
}

+ (NSInteger *)getSQLServerPort
{
	return (NSInteger*)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLPort"];
}

+ (NSString *)getSQLServerUsername
{
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLUsername"];
}

+ (NSString *)getSQLServerPassword
{
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLPassword"];
}

+ (NSString *)getSQLDatabase
{
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLDatabase"];
}

+ (NSString *)getSQLTable
{
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLTable"];
}

+ (NSArray *)getSQLTableFields
{
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CESSQLTableFields"];
}

@end
