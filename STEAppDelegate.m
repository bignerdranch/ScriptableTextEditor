//
//  ATEAppDelegate.m
//  AwesomeTextEditor
//
//  Created by Steven Degutis on 3/24/10.
//  Copyright 2010 Big Nerd Ranch, Inc. All rights reserved.
//

#import "STEAppDelegate.h"

#import "STEPluginManager.h"

@implementation STEAppDelegate

// when we finish launching, try to launch our python interface
- (void) applicationDidFinishLaunching:(NSNotification *)notification {
	if (![[STEPluginManager sharedManager] setupPythonEnvironment])
		NSLog(@"error: python environment could not be set up.");
}

// get all files on the desktop that have the .py extension
- (NSArray*) validScriptFiles {
	// use the desktop for our simple purposes
	NSString *desktopPath = [@"~/Desktop" stringByStandardizingPath];
	
	// get all files on the desktop
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *desktopFiles = [fileManager contentsOfDirectoryAtPath:desktopPath
															 error:NULL];
	
	NSMutableArray *paths = [NSMutableArray array];
	
	// only find files that have .py extension, and add their full filenames
	for (NSString *desktopFile in desktopFiles)
		if ([[desktopFile pathExtension] caseInsensitiveCompare: @"py"] == NSOrderedSame)
			[paths addObject:[desktopPath stringByAppendingPathComponent:desktopFile]];
	
	// sort files alphabetically by their filename
	[paths sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		id name1 = [[obj1 lastPathComponent] stringByDeletingPathExtension];
		id name2 = [[obj1 lastPathComponent] stringByDeletingPathExtension];
		return [name1 caseInsensitiveCompare: name2];
	}];
	
	return paths;
}

// when the Scripts menu is being shown, show the list of available scripts
- (void)menuNeedsUpdate:(NSMenu*)menu {
	[menu removeAllItems];
	
	for (NSString *fullPath in [self validScriptFiles]) {
		// add a menu item for each script
		NSString *scriptTitle = [[[fullPath lastPathComponent] stringByDeletingPathExtension] capitalizedString];
		
		// our document subclass implements the -runScript: selector
		NSMenuItem *item = [[[NSMenuItem alloc] initWithTitle:scriptTitle
													   action:@selector(runScript:)
												keyEquivalent:@""] autorelease];
		
		[item setRepresentedObject:fullPath];
		
		[menu addItem:item];
	}
	
	if ([menu numberOfItems] == 0) {
		NSMenuItem *item = [[[NSMenuItem alloc] initWithTitle:@"No Scripts"
													   action:NULL
												keyEquivalent:@""] autorelease];
		[menu addItem:item];
	}
}

@end
