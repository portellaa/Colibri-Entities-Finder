//
//  AppDelegate.h
//  Colibri Entities Searcher
//
//  Created by Luis Portela Afonso on 2/2/13.
//  Copyright (c) 2013 Brindigrafica. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSSearchField *searchBar;
@property (assign) IBOutlet NSBox *clientNumberBox;
@property (assign) IBOutlet NSTextField *clientNumberLabel;

@property (assign) IBOutlet NSTableView *resultTableView;

@end
