//
//  MyDocument.h
//  AwesomeTextEditor
//
//  Created by Steven Degutis on 3/24/10.
//  Copyright 2010 Big Nerd Ranch, Inc. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface STETextDocument : NSDocument {
	IBOutlet NSTextView *textView;
	NSString *loadedString;
}

@end
