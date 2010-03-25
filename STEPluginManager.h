//
//  ATEPluginManager.h
//  AwesomeTextEditor
//
//  Created by Steven Degutis on 3/24/10.
//  Copyright 2010 Big Nerd Ranch, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface STEPluginManager : NSObject {

}

+ (STEPluginManager*) sharedManager;

- (BOOL) setupPythonEnvironment;

- (BOOL) loadScriptAtPath:(NSString*)scriptPath runFunction:(NSString*)functionName withArguments:(NSArray*)arguments;

@end
