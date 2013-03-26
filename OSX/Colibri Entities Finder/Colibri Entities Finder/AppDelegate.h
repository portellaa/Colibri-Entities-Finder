//
//  AppDelegate.h
//  Colibri Entities Searcher
//
//  Created by Luis Portela Afonso on 2/2/13.
//  Copyright (c) 2013 Brindigrafica. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CESSearchViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) IBOutlet CESSearchViewController *cesSearchViewController;
@property (assign) CESDatabaseHandler *cesDBHandler;

- (IBAction)openPreferences:(id)sender;

@end
