//
//  MyDocument.m
//  AwesomeTextEditor
//
//  Created by Steven Degutis on 3/24/10.
//  Copyright 2010 Big Nerd Ranch, Inc. All rights reserved.
//

#import "STETextDocument.h"

#import "STEPluginManager.h"

@implementation STETextDocument

// MARK: -
// MARK: Boring NSDocument stuff

- (NSString *)windowNibName {
    return @"TextDocument";
}

- (void) dealloc {
	[loadedString release];
	[super dealloc];
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController {
	[super windowControllerDidLoadNib:aController];

	if (loadedString) {
		[[[textView textStorage] mutableString] setString:loadedString];
		[loadedString release], loadedString = nil;
	}
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
	if (outError != NULL)
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];

	return [[textView string] dataUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
	loadedString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    if (outError != NULL)
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];

    return (loadedString != nil);
}

// MARK: -
// MARK: The FUN part!

- (IBAction) runScript:(NSMenuItem*)sender {
	// fetch the path from where our app delegate stored it
	NSString *path = [sender representedObject];

	STEPluginManager *pluginManager = [STEPluginManager sharedManager];
	BOOL success = [pluginManager loadScriptAtPath:path
									   runFunction:@"main"
									 withArguments:[NSArray arrayWithObject:textView]];

	if (!success)
		NSRunAlertPanel(@"Script Failed", @"The script could not be completed.", nil, nil, nil);
}

@end
