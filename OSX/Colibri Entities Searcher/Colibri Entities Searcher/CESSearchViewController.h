//
//  CESSearchViewController.h
//  Colibri Entities Searcher
//
//  Created by Luis Portela Afonso on 2/3/13.
//  Copyright (c) 2013 Brindigrafica. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CESDatabaseHandler.h"

@interface CESSearchViewController : NSViewController<CESDatabaseConnectionDelegate>

@property (assign) IBOutlet NSSearchField *cesSearchField;
@property (assign) IBOutlet NSScrollView *cesSearchScrollView;
@property (assign) IBOutlet NSTableView *cesSearchTableView;
@property (assign) IBOutlet NSTextField *cesSearchClientNumberField;

@end
